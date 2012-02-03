# -*- encoding: utf-8 -*-
STDOUT.set_encoding( Encoding.locale_charmap, "UTF-8" )
require 'logger'
require File.dirname(__FILE__)+"/parser/parser.rb"
require File.dirname(__FILE__)+"/asm/compiler.rb"
require File.dirname(__FILE__)+"/asm/nes.rb"

def main(argv)
	parser = Parser.new();
	compiler = ::Asm::Compiler.new(::Asm::Nes);
	ARGV.each(){|src|
		open(src, "r:UTF-8"){|f|
			compiler << parser.parse(f.read);
		}
	};
	compiler.compile().save("compiled.nes");
end

main(ARGV);
