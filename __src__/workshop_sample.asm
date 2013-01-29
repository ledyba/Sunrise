:shown_string
	.include_bin "Lesson 01 !"
	.include_bin 0
	.set_val str_len, 11
:init_pattern
	lda 0x20
	sta <0x2006>
	lda 0x00
	sta <0x2006>
	jsr <fill_buffer>
	lda 0x28
	sta <0x2006>
	lda 0x00
	sta <0x2006>
	jsr <fill_buffer>
	rts
:fill_buffer
	lda 0x4
	sta [1]
	:init_pattern_loop_entire
		lda 240
		sta [0]
		:init_pattern_loop_start
			lda 0x0
			sta <0x2007>
			dec [0]
			bne init_pattern_loop_start
		dec [1]
		bne init_pattern_loop_entire
	rts
:paste_string
	lda 0x20
	sta <0x2006>
	lda 0x42
	sta <0x2006>
	lda 0
	tax
	lda  str_len
	sta [0]
	lda 32
	sta [1]
	:paste_string_loop
		lda <shown_string, x>
		sec
		sbc [1]
		sta <0x2007>
		inx
		dec [0]
		bne paste_string_loop
	rts
;テスト
:nmi_handler
	rti
:irq_handler
	rti
:entry_point
	lda 0x00
	sta <0x2000>
	lda 0x00
	sta <0x2001>
:set_setting
	lda 0x3f
	sta <0x2006>
	lda 0x00
	sta <0x2006>

	lda 8
	sta [0]
	:set_palette_loop
		lda 0x0D
		sta <0x2007>
		lda 0x30
		sta <0x2007>
		sta <0x2007>
		sta <0x2007>
		dec [0]
		bne set_palette_loop
:set_string
	jsr <init_pattern>
	jsr <paste_string>
:init_video
	;スクロール位置を戻す
	lda 0
	sta <0x2005>
	sta <0x2005>
	;init
	lda 0x08
	sta <0x2000>
	lda 0x08
	sta <0x2001>
	lda 0x08
	sta <0x2000>
:clear_zero
	lda 0xff
	tax
	lda 0
	sta [0]
	:clear_zero_body
		sta [0,x]
		dex
		bne clear_zero_body
	nop
	nop
	nop
:loop
	CLC
	lda [0x00]
	adc [0x10]
	sta [0x20]
	jmp <loop>

