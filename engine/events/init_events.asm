; https://github.com/pret/pokecrystal/wiki/Improve-the-event-initialization-system
InitializeEvents:
; initialize events
	ld hl, InitialEvents
.events_loop
	call .GetDWInDE
	jr z, .events_done
	ld b, SET_FLAG
	push hl
	call EventFlagAction
	pop hl
	jr .events_loop

.events_done
; initialize engine flags
	ld hl, InitialEngineFlags
.flags_loop
	call .GetDWInDE
	jr z, .flags_done
	ld b, SET_FLAG
	push hl
	farcall EngineFlagAction
	pop hl
	jr .flags_loop

.flags_done
; initialize variable sprites
	ld hl, InitialVariableSprites
.sprites_loop
	ld a, [hli]
	inc a
	ret z
	; subtract 1 to balance the previous 'inc'
	add LOW(wVariableSprites) - 1
	ld e, a
	adc HIGH(wVariableSprites)
	sub e
	ld d, a
	ld a, [hli]
	ld [de], a
	jr .sprites_loop

.GetDWInDE:
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	and e
	inc a
	ret

INCLUDE "data/events/init_events.asm"
