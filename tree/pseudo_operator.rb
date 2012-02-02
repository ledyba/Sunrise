# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::PseudoOperator
	class AbstractPseudoOperator < ParserInner::Tree::OperatorNode
	end
	class CommandOperator < AbstractPseudoOperator
		def initialize(code, args = nil)
			@code = code;
			@args = args;
		end
		def to_s
			"CMD: #{@code.to_s}"
		end
		def inspect
			"CMD: #{@code.to_s} with #{@args.inspect}"
		end
	end
end

require File.dirname(__FILE__)+"/pseudo_operator_commands.rb";
