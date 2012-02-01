# -*- encoding: utf-8 -*-
module ParserInner
end
module ParserInner::PseudoOperator
	class CommandOperator
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

