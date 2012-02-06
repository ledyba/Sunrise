# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::PseudoOperator
	class AbstractPseudoOperator < ::ParserInner::Tree::OperatorNode
	end
	def self.create(code, exprList = nil)
		sym = code.to_s.upcase.to_sym
		unless COMMAND_TABLE.has_key? sym
			raise "Unkwown pseudo operator: #{sym}"
		end
		return COMMAND_TABLE[sym].new(sym, exprList);
	end
	class CommandOperator < AbstractPseudoOperator
		def initialize(code, exprList = nil)
			@code = code;
			@exprList = exprList;
			init();
		end
		def init()
			raise "Not implemented: #{self.code}"
		end
		attr_accessor :code, :exprList
		protected :code, :exprList
		def to_s
			"CMD: #{@code.to_s}"
		end
		def inspect
			"CMD: #{@code.to_s} with #{@exprList.inspect}"
		end
		def prepare(fairy)
		end
		def to_bin(scope)
			[]
		end
	end
end

require File.dirname(__FILE__)+"/pseudo_operator_commands.rb";
