# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
require File.dirname(__FILE__)+"/opcodes.rb";
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::Opcode
	NORMAL_OPCODE_TABLE = {
		:LDA => 
		{
			:Immediate => 0xA9,
			:Zeropage  => 0xA5,
			:ZeropageX => 0xB5,
			:ZeropageY => nil,
			:Absolute  => 0xAD,
			:AbsoluteX => 0xBD,
			:AbsoluteY => 0xB9,
			:Indirect  => nil,
			:IndirectX => 0xA1,
			:IndirectY => 0xB1,
			:nil => nil
		},
		:LDX => 
		{
			:Immediate => 0xA2,
			:Zeropage  => 0xA6,
			:ZeropageX => nil,
			:ZeropageY => 0xB6,
			:Absolute  => 0xAE,
			:AbsoluteX => nil,
			:AbsoluteY => 0xBE,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:LDY => 
		{
			:Immediate => 0xA0,
			:Zeropage  => 0xA4,
			:ZeropageX => 0xB4,
			:ZeropageY => nil,
			:Absolute  => 0xAC,
			:AbsoluteX => 0xBC,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:STA => 
		{
			:Immediate => nil,
			:Zeropage  => 0x85,
			:ZeropageX => 0x95,
			:ZeropageY => nil,
			:Absolute  => 0x8D,
			:AbsoluteX => 0x9D,
			:AbsoluteY => 0x99,
			:Indirect  => nil,
			:IndirectX => 0x81,
			:IndirectY => 0x91,
			:nil => nil
		},
		:STX => 
		{
			:Immediate => nil,
			:Zeropage  => 0x86,
			:ZeropageX => nil,
			:ZeropageY => 0x96,
			:Absolute  => 0x8e,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:STY => 
		{
			:Immediate => nil,
			:Zeropage  => 0x84,
			:ZeropageX => 0x94,
			:ZeropageY => nil,
			:Absolute  => 0x8C,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:TAX => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xAA
		},
		:TAY => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xA8
		},
		:TSX => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xBA
		},
		:TXA => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x8A
		},
		:TXS => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x9A
		},
		:TYA => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x98
		},
		:ADC => 
		{
			:Immediate => 0x69,
			:Zeropage  => 0x65,
			:ZeropageX => 0x75,
			:ZeropageY => nil,
			:Absolute  => 0x6D,
			:AbsoluteX => 0x7D,
			:AbsoluteY => 0x79,
			:Indirect  => nil,
			:IndirectX => 0x61,
			:IndirectY => 0x71,
			:nil => nil
		},
		:AND => 
		{
			:Immediate => 0x29,
			:Zeropage  => 0x25,
			:ZeropageX => 0x35,
			:ZeropageY => nil,
			:Absolute  => 0x2D,
			:AbsoluteX => 0x3D,
			:AbsoluteY => 0x39,
			:Indirect  => nil,
			:IndirectX => 0x21,
			:IndirectY => 0x31,
			:nil => nil
		},
		:ASL => 
		{
			:Immediate => nil,
			:Zeropage  => 0x06,
			:ZeropageX => 0x16,
			:ZeropageY => nil,
			:Absolute  => 0x0E,
			:AbsoluteX => 0x1E,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x0A
		},
		:BIT => 
		{
			:Immediate => nil,
			:Zeropage  => 0x24,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => 0x2C,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:CMP => 
		{
			:Immediate => 0xC9,
			:Zeropage  => 0xC5,
			:ZeropageX => 0xD5,
			:ZeropageY => nil,
			:Absolute  => 0xCD,
			:AbsoluteX => 0xDD,
			:AbsoluteY => 0xD9,
			:Indirect  => nil,
			:IndirectX => 0xC1,
			:IndirectY => 0xD1,
			:nil => nil
		},
		:CPX => 
		{
			:Immediate => 0xE0,
			:Zeropage  => 0xE4,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => 0xEC,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:CPY => 
		{
			:Immediate => 0xC0,
			:Zeropage  => 0xC4,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => 0xCC,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:DEC => 
		{
			:Immediate => nil,
			:Zeropage  => 0xC6,
			:ZeropageX => 0xD6,
			:ZeropageY => nil,
			:Absolute  => 0xCE,
			:AbsoluteX => 0xDE,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:DEX => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xCA
		},
		:DEY => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x88
		},
		:EOR => 
		{
			:Immediate => 0x49,
			:Zeropage  => 0x45,
			:ZeropageX => 0x55,
			:ZeropageY => nil,
			:Absolute  => 0x4D,
			:AbsoluteX => 0x5D,
			:AbsoluteY => 0x59,
			:Indirect  => nil,
			:IndirectX => 0x41,
			:IndirectY => 0x51,
			:nil => nil
		},
		:INC => 
		{
			:Immediate => nil,
			:Zeropage  => 0xE6,
			:ZeropageX => 0xF6,
			:ZeropageY => nil,
			:Absolute  => 0xEE,
			:AbsoluteX => 0xFE,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:INX => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xE8
		},
		:INY => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xC8
		},
		:LSR => 
		{
			:Immediate => nil,
			:Zeropage  => 0x46,
			:ZeropageX => 0x56,
			:ZeropageY => nil,
			:Absolute  => 0x4E,
			:AbsoluteX => 0x5E,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x4A
		},
		:ORA => 
		{
			:Immediate => 0x09,
			:Zeropage  => 0x05,
			:ZeropageX => 0x15,
			:ZeropageY => nil,
			:Absolute  => 0x0D,
			:AbsoluteX => 0x1D,
			:AbsoluteY => 0x19,
			:Indirect  => nil,
			:IndirectX => 0x01,
			:IndirectY => 0x11,
			:nil => nil
		},
		:ROL => 
		{
			:Immediate => nil,
			:Zeropage  => 0x26,
			:ZeropageX => 0x36,
			:ZeropageY => nil,
			:Absolute  => 0x2E,
			:AbsoluteX => 0x3E,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x2A
		},
		:ROR => 
		{
			:Immediate => nil,
			:Zeropage  => 0x66,
			:ZeropageX => 0x76,
			:ZeropageY => nil,
			:Absolute  => 0x6E,
			:AbsoluteX => 0x7E,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x6A
		},
		:SBC => 
		{
			:Immediate => 0xE9,
			:Zeropage  => 0xE5,
			:ZeropageX => 0xF5,
			:ZeropageY => nil,
			:Absolute  => 0xED,
			:AbsoluteX => 0xFD,
			:AbsoluteY => 0xF9,
			:Indirect  => nil,
			:IndirectX => 0xE1,
			:IndirectY => 0xF1,
			:nil => nil
		},
		:PHA => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x48
		},
		:PHP => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x08
		},
		:PLA => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x68
		},
		:PLP =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x28
		},
		:CLC =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x18
		},
		:CLD =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xD8
		},
		:CLI =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x58
		},
		:CLV =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xB8
		},
		:SEC =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x38
		},
		:SED =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xF8
		},
		:SEI =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x78
		},
		:BRK =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x0
		},
		:NOP =>
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0xEA
		},
		# ジャンプアドレス計算の必要のない方たち
		:RTS => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x60
		},
		:RTI => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => nil,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => 0x40
		},
		:JMP => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => 0x4C,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => 0x6C,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
		:JSR => 
		{
			:Immediate => nil,
			:Zeropage  => nil,
			:ZeropageX => nil,
			:ZeropageY => nil,
			:Absolute  => 0x20,
			:AbsoluteX => nil,
			:AbsoluteY => nil,
			:Indirect  => nil,
			:IndirectX => nil,
			:IndirectY => nil,
			:nil => nil
		},
	};
	JUMP_OPCODE_TABLE={
		:BCC => 
		{
			:Immediate => 0x90,
		},
		:BCS => 
		{
			:Immediate => 0xB0,
		},
		:BEQ => 
		{
			:Immediate => 0xF0,
		},
		:BMI => 
		{
			:Immediate => 0x30,
		},
		:BNE => 
		{
			:Immediate => 0xD0,
		},
		:BPL => 
		{
			:Immediate => 0x10,
		},
		:BVC => 
		{
			:Immediate => 0x50,
		},
		:BVS => 
		{
			:Immediate => 0x70,
		}
	};
	JUMP_INVERT_TABLE = {
		:BCC => :BCS,
		:BCS => :BCC,
		:BEQ => :BNE,
		:BNE => :BEQ,
		:BPL => :BMI,
		:BMI => :BPL,
		:BVC => :BVS,
		:BVS => :BVC
	};
end
