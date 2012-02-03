# -*- encoding: utf-8 -*-
module Asm
end
class Asm::Code
	def initialize(scope, obj)
		@scope = scope;
		@obj = obj;
	end
	attr_accessor :scope, :obj
	protected :scope, :obj
	def save(fname)
		File.binwrite(fname, to_a().pack("C*"))
	end
	def to_a
		raise "Not implemented"
	end
end

