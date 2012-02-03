# -*- encoding: utf-8 -*-
module Asm
end
class Asm::Code
	def initialize(obj, entry_point, nmi_handler, irq_handler)
		@obj = obj;
	end
	attr_accessor :obj
	protected :obj
	def save(fname)
		File.binwrite(fname, to_a().pack("C*"))
	end
	def to_a
		raise "Not implemented"
	end
end

