# -*- encoding: utf-8 -*-
module ParserInner
end
module ParserInner::Tree
	class ImmediateNode
		def initialize(number_str, radix)
			@num = number_str.to_i(radix);
			@str = number_str;
		end
		def to_s()
			return @str;
		end
		def inspect()
			return "<Immediate: #{@str}(#{@num})>";
		end
	end
	class IdentiferNode
		def initialize(sym)
			@sym = sym;
		end
		def to_s
			return @sym.to_s
		end
		def to_sym
			return @sym
		end
		def inspect
			return "<Ident: #{@sym}>";
		end
	end
	class ExprListNode
		def initialize(first = nil)
			@nodes = [];
			@nodes << first unless first.nil?
		end
		def append(node)
			@nodes << node;
		end
		def to_s
			return @nodes.to_s;
		end
		def inspect
			return "<ExprList: #{@nodes.inspect}>";
		end
	end
	class RoutineNode
		def initialize(name, ops)
			@name = name;
			@ops = ops;
		end
		def to_s
			return "Routine: #{@name.inspect}";
		end
		def to_sym
			if @name.nil?
				return nil;
			else
				return @name.to_sym;
			end
		end
		def inspect
			return "Routine: <#{@name.inspect}> -> #{@ops.inspect}";
		end
	end
end
