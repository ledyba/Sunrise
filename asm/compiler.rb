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
	def fix()
		fairy = @scope.fairy;
		puts "fixing..."
		@scope.fairy.reset
		for routine in @scope.routines
			fairy.start(routine);
			routine.prepare(fairy)
		end
	end
	def compile(chrfilename)
		begin
			fix();
		end while !@scope.fairy.allFixed;
		fix()
		@scope.fixRoutines();
		obj = [];
		_total_size = 0;
		for routine in @scope.routines
			offset = @scope.fairy.resolveOffset(routine);
			delta = offset - obj.size;
			if delta != 0
				raise "[BUG] FIXME delta: #{delta}"
			end
			robj = routine.to_bin(@scope);
			puts "#{routine.to_s} size: #{robj.size} bytes, offset: 0x#{offset.to_s(16)}"
			_total_size+=robj.size;
			obj += robj;
		end
		puts "total size: #{_total_size} bytes"
		codeList = [::Asm::Nes::Code.new(@scope, obj)]
		resList = [File.binread(chrfilename).unpack("C*")]; #FIXME:
		return ::Asm::Nes::Linker.new(codeList, resList);
	end
end
