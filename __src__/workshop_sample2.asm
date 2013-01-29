:nmi_handler
:fill_chr_from_zero
	lda 0x20
	sta <0x2006>
	lda 0xe8
	sta <0x2006>
	:copy_buffer
	lda[0]
	sta <0x2007>
	lda[1]
	sta <0x2007>
	lda[2]
	sta <0x2007>
	lda[3]
	sta <0x2007>
	lda[4]
	sta <0x2007>
	lda[5]
	sta <0x2007>
	lda[6]
	sta <0x2007>
	lda[7]
	sta <0x2007>
	lda[8]
	sta <0x2007>
	lda[9]
	sta <0x2007>
	lda[10]
	sta <0x2007>
	lda[11]
	sta <0x2007>
	lda[12]
	sta <0x2007>
	lda[13]
	sta <0x2007>
	lda[14]
	sta <0x2007>
	lda[15]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0x08
	sta <0x2006>
	
	lda[16]
	sta <0x2007>
	lda[17]
	sta <0x2007>
	lda[18]
	sta <0x2007>
	lda[19]
	sta <0x2007>
	lda[20]
	sta <0x2007>
	lda[21]
	sta <0x2007>
	lda[22]
	sta <0x2007>
	lda[23]
	sta <0x2007>
	lda[24]
	sta <0x2007>
	lda[25]
	sta <0x2007>
	lda[26]
	sta <0x2007>
	lda[27]
	sta <0x2007>
	lda[28]
	sta <0x2007>
	lda[29]
	sta <0x2007>
	lda[30]
	sta <0x2007>
	lda[31]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0x28
	sta <0x2006>
	
	lda[32]
	sta <0x2007>
	lda[33]
	sta <0x2007>
	lda[34]
	sta <0x2007>
	lda[35]
	sta <0x2007>
	lda[36]
	sta <0x2007>
	lda[37]
	sta <0x2007>
	lda[38]
	sta <0x2007>
	lda[39]
	sta <0x2007>
	lda[40]
	sta <0x2007>
	lda[41]
	sta <0x2007>
	lda[42]
	sta <0x2007>
	lda[43]
	sta <0x2007>
	lda[44]
	sta <0x2007>
	lda[45]
	sta <0x2007>
	lda[46]
	sta <0x2007>
	lda[47]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0x48
	sta <0x2006>
	
	lda[48]
	sta <0x2007>
	lda[49]
	sta <0x2007>
	lda[50]
	sta <0x2007>
	lda[51]
	sta <0x2007>
	lda[52]
	sta <0x2007>
	lda[53]
	sta <0x2007>
	lda[54]
	sta <0x2007>
	lda[55]
	sta <0x2007>
	lda[56]
	sta <0x2007>
	lda[57]
	sta <0x2007>
	lda[58]
	sta <0x2007>
	lda[59]
	sta <0x2007>
	lda[60]
	sta <0x2007>
	lda[61]
	sta <0x2007>
	lda[62]
	sta <0x2007>
	lda[63]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0x68
	sta <0x2006>
	
	lda[64]
	sta <0x2007>
	lda[65]
	sta <0x2007>
	lda[66]
	sta <0x2007>
	lda[67]
	sta <0x2007>
	lda[68]
	sta <0x2007>
	lda[69]
	sta <0x2007>
	lda[70]
	sta <0x2007>
	lda[71]
	sta <0x2007>
	lda[72]
	sta <0x2007>
	lda[73]
	sta <0x2007>
	lda[74]
	sta <0x2007>
	lda[75]
	sta <0x2007>
	lda[76]
	sta <0x2007>
	lda[77]
	sta <0x2007>
	lda[78]
	sta <0x2007>
	lda[79]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0x88
	sta <0x2006>
	
	lda[80]
	sta <0x2007>
	lda[81]
	sta <0x2007>
	lda[82]
	sta <0x2007>
	lda[83]
	sta <0x2007>
	lda[84]
	sta <0x2007>
	lda[85]
	sta <0x2007>
	lda[86]
	sta <0x2007>
	lda[87]
	sta <0x2007>
	lda[88]
	sta <0x2007>
	lda[89]
	sta <0x2007>
	lda[90]
	sta <0x2007>
	lda[91]
	sta <0x2007>
	lda[92]
	sta <0x2007>
	lda[93]
	sta <0x2007>
	lda[94]
	sta <0x2007>
	lda[95]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0xa8
	sta <0x2006>
	
	lda[96]
	sta <0x2007>
	lda[97]
	sta <0x2007>
	lda[98]
	sta <0x2007>
	lda[99]
	sta <0x2007>
	lda[100]
	sta <0x2007>
	lda[101]
	sta <0x2007>
	lda[102]
	sta <0x2007>
	lda[103]
	sta <0x2007>
	lda[104]
	sta <0x2007>
	lda[105]
	sta <0x2007>
	lda[106]
	sta <0x2007>
	lda[107]
	sta <0x2007>
	lda[108]
	sta <0x2007>
	lda[109]
	sta <0x2007>
	lda[110]
	sta <0x2007>
	lda[111]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0xc8
	sta <0x2006>
	
	lda[112]
	sta <0x2007>
	lda[113]
	sta <0x2007>
	lda[114]
	sta <0x2007>
	lda[115]
	sta <0x2007>
	lda[116]
	sta <0x2007>
	lda[117]
	sta <0x2007>
	lda[118]
	sta <0x2007>
	lda[119]
	sta <0x2007>
	lda[120]
	sta <0x2007>
	lda[121]
	sta <0x2007>
	lda[122]
	sta <0x2007>
	lda[123]
	sta <0x2007>
	lda[124]
	sta <0x2007>
	lda[125]
	sta <0x2007>
	lda[126]
	sta <0x2007>
	lda[127]
	sta <0x2007>
	
	lda 0x21
	sta <0x2006>
	lda 0xe8
	sta <0x2006>
	
	lda[128]
	sta <0x2007>
	lda[129]
	sta <0x2007>
	lda[130]
	sta <0x2007>
	lda[131]
	sta <0x2007>
	lda[132]
	sta <0x2007>
	lda[133]
	sta <0x2007>
	lda[134]
	sta <0x2007>
	lda[135]
	sta <0x2007>
	lda[136]
	sta <0x2007>
	lda[137]
	sta <0x2007>
	lda[138]
	sta <0x2007>
	lda[139]
	sta <0x2007>
	lda[140]
	sta <0x2007>
	lda[141]
	sta <0x2007>
	lda[142]
	sta <0x2007>
	lda[143]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0x08
	sta <0x2006>
	
	lda[144]
	sta <0x2007>
	lda[145]
	sta <0x2007>
	lda[146]
	sta <0x2007>
	lda[147]
	sta <0x2007>
	lda[148]
	sta <0x2007>
	lda[149]
	sta <0x2007>
	lda[150]
	sta <0x2007>
	lda[151]
	sta <0x2007>
	lda[152]
	sta <0x2007>
	lda[153]
	sta <0x2007>
	lda[154]
	sta <0x2007>
	lda[155]
	sta <0x2007>
	lda[156]
	sta <0x2007>
	lda[157]
	sta <0x2007>
	lda[158]
	sta <0x2007>
	lda[159]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0x28
	sta <0x2006>
	
	lda[160]
	sta <0x2007>
	lda[161]
	sta <0x2007>
	lda[162]
	sta <0x2007>
	lda[163]
	sta <0x2007>
	lda[164]
	sta <0x2007>
	lda[165]
	sta <0x2007>
	lda[166]
	sta <0x2007>
	lda[167]
	sta <0x2007>
	lda[168]
	sta <0x2007>
	lda[169]
	sta <0x2007>
	lda[170]
	sta <0x2007>
	lda[171]
	sta <0x2007>
	lda[172]
	sta <0x2007>
	lda[173]
	sta <0x2007>
	lda[174]
	sta <0x2007>
	lda[175]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0x48
	sta <0x2006>
	
	lda[176]
	sta <0x2007>
	lda[177]
	sta <0x2007>
	lda[178]
	sta <0x2007>
	lda[179]
	sta <0x2007>
	lda[180]
	sta <0x2007>
	lda[181]
	sta <0x2007>
	lda[182]
	sta <0x2007>
	lda[183]
	sta <0x2007>
	lda[184]
	sta <0x2007>
	lda[185]
	sta <0x2007>
	lda[186]
	sta <0x2007>
	lda[187]
	sta <0x2007>
	lda[188]
	sta <0x2007>
	lda[189]
	sta <0x2007>
	lda[190]
	sta <0x2007>
	lda[191]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0x68
	sta <0x2006>
	
	lda[192]
	sta <0x2007>
	lda[193]
	sta <0x2007>
	lda[194]
	sta <0x2007>
	lda[195]
	sta <0x2007>
	lda[196]
	sta <0x2007>
	lda[197]
	sta <0x2007>
	lda[198]
	sta <0x2007>
	lda[199]
	sta <0x2007>
	lda[200]
	sta <0x2007>
	lda[201]
	sta <0x2007>
	lda[202]
	sta <0x2007>
	lda[203]
	sta <0x2007>
	lda[204]
	sta <0x2007>
	lda[205]
	sta <0x2007>
	lda[206]
	sta <0x2007>
	lda[207]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0x88
	sta <0x2006>
	
	lda[208]
	sta <0x2007>
	lda[209]
	sta <0x2007>
	lda[210]
	sta <0x2007>
	lda[211]
	sta <0x2007>
	lda[212]
	sta <0x2007>
	lda[213]
	sta <0x2007>
	lda[214]
	sta <0x2007>
	lda[215]
	sta <0x2007>
	lda[216]
	sta <0x2007>
	lda[217]
	sta <0x2007>
	lda[218]
	sta <0x2007>
	lda[219]
	sta <0x2007>
	lda[220]
	sta <0x2007>
	lda[221]
	sta <0x2007>
	lda[222]
	sta <0x2007>
	lda[223]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0xa8
	sta <0x2006>
	
	lda[224]
	sta <0x2007>
	lda[225]
	sta <0x2007>
	lda[226]
	sta <0x2007>
	lda[227]
	sta <0x2007>
	lda[228]
	sta <0x2007>
	lda[229]
	sta <0x2007>
	lda[230]
	sta <0x2007>
	lda[231]
	sta <0x2007>
	lda[232]
	sta <0x2007>
	lda[233]
	sta <0x2007>
	lda[234]
	sta <0x2007>
	lda[235]
	sta <0x2007>
	lda[236]
	sta <0x2007>
	lda[237]
	sta <0x2007>
	lda[238]
	sta <0x2007>
	lda[239]
	sta <0x2007>
	
	lda 0x22
	sta <0x2006>
	lda 0xc8
	sta <0x2006>
	
	lda[240]
	sta <0x2007>
	lda[241]
	sta <0x2007>
	lda[242]
	sta <0x2007>
	lda[243]
	sta <0x2007>
	lda[244]
	sta <0x2007>
	lda[245]
	sta <0x2007>
	lda[246]
	sta <0x2007>
	lda[247]
	sta <0x2007>
	lda[248]
	sta <0x2007>
	lda[249]
	sta <0x2007>
	lda[250]
	sta <0x2007>
	lda[251]
	sta <0x2007>
	lda[252]
	sta <0x2007>
	lda[253]
	sta <0x2007>
	lda[254]
	sta <0x2007>
	lda[255]
	sta <0x2007>
	;スクロール位置を戻す
	lda 0x00
	sta <0x2006>
	sta <0x2006>
	
	; スプライト番号０を移動させる。アドレスは0x100=>xと0x101=>y
:get_pad
	lda <0x300>
	sta <0x600>
	sta <0x4016> ;reset
	CLC
	lda 0
	sta <0x300>
	lda <0x4016>
	beq end1
		sta <0x300>
	:end1
	lda <0x4016>
	beq end2
		lda 2
		ora <0x300>
		sta <0x300>
	:end2
	lda <0x4016>
	beq end3
		lda 4
		ora <0x300>
		sta <0x300>
	:end3
	lda <0x4016>
	beq end4
		lda 8
		ora <0x300>
		sta <0x300>
	:end4
	lda <0x4016>
	beq end5
		lda 16
		ora <0x300>
		sta <0x300>
	:end5
	lda <0x4016>
	beq end6
		lda 32
		ora <0x300>
		sta <0x300>
	:end6
	lda <0x4016>
	beq end7
		lda 64
		ora <0x300>
		sta <0x300>
	:end7
	lda <0x4016>
	beq end8
		lda 128
		ora <0x300>
		sta <0x300>
	:end8
	inc <0x500>
	ldx <0x500>
	lda <0x300>
	sta <0x200,x>
	;チェックして座標移動
	lda 0x40 ;左
	and <0x300>
	beq not_left
	lda <0x100>
	cmp 65
	bmi not_left
		dec <0x100>
	:not_left
	lda 0x80 ;右
	and <0x300>
	beq not_right
	lda <0x100>
	cmp 184
	bpl not_right
		inc <0x100>
	:not_right
	lda 0x10 ;上
	and <0x300>
	beq not_up
	lda <0x101>
	cmp 58
	bmi not_up
		dec <0x101>
	:not_up
	lda 0x20 ;下
	and <0x300>
	beq not_bottom
	lda <0x101>
	cmp 175
	bpl not_bottom
		inc <0x101>
	:not_bottom
	; スプライト座標セット
	lda 0
	sta <0x2003>
	lda <0x101>
	sta <0x2004>
	lda 3
	sta <0x2003>
	lda <0x100>
	sta <0x2004>
	; 座標を割って座標へ
	lda <0x101>
	clc
	adc 4
	lsr
	lsr
	lsr
	sec
	sbc 7
	asl
	asl
	asl
	asl
	sta <0x102>
	lda <0x100>
	sec
	sbc 2
	lsr
	lsr
	lsr
	sbc 7
	clc
	ora <0x102>
	sta <0x102>
	; 押しはじめたボタンの検出
	lda <0x600>
	eor <0x300>
	and <0x300>
	sta <0x601>
	; 座標の導出
	ldx <0x102>
	; aと比較
	lda 0x1
	and <0x601>
	beq not_a
	lda [0, x]
	cmp 10
	bpl not_a
		inc [0,x]
	:not_a
	lda 0x2
	and <0x601>
	beq not_b
	lda [0, x]
	beq not_b
		dec [0,x]
	:not_b
	
	rti
:irq_handler
	rti
:entry_point
	lda 0x00
	sta <0x2000>
	sta <0x2001>
	sta <0x500>

:set_setting
	lda 0x3f
	sta <0x2006>
	lda 0x00
	sta <0x2006>
:set_palette
	lda 8
	sta [0]
	:set_palette_loop
		lda 0x0D
		sta <0x2007>
		lda 0x30
		sta <0x2007>
		lda 0x15
		sta <0x2007>
		sta <0x2007>
		dec [0]
		bne set_palette_loop
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
:clear_zero
	lda 0
	ldx 0xff
;    :clear_zero_body1
;        sta <0x100,x>
;        dex
;        bne clear_zero_body1
;    ldx 0xff
	:clear_zero_body2
		sta <0x200,x>
		dex
		bne clear_zero_body2
	ldx 0xff
;    :clear_zero_body3
;        sta <0x300,x>
;        dex
;        bne clear_zero_body3
;    ldx 0xff
;    lda 0
;    sta [0]
	:clear_zero_body
		sta [0,x]
		dex
		bne clear_zero_body
	; 座標
	lda 120
	sta <0x100>
	sta <0x101>
	; カーソルスプライト
	lda 1
	sta <0x2003>
	lda 1
	sta <0x2004>
	
:restore_video
	;スクロール位置を戻す
	lda 0
	sta <0x2005>
	sta <0x2005>
	;init
	lda 0x08
	sta <0x2000>
	lda 0x18
	sta <0x2001>
	lda 0x88
	sta <0x2000>
:loop
	jmp <loop>
:fill_buffer
	lda 0x4
	sta [1]
	:init_pattern_loop_entire
		lda 240
		sta [0]
		:init_pattern_loop_start
			lda 0x1
			sta <0x2007>
			dec [0]
			bne init_pattern_loop_start
		dec [1]
		bne init_pattern_loop_entire
	rts

