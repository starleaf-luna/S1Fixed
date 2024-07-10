; ---------------------------------------------------------------------------
; Object 8B - Eggman on "TRY AGAIN" and "END" screens
; ---------------------------------------------------------------------------

EndEggman:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
	; RetroKoH Object Routine Optimization
		jsr		EEgg_Index(pc,d0.w)
		jmp		(DisplaySprite).l
; ===========================================================================
EEgg_Index:
		bra.s	EEgg_Main
		bra.s	EEgg_Animate
		bra.s	EEgg_Juggle
		bra.w	EEgg_Wait
	; Object Routine Optimization End

eegg_time = objoff_30		; time between juggle motions
; ===========================================================================

EEgg_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.w	#$120,obX(a0)
		move.w	#$F4,obScreenY(a0)
		move.l	#Map_EEgg,obMap(a0)
		move.w	#make_art_tile(ArtTile_Try_Again_Eggman,0,0),obGfx(a0)
		clr.b	obRender(a0)
		move.w	#$100,obPriority(a0)			; RetroKoH S2 Priority Manager
		move.b	#2,obAnim(a0)					; use "END" animation
		cmpi.b	#emldCount,(v_emeralds).w		; do you have all emeralds?
		beq.s	EEgg_Animate					; if yes, branch

		move.b	#id_CreditsText,(v_tryagain).w	; load credits object
		move.w	#9,(v_creditsnum).w				; use "TRY AGAIN" text
		move.b	#id_TryChaos,(v_eggmanchaos).w	; load emeralds object on "TRY AGAIN" screen
		clr.b	obAnim(a0)						; use "TRY AGAIN" animation

EEgg_Animate:	; Routine 2
		lea		(Ani_EEgg).l,a1
		jmp		(AnimateSprite).l
; ===========================================================================

EEgg_Juggle:	; Routine 4
		addq.b	#2,obRoutine(a0)
		moveq	#2,d0
		btst	#0,obAnim(a0)
		beq.s	.noflip
		neg.w	d0

.noflip:
		lea		(v_eggmanchaos).w,a1	; get RAM address for emeralds
		moveq	#emldCount-1,d1

.emeraldloop:
		move.b	d0,objoff_3E(a1)
		move.w	d0,d2
		asl.w	#3,d2
		add.b	d2,obAngle(a1)
		lea		object_size(a1),a1
		dbf		d1,.emeraldloop
		addq.b	#1,obFrame(a0)
		move.w	#112,eegg_time(a0)

EEgg_Wait:	; Routine 6
		subq.w	#1,eegg_time(a0)		; decrement timer
		bpl.s	.nochg					; branch if time remains
		bchg	#0,obAnim(a0)
		move.b	#2,obRoutine(a0)		; goto EEgg_Animate next

.nochg:
		rts	