; ---------------------------------------------------------------------------
; Animation script - monitors
; ---------------------------------------------------------------------------
Ani_Monitor:
		dc.w	.static-Ani_Monitor
		dc.w	.eggman-Ani_Monitor
		dc.w	.sonic-Ani_Monitor
		dc.w	.shoes-Ani_Monitor
		dc.w	.shield-Ani_Monitor
		dc.w	.invincible-Ani_Monitor
		dc.w	.rings-Ani_Monitor
	if ShieldsMode>1
		dc.w	.fshield-Ani_Monitor	; Added
		dc.w	.bshield-Ani_Monitor	; Added
		dc.w	.lshield-Ani_Monitor	; Added
	endif
		dc.w	.s-Ani_Monitor
		dc.w	.goggles-Ani_Monitor
		dc.w	.breaking-Ani_Monitor

.static:	dc.b 1,	0, 1, 2, afEnd
		even
.eggman:	dc.b 1,	0, 3, 3, 1, 3, 3, 2, 3,	3, afEnd
		even
.sonic:		dc.b 1,	0, 4, 4, 1, 4, 4, 2, 4,	4, afEnd
		even
.shoes:		dc.b 1,	0, 5, 5, 1, 5, 5, 2, 5,	5, afEnd
		even
.shield:	dc.b 1,	0, 6, 6, 1, 6, 6, 2, 6,	6, afEnd
		even
.invincible:	dc.b 1,	0, 7, 7, 1, 7, 7, 2, 7,	7, afEnd
		even
.rings:		dc.b 1,	0, 8, 8, 1, 8, 8, 2, 8,	8, afEnd
		even

	if ShieldsMode>1

.fshield:	dc.b 1,	0, 9, 9, 1, 9, 9, 2, 9, 9, afEnd
		even
.bshield:	dc.b 1,	0, $A, $A, 1, $A, $A, 2, $A, $A, afEnd
		even
.lshield:	dc.b 1,	0, $B, $B, 1, $B, $B, 2, $B, $B, afEnd
		even
.s:		dc.b 1,	0, $C, $C, 1, $C, $C, 2, $C, $C, afEnd
		even
.goggles:	dc.b 1,	0, $D, $D, 1, $D, $D, 2, $D, $D, afEnd
		even
.breaking:	dc.b 2,	0, 1, 2, $E, afBack, 1
		even

	else

.s:		dc.b 1,	0, 9, 9, 1, 9, 9, 2, 9,	9, afEnd
		even
.goggles:	dc.b 1,	0, $A, $A, 1, $A, $A, 2, $A, $A, afEnd
		even
.breaking:	dc.b 2,	0, 1, 2, $B, afBack, 1
		even

	endif
