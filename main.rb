# -*- encoding: utf-8 -*-
STDOUT.set_encoding( Encoding.locale_charmap, "UTF-8" )
require 'logger'
require File.dirname(__FILE__)+"/parser/parser.rb"

def main(argv)
	parser = Parser.new();
	src = open(ARGV[0]).read;
	p parser.parse(src);
end

main(ARGV);
