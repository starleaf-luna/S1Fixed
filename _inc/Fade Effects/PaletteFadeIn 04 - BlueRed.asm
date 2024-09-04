; ---------------------------------------------------------------------------
; Subroutine to	fade in from black -- Mode 04: Blue+Red (RetroKoH)
; Slight optimization to FadeIn_AddColour by RetroKoH
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
; This modified function decrements values from _dry_dup while adding to _dry.
; if _dry_dup entry == $0000, then the fade should be complete for that palette entry.
; if a specific component in _dry_dup's current value == $0, then we don't need to fade that color.

FadeIn_AddColour:
		tst.w	(a1)			; Does this colour entry need to be faded in?
		beq.s	.next			; if not, branch and jump to the next palette entry

.checkcolors:
	; Special thanks to MarkeyJester for this bit of code
		move.b	(a1),d5			; d5 = target blue
		move.b	1(a1),d1		; d1 = GR byte
		move.b	d1,d2			; copy to d2
		lsr.b	#4,d1			; d1 = target green
		andi.b	#$E,d2			; d2 = target red
	; Check components
		tst.b	d5				; Does blue need adding (yes if d5 is non-zero)
		bne.s	.addbluered		; if yes, branch and add blue to current colour
		tst.b	d2				; Does red need adding (yes if d2 is non-zero)
		bne.s	.addred			; if yes, branch and add red to current colour
	; ---------------------------------------------------------------------------
	; This time, blue and red will be added together on each frame, instead of separately
	; ---------------------------------------------------------------------------
; fallthrough

.addgreen:
		addi.b	#$20,1(a0)	; increase green value
		subi.b	#$20,1(a1)	; decrease target green value

.next:
		addq.w	#2,a0		; next colour
		addq.w	#2,a1		; next target colour
		rts
; ===========================================================================

.addbluered:
		addq.b	#2,(a0)		; increase blue	value
		subq.b	#2,(a1)		; decrease target blue value
		tst.b	d2			; Does red also need adding (yes if d2 is non-zero)
		beq.s	.next		; if not, finish here
; ===========================================================================

.addred:
		addq.b	#2,1(a0)	; increase red value
		subq.b	#2,1(a1)	; decrease target red value
		bra.s	.next		; advance color values and exit	
; ===========================================================================
