# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/scope.rb";
require File.dirname(__FILE__)+"/code.rb";

module Asm
end
class Asm::Linker
	def initialize(codeList, resList)
		@codeList = codeList || [];
		@resList = resList || [];
	end
	attr_accessor :codeList, :resList
	protected :codeList, :resList
	def save(fname)
		File.binwrite(fname, to_a().pack("C*"))
	end
	def to_a
		raise "Not implemented"
	end
end

