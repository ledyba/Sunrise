# -*- encoding: utf-8 -*-
module ParserInner
end
module ParserInner::Operand
	X = :X;
	Y = :Y;
	class AbstractOperand
		def initialize(type, size)
			@type = type
			@size = size
		end
		attr_reader :type, :size
	end
	class ImmediateOperand < AbstractOperand
		def initialize(node)
			super(:Immediate, 1);
			@node = node;
		end
		def to_s
			@node.to_s
		end
		def inspect
			"{Imm: #{@node.inspect}}"
		end
	end
	class AbsoluteOperand < AbstractOperand
		def initialize(node, register = nil)
			super(:Absolute, 2);
			@node = node;
			@reg = register;
			@type = (@type.to_s + @reg.to_s).to_sym() unless @reg.nil?
		end
		def to_s
			if @reg.nil?
				@node.to_s
			else
				"#{@node.to_s}, #{@reg}"
			end
		end
		def inspect
			if @reg.nil?
				"{Absolite: #{@node.inspect}}"
			else
				"{Absolite(#{@reg}): #{@node.inspect}}"
			end
		end
	end
	class ZeropageOperand < AbstractOperand
		def initialize(node, register = nil)
			super(:Zeropage, 1);
			@node = node;
			@reg = register;
			@type = (@type.to_s + @reg.to_s).to_sym() unless @reg.nil?
		end
		def to_s
			if @reg.nil?
				@node.to_s
			else
				"#{@node.to_s}, #{@reg}"
			end
		end
		def inspect
			if @reg.nil?
				"{Zero: #{@node.inspect}}"
			else
				"{Zero(#{@reg}): #{@node.inspect}}"
			end
		end
	end
	class IndirectOperand < AbstractOperand
		def initialize(node, register = nil)
			super(:Indirect, 1);
			@node = node;
			@reg = register;
			@type = (@type.to_s + @reg.to_s).to_sym() unless @reg.nil?
		end
		def to_s
			if @reg.nil?
				@node.to_s
			else
				"#{@node.to_s}, #{@reg}"
			end
		end
		def inspect
			if @reg.nil?
				"{Ind: #{@node.inspect}}"
			else
				"{Ind(#{@reg}): #{@node.inspect}}"
			end
		end
	end
end