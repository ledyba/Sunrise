# -*- encoding: utf-8 -*-
STDOUT.set_encoding( Encoding.locale_charmap, "UTF-8" )
require 'logger'
require File.dirname(__FILE__)+"/parser/parser.rb"
require File.dirname(__FILE__)+"/asm/compiler.rb"
require File.dirname(__FILE__)+"/asm/nes.rb"

def usage()
	puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
	puts "Sunrise - a 6502 Assembler and linker for NES."
	puts "                                 2011-2013 PSI"
	puts "http://ledyba.org/famicom"
	puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
	puts "usage: ruby main.rb [*.asm].... [*.chr] [*.nes]"
end

def main(argv)
	if argv.size < 3
		usage()
		return 1
	end
	parser = Parser.new();
	compiler = ::Asm::Compiler.new(::Asm::Nes);
	ARGV[0..-3].each(){|src|
		open(src, "r:UTF-8"){|f|
			compiler << parser.parse(f.read);
		}
	};
	compiler.compile(ARGV[-2]).save(ARGV[-1]);
	return 0
end

exit(main(ARGV));
