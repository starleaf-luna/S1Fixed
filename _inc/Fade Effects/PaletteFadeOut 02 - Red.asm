; ---------------------------------------------------------------------------
; Subroutine to fade out to black -- Mode 02: Red (RetroKoH)
; Slight optimization to FadeOut_DecColour by RetroKoH
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FadeOut_DecColour:
		tst.w	(a0)		; Does this colour entry need to be faded out?
		beq.s	.next		; if not, branch and jump to the next palette entry

.degreen:
		move.b	1(a0),d1	; d1 = GR byte
		andi.b	#$E0,d1		; d1 = current green
		beq.s	.deblue		; if green is already faded out, check blue
		subi.b	#$20,1(a0)	; decrease green value
		addq.w	#2,a0		; next colour
		rts
; ===========================================================================

.deblue:
		move.b	(a0),d1		; d1 = 0B byte
		andi.b	#$E,d1		; d1 = blue (done for condition check and error-proofing)
		beq.s	.dered		; if blue is already faded out, that means only red remains
		subq.b	#2,(a0)		; decrease blue	value
		addq.w	#2,a0		; next colour
		rts
; ===========================================================================

.dered:
		subq.b	#2,1(a0)	; decrease red value

.next:
		addq.w	#2,a0		; next colour
		rts
; End of function FadeOut_DecColour
