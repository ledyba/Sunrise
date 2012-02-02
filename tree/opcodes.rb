# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
require File.dirname(__FILE__)+"/opcode_info.rb"
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::Opcode
	def self.create(name, operand)
		upper_sym = name.to_s.upcase.to_sym;
		op_type = operand.type || :nil
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
			return nil
		end
	end
	class AbstractOpcode
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
	end
	class JumpOpcode < AbstractOpcode
		def initialize(name, byte, operand)
			#最小：このジャンプ命令だけ
			#最大：反転ジャンプ命令＋絶対ジャンプ
			super(:jump, operand.size+1, operand.size+1+(1+2));
			@name = name;
			@byte = byte;
			@operand = operand;
		end
	end
end

