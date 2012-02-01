.test 0x12, aa, a
:testt ;cvom
	lda 12
	lda [0b11]
	lda [eax, x]
;	lda [eax, y]
	lda <aa>
	lda <eax, x>
	lda <eax, y>
;	lda (2)
	lda (eax, x)
;	lda (eax), y
	lda edx
