# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/scope.rb";
require File.dirname(__FILE__)+"/nes.rb";

module Asm
end
class Asm::Compiler
	def initialize()
		@scope = Asm::Scope.new()
	end
	def readTree(tree_list)
		@scope.appendRoutines(tree_list);
	end
	def compile()
		for routine in @scope.routines
			routine.prepare @scope
		end
		obj = [];
		for routine in @scope.routines
			obj += routine.to_bin(@scope)
		end
		codeList = [::Asm::Nes::Code.new(obj, 0, 0, 0)]
		return ::Asm::Nes::Linker.new(codeList, nil);
	end
end