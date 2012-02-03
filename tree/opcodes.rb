# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
require File.dirname(__FILE__)+"/operands.rb";
require File.dirname(__FILE__)+"/opcode_info.rb"
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::Opcode
	def self.create(name, operand)
		upper_sym = name.to_s.upcase.to_sym;
		op_type = operand.type
		unless NORMAL_OPCODE_TABLE.has_key?(upper_sym) || JUMP_OPCODE_TABLE.has_key?(upper_sym)
			raise "Unknown opecode: \"#{upper_sym}\""
		end
		if NORMAL_OPCODE_TABLE.has_key? upper_sym
			table = NORMAL_OPCODE_TABLE[upper_sym];
			if !table.has_key?(op_type) || table[op_type].nil?
				raise "Invalid operand type: #{op_type} for \"#{upper_sym}\""
			end
			return NormalOpcode.new(upper_sym, table[op_type], operand);
		else
			table = JUMP_OPCODE_TABLE[upper_sym];
			if !table.has_key?(op_type) || table[op_type].nil?
				raise "Invalid operand type: #{op_type} for \"#{upper_sym}\""
			end
			return JumpOpcode.new(upper_sym, table[op_type], operand);
		end
	end

	class AbstractOpcode < ::ParserInner::Tree::OperatorNode
		def initialize(type, min_size, max_size)
			@type = type;
			@min_size = min_size;
			@max_size = max_size;
		end
		attr_reader :type, :max_size, :min_size;
	end

	class NormalOpcode < AbstractOpcode
		def initialize(name, byte, operand)
			#命令は増減しない。
			super(:normal, operand.size+1, operand.size+1);
			@name = name;
			@byte = byte;
			@operand = operand;
		end
		def to_s
			return inspect
		end
		def inspect
			if @operand.nil?
				return "OP: #{@name}(0x#{@byte.to_s(16)})"
			else
				return "OP: #{@name}(0x#{@byte.to_s(16)}) #{@operand.inspect}"
			end
		end
		def prepare(scope, state)
			state.forward self.min_size,self.max_size
		end
		def to_bin(scope, state)
			return [@byte, *@operand.to_bin(scope, state)]
		end
	end
	class JumpOpcode < AbstractOpcode
		REPLACE_OP=::ParserInner::Tree::Operand::ImmediateOperand.new(::ParserInner::Tree::ImmediateNode.new("0", 16));
		def initialize(name, byte, operand)
			#最小：このジャンプ命令だけ
			#最大：反転ジャンプ命令＋絶対ジャンプ
			super(:jump, operand.size+1, operand.size+1+(1+2));
			@name = name;
			@byte = byte;
			@operand = operand;
		end
		def prepare(scope, state)
			if @operand.node.needResolve
				state.forward self.min_size, self.min_size
				dist = state.resolveDistance(@operand.node)
				if !dist.nil? && -128 <= dist && dist <= 127
				else
					state.forward 0,self.max_size-self.min_size
				end
			else
				state.forward self.min_size, self.min_size
			end
		end
		def to_bin(scope, state)
			if @operand.node.needResolve
				dist = state.resolveDistance(@operand.node);
				if -128 <= dist && dist <= 127
					return to_bin_raw(dist)
				else
					new_op = ParserInner::Tree::Opcode::create(JUMP_INVERT_TABLE[@name.to_sym], REPLACE_OP);
					jmp_op = ParserInner::Tree::Opcode::create(:JMP, ParserInner::Tree::Operand::AbsoluteOperand.new(@operand.node));
					return new_op.to_bin_raw(3) + jmp_op.to_bin(scope, state)
				end
			else
				return to_bin_raw(@operand.node.to_i()-self.min_size);
			end
		end
		def to_bin_raw(dist)
			return [@byte, dist & 0xff]
		end
	end
end

