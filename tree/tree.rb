# -*- encoding: utf-8 -*-
module ParserInner
end
module ParserInner::Tree
	class AbstractNode
		def to_s
			raise "Must implement"
		end
		def to_bin(scope)
			raise "Must implement"
		end
		def inspect
			raise "Must implement"
		end
	end

	class OperatorNode < AbstractNode
		def prepare(scope)
			raise "Must implement"
		end
	end
	class ExprNode < AbstractNode
		def initialize(canReduce)
			@canReduce = canReduce;
		end
		attr_reader :canReduce
	end

	class ImmediateNode < ExprNode
		def initialize(number_str, radix)
			super(false);
			@num = number_str.to_i(radix);
			@str = number_str;
			unless is_dword
				raise "Immediate: #{number_str} is too big for 6502."
			end
		end
		def to_s()
			return @str;
		end
		def to_i()
			return @num;
		end
		def to_bin(scope, as = :word)
			if is_word() && as == :word
				return [@num & 0xff];
			elsif as == :dword
				return [@num & 0xff, (@num >> 8) & 0xff];
			else
				raise "Invalid bin type: #{as} for #{inspect()}"
			end
		end
		def is_word()
			return @num < 256;
		end
		def is_dword()
			return @num < 65536;
		end
		def inspect()
			return "<Immediate: #{@str}(#{@num})>";
		end
		def compile()
			
		end
	end
	class IdentiferNode < ExprNode
		def initialize(sym)
			super(true);
			@sym = sym;
		end
		def to_s
			return @sym.to_s
		end
		def to_sym
			return @sym
		end
		def inspect
			return "<Ident: \"#{@sym}\">";
		end
	end
	class ExprListNode < AbstractNode
		def initialize(first = nil)
			@nodes = [];
			appendPre(first) unless first.nil?
		end
		def appendPre(node)
			raise "Invalid type" unless node.is_a? ExprNode
			@nodes.unshift node;
		end
		def to_s
			return "<ExprList: #{@nodes.inspect}";
		end
		def inspect
			to_s
		end
	end
	class RoutineNode < OperatorNode
		def initialize(name, ops)
			raise "Routine name must be specified" if name.nil?
			@name = name;
			@ops = ops;
			@ops.each{|op|
				raise "Invalid type" unless op.is_a? OperatorNode
			}
		end
		def prepare(scope)
			for op in @ops
				op.prepare scope
			end
		end
		def to_bin(scope)
			obj = [];
			for op in @ops
				obj += op.to_bin(scope)
			end
			return obj
		end
		def nameIdent
			return @name
		end
		def to_s
			return "Routine: #{@name.inspect}";
		end
		def to_sym
			return @name.to_sym;
		end
		def inspect
			return "Routine: \"#{@name}\" -> #{@ops.inspect}";
		end
	end
end
