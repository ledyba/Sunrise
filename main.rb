# -*- encoding: utf-8 -*-
STDOUT.set_encoding( Encoding.locale_charmap, "UTF-8" )
require 'logger'
require File.dirname(__FILE__)+"/parser/parser.rb"
require File.dirname(__FILE__)+"/asm/compiler.rb"

def main(argv)
	parser = Parser.new();
	compiler = ::Asm::Compiler.new();
	ARGV.each(){|src|
		open(src, "r:UTF-8"){|f|
			treeList = parser.parse(f.read);
			compiler.readTree(treeList);
		}
	}
	compiler.compile().save("compiled.bin");
end

main(ARGV);
