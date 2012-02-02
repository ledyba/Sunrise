# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/../tree/tree.rb"
require File.dirname(__FILE__)+"/../tree/opcodes.rb"
require File.dirname(__FILE__)+"/../tree/operands.rb"
require File.dirname(__FILE__)+"/../tree/pseudo_operator.rb"

require 'logger'
require 'strscan'

module ParserInner
	private
	RAND_TABLE = ('a'..'z').to_a + ('A'..'Z').to_a.to_a;
	def randIdent(len)
		return Array.new(len){RAND_TABLE[rand(RAND_TABLE.size)]}.join
	end
	public
	def parse(str)
		ss = StringScanner.new(str+"\n")
		@tokens = [];
		while !ss.eos?
			case
			when ss.skip(/[ \t\r\f]+/)
			when ss.skip(/;.*$/)
			when ss.skip(/\/\/.*$/)
			when ss.skip(/\/\*.*?\*\//m)
			when ss.scan(/\n\s*/)
				if @tokens.last.first != :EOL
					@tokens.push [:EOL, :EOL]
				end
			when ss.scan(/0x(\d+)/)
				@tokens.push [:HEX_NUMBER, ss[0]]
			when ss.scan(/0b(\d+)/)
				@tokens.push [:BIN_NUMBER, ss[0]]
			when ss.scan(/\d+/)
				@tokens.push [:DECI_NUMBER, ss[0]]
			when ss.scan(/[Xx]/)
				@tokens.push [:REG_X, :REG_X]
			when ss.scan(/[Yy]/)
				@tokens.push [:REG_Y, :REG_Y]
			when ss.scan(/[\w\$\%\&\*\+\-\\\/\?@^_~]+/)
				@tokens.push [:IDENT, ss[0].to_sym]
			else
				s = ss.getch;
				@tokens.push [s,s];
			end
		end
		@tokens.push nil
		do_parse()
	end

	def next_token()
		return @tokens.shift()
	end
end
