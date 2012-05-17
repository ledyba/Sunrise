# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
module ParserInner
end
module ParserInner::Tree
end
=begin
	アドレッシングモードを抽象化する、オペランドノード。
=end
module ParserInner::Tree::Operand
	X = :X;
	Y = :Y;
	class AbstractOperand
		def initialize(type, size, node)
			@type = type
			@size = size
			@node = node;
			raise "Invalid node:#{node.class}" unless node.nil? or node.is_a? ::ParserInner::Tree::OperandArgNode
		end
		attr_reader :type, :size, :node
		def to_s
			@node.to_s
		end
		def to_bin(scope)
			if @node.nil? || @size == 0
				return []
			end
			node = scope.resolveConstant(@node)
			if @size == 1
				return node.to_bin(scope, :word)
			elsif @size == 2
				return node.to_bin(scope, :dword)
			else
				raise "Invalid length: #{@size}"
			end
		end
	end
	class NilOperand < AbstractOperand
		def initialize()
			super(:nil, 0, nil);
		end
		def nil?
			return true;
		end
		def inspect
			"{NilOp}"
		end
		def to_s
			"{NilOp}"
		end
	end
	class ImmediateOperand < AbstractOperand
		def initialize(node)
			super(:Immediate, 1, node);
			@node = node;
		end
		def inspect
			"{ImmOp: \"#{@node.inspect}\"}"
		end
	end
	class AbsoluteOperand < AbstractOperand
		def initialize(node, register = nil)
			super(:Absolute, 2, node);
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
			super(:Zeropage, 1, node);
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
			super(:Indirect, 1, node);
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