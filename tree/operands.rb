# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::Operand
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
			"{ImmOp: \"#{@node.inspect}\"}"
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
				"{AbsOp: \"#{@node.inspect}\"}"
			else
				"{AbsOp(#{@reg}): \"#{@node.inspect}\"}"
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
				"{ZeroOp: \"#{@node.inspect}\"}"
			else
				"{ZeroOp(#{@reg}): \"#{@node.inspect}\"}"
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
				"{IndOp: \"#{@node.inspect}}\""
			else
				"{IndOp(#{@reg}): \"#{@node.inspect}\"}"
			end
		end
	end
end