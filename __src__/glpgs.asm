:shown_string
	.include_bin "Glpgs, inc.\0aPresentation\n2012/03/09\0"
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
:next_string
	lda [0x81]
	inc [0x81]
	tax
	lda <shown_string, x>
	cmp 0x00
	bne not_null
		inc [0x83]
		rts
	:not_null
	cmp 0x0a
	beq next_line
		lda 0x20
		sta <0x2006>
		lda [0x82]
		inc [0x82]
		sta <0x2006>
		lda 32
		sta [1]
		lda <shown_string, x>
		sec
		sbc [1]
		sta <0x2007>
		rts
	:next_line
		lda [0x82]
		and 224
		clc
		adc 36
		sta [0x82]
		jsr <next_string>
		rts
;テスト
:nmi_handler
	lda [0x83]
	bne end_nmi
	dec [0x80]
	bne end_nmi
	lda 5
	sta [0x80]
	jsr <next_string>
:end_nmi
	;スクロール位置を戻す
	lda 0
	sta <0x2005>
	sta <0x2005>
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
	lda 0
	sta [0x81]
	lda 68
	sta [0x82]
	lda 0
	sta [0x83]
	lda 2
	sta [0x80]
	lda 0x88
	sta <0x2000>
:loop
	jmp <loop>
