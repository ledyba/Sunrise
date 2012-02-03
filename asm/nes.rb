# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/code.rb";
require File.dirname(__FILE__)+"/resource.rb";
require File.dirname(__FILE__)+"/linker.rb";
module Asm
end
module Asm::Nes
	NES_ROM_OFFSET = 0x8000;
end
class Asm::Nes::Scope < ::Asm::Scope
	def initialize()
		super(::Asm::Nes::NES_ROM_OFFSET);
	end
end
class Asm::Nes::Code < ::Asm::Code
	NES_ROM_SIZE = 32 * 1024-6;
	def initialize(scope, obj)
		super(scope, obj)
		@entry_point = resolveHandler(:entry_point)
		@nmi_handler = resolveHandler(:nmi_handler)
		@irq_handler = resolveHandler(:irq_handler)
		construct
	end
	private
	def resolveHandler(conf_name, default_name = nil)
		if default_name.nil?
			default_name = conf_name
		end
		conf = @scope.resolveConfig(conf_name);
		if conf.nil?
			addr = @scope.resolveRoutineAddr(default_name);
			if addr.nil?
				raise "routine: #{default_name} not found for #{conf_name}"
			end
		else
			addr = @scope.resolveRoutineAddr(conf);
			if addr.nil?
				raise "routine: #{conf} not found for #{conf_name}"
			end
		end
		return addr
	end
	def construct
		left_size = NES_ROM_SIZE-obj.size;
		if left_size < 0
			raise "file too large!"
		end
		@obj += [0] * left_size;
		@obj += [@nmi_handler].pack("s").unpack("C2");
		@obj += [@entry_point].pack("s").unpack("C2");
		@obj += [@irq_handler].pack("s").unpack("C2");
	end
	public
	def to_a
		return @obj.dup
	end
end
class Asm::Nes::Linker < ::Asm::Linker
	NES_HEADER = [0x4E, 0x45, 0x53, 0x1A].freeze; #NES
	
	def initialize(codeList, resList)
		super
		@header = NES_HEADER.dup;
		@header << @codeList.size*2; #FIXME: とりあえず動けばいいやの世界…
		@header << @resList.size*2;
		@header += [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
		@rom = @header.dup;
		for code in @codeList
			@rom += code.to_a
		end
		for res in @resList
			@rom += res.to_a
		end
	end
	def to_a
		return @rom
	end
end
