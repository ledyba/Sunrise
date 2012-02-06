# -*- encoding: utf-8 -*-
module ParserInner
end
module ParserInner::Tree
	class AbstractNode
		def to_s
			raise "Must implement: #{self.class}"
		end
		def to_bin(scope)
			raise "Must implement: #{self.class}"
		end
		def inspect
			raise "Must implement: #{self.class}"
		end
	end

	class OperatorNode < AbstractNode
		def prepare(fairy)
			raise "Must implement: #{self.class}"
		end
	end
	class ExprNode < AbstractNode
		def initialize(needResolve)
			@needResolve = needResolve
		end
		attr_reader :needResolve
	end
	
	class OperandArgNode < ExprNode
	end
	
	class ImmediateNode < OperandArgNode
		def initialize(number_str, show_str, radix)
			super(false);
			@num = number_str.to_i(radix);
			@str = show_str;
			@bin = nil
			@def_type = nil
			case radix
			when 2
				if number_str.size <= 8
					@def_type = :word
				elsif number_str.size <= 16
					@def_type = :dword
				end
			when 10
				if @num <= 256
					@def_type = :word
				elsif @num <= 256**2
					@def_type = :dword
				end
			when 16
				if number_str.size <= 2
					@def_type = :word
				elsif number_str.size <= 4
					@def_type = :dword
				end
			end
			raise "Invalid immediate: #{to_s}" if @def_type.nil?
		end
		def to_s()
			return @str;
		end
		def to_i()
			return @num;
		end
		def to_bin(scope, as = nil)
			if as.nil?
				as = @def_type
			end
			case as
			when :word
				return to_word
			when :dword
				return to_dword
			end
			return @bin
		end
		def to_word
			return [@num & 0xff];
		end
		def to_dword
			return [@num & 0xff, (@num >> 8) & 0xff];
		end
		def inspect()
			return "<Immediate: #{@str}(#{@num})>";
		end
		ZERO = ImmediateNode.new("0","0",16)
	end
	class IdentiferNode < OperandArgNode
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
	class StringNode < ExprNode
		def initialize(string)
			super(false);
			@str = string;
			@obj = @str.unpack("C*");
		end
		def to_s
			return @str.to_s
		end
		def to_sym
			return @str.to_sym
		end
		def to_bin(scope)
			return @obj;
		end
		def inspect
			return "<String: \"#{@str}\">";
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
		def to_bin(scope)
			obj = [];
			for node in @nodes
				obj += node.to_bin(scope)
			end
			return obj
		end
		def size
			@nodes.size;
		end
		def [](idx)
			@nodes[idx];
		end
		def each(&block)
			@nodes.each(&block);
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
				raise "Invalid type: #{op.class}" unless op.is_a? OperatorNode
			}
		end
		def prepare(fairy)
			for op in @ops
				op.prepare fairy
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
		def fix_addr(addr)
			@addr = addr
		end
		def to_addr
			@addr;
		end
	end
end
