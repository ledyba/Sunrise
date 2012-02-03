# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/scope.rb";
require File.dirname(__FILE__)+"/nes.rb";

module Asm
end
class Asm::Compiler
	def initialize(namespace)
		@namespace = namespace;
		@scope = @namespace::Scope.new()
	end
	def <<(tree_list)
		@scope << tree_list;
	end
	def compile()
		fairy = @scope.fairy;
		for routine in @scope.routines
			fairy.start(routine);
			routine.prepare(fairy)
		end
		@scope.fairy.reset
		for routine in @scope.routines
			fairy.start(routine);
			routine.prepare(fairy)
		end
		@scope.fixRoutines();
		obj = [];
		for routine in @scope.routines
			offset = @scope.fairy.resolveOffset(routine);
			delta = offset - obj.size;
			if delta != 0
				raise "[BUG] FIXME delta: #{delta}"
			end
			robj = routine.to_bin(@scope);
			puts "#{routine.to_s} size: #{robj.size}"
			obj += robj;
		end
		codeList = [::Asm::Nes::Code.new(@scope, obj)]
		return ::Asm::Nes::Linker.new(codeList, nil);
	end
end