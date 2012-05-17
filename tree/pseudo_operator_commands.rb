# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
require File.dirname(__FILE__)+"/pseudo_operator.rb";
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::PseudoOperator
	def self.canBeString(expr)
	end
	COMMAND_TABLE = {
		#:Command => ClassName
		:SET_CONF => Class.new(CommandOperator) do
			def init()
				raise "You need 2 elements" unless @exprList.size == 2
				@key = @exprList[0]
				unless @key.is_a?(::ParserInner::Tree::IdentiferNode) || @key.is_a?(::ParserInner::Tree::StringNode)
					raise "Key must be String or Identifer"
				end
				@value = @exprList[1]
			end
			def prepare(fairy)
			end
			def to_bin(scope)
				scope.setConfig(@key, @value);
				[]
			end
		end,
		:SET_VAL => Class.new(CommandOperator) do
			def init()
				raise "You need 2 elements" unless @exprList.size == 2
				@key = @exprList[0]
				unless @key.is_a?(::ParserInner::Tree::IdentiferNode) || @key.is_a?(::ParserInner::Tree::StringNode)
					raise "Key must be String or Identifer"
				end
				@value = @exprList[1]
			end
			def prepare(fairy)
				if fairy.pass <= 1
					fairy.scope.appendConstant(@key, @value);
				end
			end
			def to_bin(scope)
				[]
			end
		end,
		:INCLUDE_BIN => Class.new(CommandOperator) do
			def init()
			end
			def prepare(fairy)
				if fairy.pass > 1
					@obj = [];
					for expr in @exprList
						@obj += expr.to_bin(fairy.scope);
					end
					fairy.forward(@obj.size, @obj.size)
				else
					fairy.forward(0, 0xffff)
				end
			end
			def to_bin(scope)
				return @obj
			end
		end,
	};
end