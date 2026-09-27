	.build_version macos, 26, 5	sdk_version 26, 5
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN7toy_sim3Cpu5FetchEv        ; -- Begin function _ZN7toy_sim3Cpu5FetchEv
	.p2align	2
__ZN7toy_sim3Cpu5FetchEv:               ; @_ZN7toy_sim3Cpu5FetchEv
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	sub	sp, sp, #112
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x0
	ldr	x8, [x0, #48]
	cbz	x8, LBB0_16
; %bb.1:
	ldr	x9, [x19, #64]
	cbz	x9, LBB0_16
; %bb.2:
	ldr	w9, [x19, #24]
	sub	x10, x8, #1
	tst	x8, x10
	b.eq	LBB0_5
; %bb.3:
	mov	x11, x9
	cmp	x8, x9
	b.hi	LBB0_6
; %bb.4:
	udiv	w11, w9, w8
	msub	w11, w11, w8, w9
	b	LBB0_6
LBB0_5:
	sub	w11, w8, #1
	and	x11, x11, x9
LBB0_6:
	ldur	x12, [x19, #40]
	ldr	x12, [x12, x11, lsl #3]
	cbz	x12, LBB0_16
; %bb.7:
	ldr	x20, [x12]
	cbnz	x20, LBB0_10
	b	LBB0_16
LBB0_8:                                 ;   in Loop: Header=BB0_10 Depth=1
	ldr	w12, [x20, #16]
	cmp	w12, w9
	b.eq	LBB0_25
LBB0_9:                                 ;   in Loop: Header=BB0_10 Depth=1
	ldr	x20, [x20]
	cbz	x20, LBB0_16
LBB0_10:                                ; =>This Inner Loop Header: Depth=1
	ldr	x12, [x20, #8]
	cmp	x12, x9
	b.eq	LBB0_8
; %bb.11:                               ;   in Loop: Header=BB0_10 Depth=1
	tst	x8, x10
	b.eq	LBB0_14
; %bb.12:                               ;   in Loop: Header=BB0_10 Depth=1
	cmp	x12, x8
	b.lo	LBB0_15
; %bb.13:                               ;   in Loop: Header=BB0_10 Depth=1
	udiv	x13, x12, x8
	msub	x12, x13, x8, x12
	b	LBB0_15
LBB0_14:                                ;   in Loop: Header=BB0_10 Depth=1
	and	x12, x12, x10
LBB0_15:                                ;   in Loop: Header=BB0_10 Depth=1
	cmp	x12, x11
	b.eq	LBB0_9
LBB0_16:
	add	x8, sp, #40
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu8DecodeBBEv
	ldr	w8, [x19, #24]
	str	w8, [sp, #8]
	stp	xzr, xzr, [sp, #24]
	str	xzr, [sp, #16]
	ldp	x20, x8, [sp, #40]
	subs	x21, x8, x20
	b.eq	LBB0_20
; %bb.17:
	asr	x8, x21, #2
	mov	x9, #-6148914691236517206       ; =0xaaaaaaaaaaaaaaaa
	movk	x9, #43691
	mul	x8, x8, x9
	mov	x9, #6148914691236517205        ; =0x5555555555555555
	movk	x9, #21846
	movk	x9, #5461, lsl #48
	cmp	x8, x9
	b.hs	LBB0_26
; %bb.18:
Ltmp0:
	mov	x0, x21
	bl	__Znwm
Ltmp1:
; %bb.19:
	add	x22, x0, x21
	str	x0, [sp, #16]
	str	x22, [sp, #32]
	mov	x1, x20
	mov	x2, x21
	bl	_memcpy
	str	x22, [sp, #24]
LBB0_20:
Ltmp5:
	add	x0, x19, #40
	add	x1, sp, #8
	add	x2, sp, #8
	bl	__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE25__emplace_unique_key_argsIjJNSA_IjS7_EEEEENSA_INS_15__hash_iteratorIPNS_11__hash_nodeIS8_PvEEEEbEERKT_DpOT0_
Ltmp6:
; %bb.21:
	mov	x20, x0
	ldr	x0, [sp, #16]
	cbz	x0, LBB0_23
; %bb.22:
	str	x0, [sp, #24]
	bl	__ZdlPv
LBB0_23:
	ldr	x0, [sp, #40]
	cbz	x0, LBB0_25
; %bb.24:
	str	x0, [sp, #48]
	bl	__ZdlPv
LBB0_25:
	add	x0, x20, #24
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB0_26:
Ltmp2:
	bl	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev
Ltmp3:
; %bb.27:
	brk	#0x1
LBB0_28:
Ltmp7:
	mov	x19, x0
	ldr	x0, [sp, #16]
	cbnz	x0, LBB0_31
; %bb.29:
	ldr	x0, [sp, #40]
	cbnz	x0, LBB0_33
LBB0_30:
	mov	x0, x19
	bl	__Unwind_Resume
LBB0_31:
	str	x0, [sp, #24]
	bl	__ZdlPv
	ldr	x0, [sp, #40]
	cbz	x0, LBB0_30
	b	LBB0_33
LBB0_32:
Ltmp4:
	mov	x19, x0
	ldr	x0, [sp, #40]
	cbz	x0, LBB0_30
LBB0_33:
	str	x0, [sp, #48]
	bl	__ZdlPv
	mov	x0, x19
	bl	__Unwind_Resume
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table0:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0      ; >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0             ;   Call between Lfunc_begin0 and Ltmp0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp4-Lfunc_begin0             ;     jumps to Ltmp4
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp1-Lfunc_begin0             ; >> Call Site 3 <<
	.uleb128 Ltmp5-Ltmp1                    ;   Call between Ltmp1 and Ltmp5
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp5-Lfunc_begin0             ; >> Call Site 4 <<
	.uleb128 Ltmp6-Ltmp5                    ;   Call between Ltmp5 and Ltmp6
	.uleb128 Ltmp7-Lfunc_begin0             ;     jumps to Ltmp7
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp2-Lfunc_begin0             ; >> Call Site 5 <<
	.uleb128 Ltmp3-Ltmp2                    ;   Call between Ltmp2 and Ltmp3
	.uleb128 Ltmp4-Lfunc_begin0             ;     jumps to Ltmp4
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp3-Lfunc_begin0             ; >> Call Site 6 <<
	.uleb128 Lfunc_end0-Ltmp3               ;   Call between Ltmp3 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN7toy_sim3Cpu8DecodeBBEv     ; -- Begin function _ZN7toy_sim3Cpu8DecodeBBEv
	.p2align	2
__ZN7toy_sim3Cpu8DecodeBBEv:            ; @_ZN7toy_sim3Cpu8DecodeBBEv
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
; %bb.0:
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x20, x0
	mov	x19, x8
	ldr	w8, [x0, #24]
	stp	xzr, xzr, [x19, #8]
	str	xzr, [x19]
	str	wzr, [sp, #8]
	str	xzr, [sp]
LBB1_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x9, [x20, #32]
	mov	w21, w8
	ldr	x8, [x9]
	sub	x8, x8, #4
	cmp	x8, x21
	b.lo	LBB1_8
; %bb.2:                                ;   in Loop: Header=BB1_1 Depth=1
	ldr	x8, [x9, #8]
	ldr	w0, [x8, x21]
Ltmp8:
	bl	__ZN7toy_sim3Cpu6DecodeEj
Ltmp9:
; %bb.3:                                ;   in Loop: Header=BB1_1 Depth=1
	str	x0, [sp]
	str	w1, [sp, #8]
Ltmp11:
	mov	x1, sp
	mov	x0, x19
	bl	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_
Ltmp12:
; %bb.4:                                ;   in Loop: Header=BB1_1 Depth=1
	ldrh	w9, [sp]
	cmp	w9, #16
	b.eq	LBB1_7
; %bb.5:                                ;   in Loop: Header=BB1_1 Depth=1
	cmp	w9, #3520
	b.eq	LBB1_7
; %bb.6:                                ;   in Loop: Header=BB1_1 Depth=1
	add	w8, w21, #4
	cmp	w9, #832
	b.ne	LBB1_1
LBB1_7:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB1_8:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x21, x0
Ltmp14:
Lloh0:
	adrp	x1, l_.str.6@PAGE
Lloh1:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp15:
; %bb.9:
Ltmp17:
Lloh2:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh3:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh4:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh5:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x21
	bl	___cxa_throw
Ltmp18:
; %bb.10:
	brk	#0x1
LBB1_11:
Ltmp19:
	b	LBB1_15
LBB1_12:
Ltmp16:
	mov	x20, x0
	mov	x0, x21
	bl	___cxa_free_exception
	b	LBB1_16
LBB1_13:
Ltmp13:
	b	LBB1_15
LBB1_14:
Ltmp10:
LBB1_15:
	mov	x20, x0
LBB1_16:
	ldr	x0, [x19]
	cbz	x0, LBB1_18
; %bb.17:
	str	x0, [x19, #8]
	bl	__ZdlPv
LBB1_18:
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpLdrGot	Lloh2, Lloh3
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table1:
Lexception1:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Ltmp8-Lfunc_begin1             ; >> Call Site 1 <<
	.uleb128 Ltmp9-Ltmp8                    ;   Call between Ltmp8 and Ltmp9
	.uleb128 Ltmp10-Lfunc_begin1            ;     jumps to Ltmp10
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp11-Lfunc_begin1            ; >> Call Site 2 <<
	.uleb128 Ltmp12-Ltmp11                  ;   Call between Ltmp11 and Ltmp12
	.uleb128 Ltmp13-Lfunc_begin1            ;     jumps to Ltmp13
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp12-Lfunc_begin1            ; >> Call Site 3 <<
	.uleb128 Ltmp14-Ltmp12                  ;   Call between Ltmp12 and Ltmp14
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp14-Lfunc_begin1            ; >> Call Site 4 <<
	.uleb128 Ltmp15-Ltmp14                  ;   Call between Ltmp14 and Ltmp15
	.uleb128 Ltmp16-Lfunc_begin1            ;     jumps to Ltmp16
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp17-Lfunc_begin1            ; >> Call Site 5 <<
	.uleb128 Ltmp18-Ltmp17                  ;   Call between Ltmp17 and Ltmp18
	.uleb128 Ltmp19-Lfunc_begin1            ;     jumps to Ltmp19
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp18-Lfunc_begin1            ; >> Call Site 6 <<
	.uleb128 Lfunc_end1-Ltmp18              ;   Call between Ltmp18 and Lfunc_end1
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end1:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN7toy_sim3Cpu10RunProgramEv  ; -- Begin function _ZN7toy_sim3Cpu10RunProgramEv
	.p2align	2
__ZN7toy_sim3Cpu10RunProgramEv:         ; @_ZN7toy_sim3Cpu10RunProgramEv
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
Lloh6:
	adrp	x20, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh7:
	add	x20, x20, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu5FetchEv
	ldr	x1, [x0]
	ldrh	w8, [x1]
	ldr	x8, [x20, x8, lsl #3]
	mov	x0, x19
	blr	x8
	b	LBB2_1
	.loh AdrpAdd	Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN7toy_sim3Cpu6DecodeEj       ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj
	.p2align	2
__ZN7toy_sim3Cpu6DecodeEj:              ; @_ZN7toy_sim3Cpu6DecodeEj
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
                                        ; kill: def $w0 killed $w0 def $x0
	lsr	w8, w0, #26
	cmp	w8, #63
	b.hi	LBB3_40
; %bb.1:
	mov	w9, #1                          ; =0x1
	lsl	x9, x9, x8
	mov	x10, #9344                      ; =0x2480
	movk	x10, #144, lsl #16
	movk	x10, #6144, lsl #32
	movk	x10, #32897, lsl #48
	tst	x9, x10
	b.eq	LBB3_37
; %bb.2:
	lsr	w8, w0, #20
	and	w8, w8, #0xfc0
LBB3_3:
	cmp	w8, #831
	b.le	LBB3_8
; %bb.4:
	cmp	w8, #2815
	b.gt	LBB3_14
; %bb.5:
	cmp	w8, #1471
	b.gt	LBB3_24
; %bb.6:
	cmp	w8, #832
	b.eq	LBB3_33
; %bb.7:
	cmp	w8, #1280
	b.eq	LBB3_17
	b	LBB3_40
LBB3_8:
	cmp	w8, #40
	b.le	LBB3_19
; %bb.9:
	cmp	w8, #447
	b.gt	LBB3_31
; %bb.10:
	cmp	w8, #41
	b.eq	LBB3_22
; %bb.11:
	cmp	w8, #62
	b.ne	LBB3_40
; %bb.12:
	tst	w0, #0xffc0
	b.ne	LBB3_53
; %bb.13:
	mov	w9, #0                          ; =0x0
	mov	w12, #0                         ; =0x0
	ubfx	w10, w0, #21, #5
	ubfx	w11, w0, #16, #5
	b	LBB3_46
LBB3_14:
	cmp	w8, #3519
	b.gt	LBB3_28
; %bb.15:
	cmp	w8, #2816
	b.eq	LBB3_34
; %bb.16:
	cmp	w8, #3072
	b.ne	LBB3_40
LBB3_17:
	tst	w0, #0x7ff
	b.ne	LBB3_49
; %bb.18:
	mov	w9, #0                          ; =0x0
	ubfx	w10, w0, #21, #5
	ubfx	w11, w0, #16, #5
	ubfx	w12, w0, #11, #5
	b	LBB3_46
LBB3_19:
	cmp	w8, #16
	b.eq	LBB3_45
; %bb.20:
	cmp	w8, #24
	b.eq	LBB3_22
; %bb.21:
	cmp	w8, #38
	b.ne	LBB3_40
LBB3_22:
	tst	w0, #0x7c0
	b.ne	LBB3_47
; %bb.23:
	mov	w12, #0                         ; =0x0
	ubfx	w10, w0, #21, #5
	ubfx	w11, w0, #16, #5
	ubfx	w9, w0, #11, #5
	b	LBB3_46
LBB3_24:
	cmp	w8, #1472
	b.eq	LBB3_34
; %bb.25:
	cmp	w8, #2752
	b.ne	LBB3_40
; %bb.26:
	tst	w0, #0x3e00000
	b.ne	LBB3_51
; %bb.27:
	mov	w9, #0                          ; =0x0
	mov	w11, #0                         ; =0x0
	and	w12, w0, #0xffff
	ubfx	w10, w0, #16, #5
	b	LBB3_46
LBB3_28:
	cmp	w8, #3520
	b.eq	LBB3_42
; %bb.29:
	cmp	w8, #4032
	b.ne	LBB3_40
; %bb.30:
	ubfx	w10, w0, #21, #5
	ubfx	w11, w0, #16, #5
	and	w12, w0, #0x7ff
	ubfx	w9, w0, #11, #5
	b	LBB3_46
LBB3_31:
	cmp	w8, #448
	b.eq	LBB3_43
; %bb.32:
	cmp	w8, #640
	b.ne	LBB3_40
LBB3_33:
	mov	w9, #0                          ; =0x0
	ubfx	w10, w0, #21, #5
	ubfx	w11, w0, #16, #5
	and	w12, w0, #0xffff
	b	LBB3_46
LBB3_34:
	tst	w0, #0xc000
	b.eq	LBB3_44
; %bb.35:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp35:
Lloh8:
	adrp	x1, l_.str@PAGE
Lloh9:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp36:
; %bb.36:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.6
LBB3_37:
	cbnz	x8, LBB3_40
; %bb.38:
	and	w8, w0, #0x3f
	cmp	w8, #62
	b.hi	LBB3_40
; %bb.39:
	and	x9, x0, #0x3f
	mov	w10, #1                         ; =0x1
	lsl	x9, x10, x9
	mov	x10, #16842752                  ; =0x1010000
	movk	x10, #576, lsl #32
	movk	x10, #16384, lsl #48
	tst	x9, x10
	b.ne	LBB3_3
LBB3_40:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp38:
Lloh10:
	adrp	x1, l_.str@PAGE
Lloh11:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp39:
; %bb.41:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.7
LBB3_42:
	mov	w9, #0                          ; =0x0
	mov	w11, #0                         ; =0x0
	mov	w10, #0                         ; =0x0
	and	w12, w0, #0x3ffffff
	b	LBB3_46
LBB3_43:
	and	w9, w0, #0xc000
	cmp	w9, #8, lsl #12                 ; =32768
	b.ne	LBB3_55
LBB3_44:
	mov	w9, #0                          ; =0x0
	ubfx	w11, w0, #16, #5
	ubfx	w10, w0, #21, #5
	and	w12, w0, #0x3fff
	b	LBB3_46
LBB3_45:
	mov	w9, #0                          ; =0x0
	mov	w11, #0                         ; =0x0
	mov	w10, #0                         ; =0x0
	ubfx	w12, w0, #6, #20
LBB3_46:
	lsl	w11, w11, #24
	orr	x9, x11, x9, lsl #32
	lsl	w10, w10, #16
	mov	w8, w8
	orr	x8, x10, x8
	mov	w1, w12
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB3_47:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp32:
Lloh12:
	adrp	x1, l_.str@PAGE
Lloh13:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp33:
; %bb.48:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.5
LBB3_49:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp23:
Lloh14:
	adrp	x1, l_.str@PAGE
Lloh15:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp24:
; %bb.50:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.2
LBB3_51:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp29:
Lloh16:
	adrp	x1, l_.str@PAGE
Lloh17:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp30:
; %bb.52:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.4
LBB3_53:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp20:
Lloh18:
	adrp	x1, l_.str@PAGE
Lloh19:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp21:
; %bb.54:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.1
LBB3_55:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp26:
Lloh20:
	adrp	x1, l_.str@PAGE
Lloh21:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp27:
; %bb.56:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu6DecodeEj.cold.3
LBB3_57:
Ltmp28:
	b	LBB3_64
LBB3_58:
Ltmp22:
	b	LBB3_64
LBB3_59:
Ltmp31:
	b	LBB3_64
LBB3_60:
Ltmp37:
	b	LBB3_64
LBB3_61:
Ltmp25:
	b	LBB3_64
LBB3_62:
Ltmp40:
	b	LBB3_64
LBB3_63:
Ltmp34:
LBB3_64:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdd	Lloh20, Lloh21
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table3:
Lexception2:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Lfunc_begin2-Lfunc_begin2      ; >> Call Site 1 <<
	.uleb128 Ltmp35-Lfunc_begin2            ;   Call between Lfunc_begin2 and Ltmp35
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp35-Lfunc_begin2            ; >> Call Site 2 <<
	.uleb128 Ltmp36-Ltmp35                  ;   Call between Ltmp35 and Ltmp36
	.uleb128 Ltmp37-Lfunc_begin2            ;     jumps to Ltmp37
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp36-Lfunc_begin2            ; >> Call Site 3 <<
	.uleb128 Ltmp38-Ltmp36                  ;   Call between Ltmp36 and Ltmp38
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp38-Lfunc_begin2            ; >> Call Site 4 <<
	.uleb128 Ltmp39-Ltmp38                  ;   Call between Ltmp38 and Ltmp39
	.uleb128 Ltmp40-Lfunc_begin2            ;     jumps to Ltmp40
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp39-Lfunc_begin2            ; >> Call Site 5 <<
	.uleb128 Ltmp32-Ltmp39                  ;   Call between Ltmp39 and Ltmp32
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp32-Lfunc_begin2            ; >> Call Site 6 <<
	.uleb128 Ltmp33-Ltmp32                  ;   Call between Ltmp32 and Ltmp33
	.uleb128 Ltmp34-Lfunc_begin2            ;     jumps to Ltmp34
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp33-Lfunc_begin2            ; >> Call Site 7 <<
	.uleb128 Ltmp23-Ltmp33                  ;   Call between Ltmp33 and Ltmp23
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp23-Lfunc_begin2            ; >> Call Site 8 <<
	.uleb128 Ltmp24-Ltmp23                  ;   Call between Ltmp23 and Ltmp24
	.uleb128 Ltmp25-Lfunc_begin2            ;     jumps to Ltmp25
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp24-Lfunc_begin2            ; >> Call Site 9 <<
	.uleb128 Ltmp29-Ltmp24                  ;   Call between Ltmp24 and Ltmp29
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp29-Lfunc_begin2            ; >> Call Site 10 <<
	.uleb128 Ltmp30-Ltmp29                  ;   Call between Ltmp29 and Ltmp30
	.uleb128 Ltmp31-Lfunc_begin2            ;     jumps to Ltmp31
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp30-Lfunc_begin2            ; >> Call Site 11 <<
	.uleb128 Ltmp20-Ltmp30                  ;   Call between Ltmp30 and Ltmp20
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp20-Lfunc_begin2            ; >> Call Site 12 <<
	.uleb128 Ltmp21-Ltmp20                  ;   Call between Ltmp20 and Ltmp21
	.uleb128 Ltmp22-Lfunc_begin2            ;     jumps to Ltmp22
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp21-Lfunc_begin2            ; >> Call Site 13 <<
	.uleb128 Ltmp26-Ltmp21                  ;   Call between Ltmp21 and Ltmp26
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp26-Lfunc_begin2            ; >> Call Site 14 <<
	.uleb128 Ltmp27-Ltmp26                  ;   Call between Ltmp26 and Ltmp27
	.uleb128 Ltmp28-Lfunc_begin2            ;     jumps to Ltmp28
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp27-Lfunc_begin2            ; >> Call Site 15 <<
	.uleb128 Lfunc_end2-Ltmp27              ;   Call between Ltmp27 and Lfunc_end2
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end2:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_ ; -- Begin function _ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_
	.globl	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_
	.weak_def_can_be_hidden	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_
	.p2align	2
__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_: ; @_ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE9push_backB9nqe210106ERKS2_
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x21, x1
	mov	x19, x0
	ldp	x10, x9, [x0, #8]
	cmp	x10, x9
	b.hs	LBB4_2
; %bb.1:
	ldr	x8, [x21]
	ldr	w9, [x21, #8]
	str	w9, [x10, #8]
	str	x8, [x10]
	add	x21, x10, #12
	b	LBB4_6
LBB4_2:
	mov	x8, #6148914691236517205        ; =0x5555555555555555
	movk	x8, #5461, lsl #48
	ldr	x20, [x19]
	sub	x22, x10, x20
	asr	x10, x22, #2
	mov	x11, #-6148914691236517206      ; =0xaaaaaaaaaaaaaaaa
	movk	x11, #43691
	mov	x12, #1                         ; =0x1
	madd	x10, x10, x11, x12
	cmp	x10, x8
	b.hi	LBB4_7
; %bb.3:
	sub	x9, x9, x20
	asr	x9, x9, #2
	mul	x9, x9, x11
	lsl	x11, x9, #1
	cmp	x11, x10
	csel	x10, x11, x10, hi
	mov	x11, #-6148914691236517206      ; =0xaaaaaaaaaaaaaaaa
	movk	x11, #2730, lsl #48
	cmp	x9, x11
	csel	x9, x10, x8, lo
	cmp	x9, x8
	b.hi	LBB4_8
; %bb.4:
	add	x8, x9, x9, lsl #1
	lsl	x23, x8, #2
	mov	x0, x23
	bl	__Znwm
	mov	x24, x0
	add	x8, x0, x22
	add	x23, x0, x23
	ldr	x9, [x21]
	str	x9, [x8]
	ldr	w9, [x21, #8]
	str	w9, [x8, #8]
	add	x21, x8, #12
	mov	x1, x20
	mov	x2, x22
	bl	_memcpy
	stp	x24, x21, [x19]
	str	x23, [x19, #16]
	cbz	x20, LBB4_6
; %bb.5:
	mov	x0, x20
	bl	__ZdlPv
LBB4_6:
	str	x21, [x19, #8]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB4_7:
	bl	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev
LBB4_8:
	bl	__ZSt28__throw_bad_array_new_lengthB9nqe210106v
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE ; -- Begin function _ZN7toy_sim3Cpu7ExecuteENS_11InstructionE
	.p2align	2
__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE: ; @_ZN7toy_sim3Cpu7ExecuteENS_11InstructionE
Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception3
; %bb.0:
	sub	sp, sp, #80
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
Lloh22:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh23:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh24:
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x1, [sp, #16]
	mov	w8, #832                        ; =0x340
	stp	w2, w8, [sp, #24]
	strb	wzr, [sp, #32]
	str	wzr, [sp, #36]
	ubfx	w8, w1, #16, #8
	lsr	w9, w1, #24
	and	w11, w1, #0xffff
	cmp	w11, #1279
	b.gt	LBB5_6
; %bb.1:
	cmp	w11, #61
	b.le	LBB5_12
; %bb.2:
	cmp	w11, #639
	b.gt	LBB5_25
; %bb.3:
	cmp	w11, #62
	b.eq	LBB5_39
; %bb.4:
	cmp	w11, #448
	b.ne	LBB5_68
; %bb.5:
Ltmp47:
	add	x1, sp, #16
	bl	__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE
Ltmp48:
	b	LBB5_61
LBB5_6:
	cmp	w11, #2815
	b.le	LBB5_16
; %bb.7:
	cmp	w11, #3519
	b.gt	LBB5_22
; %bb.8:
	cmp	w11, #2816
	b.eq	LBB5_36
; %bb.9:
	cmp	w11, #3072
	b.ne	LBB5_68
; %bb.10:
	cmp	w2, #33
	b.hs	LBB5_64
; %bb.11:
	lsr	x11, x1, #24
	ldr	x10, [x0], #24
	add	x11, x10, w11, uxtb #2
	cmp	w9, #32
	csel	x9, x0, x11, eq
	ldr	w9, [x9]
	neg	w11, w2
	mov	w12, #-1                        ; =0xffffffff
	lsr	w11, w12, w11
	cmp	w9, w11
	csel	w9, w9, w11, lo
	b	LBB5_55
LBB5_12:
	ubfx	x10, x1, #32, #8
	cmp	w11, #37
	b.le	LBB5_29
; %bb.13:
	cmp	w11, #38
	b.eq	LBB5_44
; %bb.14:
	cmp	w11, #41
	b.ne	LBB5_68
; %bb.15:
	lsr	x12, x1, #24
	ldr	x11, [x0], #24
	lsr	x13, x1, #16
	add	x13, x11, w13, uxtb #2
	cmp	w8, #32
	csel	x8, x0, x13, eq
	ldr	w8, [x8]
	add	x12, x11, w12, uxtb #2
	cmp	w9, #32
	csel	x9, x0, x12, eq
	ldr	w9, [x9]
	orr	w8, w9, w8
	mvn	w8, w8
	cmp	w10, #32
	b.ne	LBB5_31
	b	LBB5_43
LBB5_16:
	cmp	w11, #1280
	b.eq	LBB5_32
; %bb.17:
	cmp	w11, #1472
	b.eq	LBB5_48
; %bb.18:
	cmp	w11, #2752
	b.ne	LBB5_68
; %bb.19:
	sxth	w9, w2
	cmp	w8, #32
	b.eq	LBB5_21
; %bb.20:
	ubfx	x8, x1, #16, #8
	ldr	x10, [x0]
	str	w9, [x10, x8, lsl #2]
	ldr	w9, [x0, #24]
LBB5_21:
	ldr	w8, [sp, #36]
	lsl	w8, w8, #16
	add	w8, w9, w8, asr #14
	add	w8, w8, #4
	b	LBB5_38
LBB5_22:
	cmp	w11, #3520
	b.eq	LBB5_37
; %bb.23:
	cmp	w11, #4032
	b.ne	LBB5_68
; %bb.24:
Ltmp49:
	add	x1, sp, #16
	bl	__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE
Ltmp50:
	b	LBB5_61
LBB5_25:
	cmp	w11, #640
	b.eq	LBB5_40
; %bb.26:
	cmp	w11, #832
	b.ne	LBB5_68
; %bb.27:
	lsr	x10, x1, #24
	lsr	x11, x1, #16
	ldr	x12, [x0], #24
	add	x11, x12, w11, uxtb #2
	cmp	w8, #32
	csel	x8, x0, x11, eq
	ldr	w8, [x8]
	add	x10, x12, w10, uxtb #2
	cmp	w9, #32
	csel	x9, x0, x10, eq
	ldr	w9, [x9]
	cmp	w8, w9
	b.ne	LBB5_49
; %bb.28:
	lsl	w8, w2, #16
	ldr	w9, [x0]
	add	w8, w9, w8, asr #14
	b	LBB5_60
LBB5_29:
	cmp	w11, #24
	b.ne	LBB5_66
; %bb.30:
	lsr	x12, x1, #24
	lsr	x13, x1, #16
	ldr	x11, [x0], #24
	add	x13, x11, w13, uxtb #2
	cmp	w8, #32
	csel	x8, x0, x13, eq
	ldr	w8, [x8]
	add	x12, x11, w12, uxtb #2
	cmp	w9, #32
	csel	x9, x0, x12, eq
	ldr	w9, [x9]
	add	w8, w9, w8
	cmp	w10, #32
	b.eq	LBB5_43
LBB5_31:
	str	w8, [x11, x10, lsl #2]
	b	LBB5_42
LBB5_32:
	lsr	x11, x1, #24
	ldr	x10, [x0], #24
	add	x11, x10, w11, uxtb #2
	cmp	w9, #32
	csel	x9, x0, x11, eq
	cmp	w2, #32
	b.hs	LBB5_63
; %bb.33:
	cbz	w2, LBB5_52
; %bb.34:
	ldr	w9, [x9]
	sub	w11, w2, #1
	mov	w12, #1                         ; =0x1
	lsl	w12, w12, w11
	neg	w11, w12
	sub	w12, w12, #1
	stp	w12, w11, [sp, #8]
	cmp	w9, #1
	b.lt	LBB5_53
; %bb.35:
	str	w9, [sp, #4]
	cmp	w9, w12
	add	x9, sp, #8
	add	x11, sp, #4
	csel	x9, x11, x9, lo
	b	LBB5_54
LBB5_36:
Ltmp51:
	add	x1, sp, #16
	bl	__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE
Ltmp52:
	b	LBB5_61
LBB5_37:
	ldr	w8, [x0, #24]
	and	w8, w8, #0xf0000000
	orr	w8, w8, w2, lsl #2
LBB5_38:
	str	w8, [x0, #24]
	b	LBB5_61
LBB5_39:
	lsr	x11, x1, #24
	ldr	x10, [x0], #24
	add	x11, x10, w11, uxtb #2
	cmp	w9, #32
	csel	x9, x0, x11, eq
	ldr	w9, [x9]
	rbit	w9, w9
	b	LBB5_55
LBB5_40:
	lsr	x11, x1, #16
	ldr	x10, [x0], #24
	add	x11, x10, w11, uxtb #2
	cmp	w8, #32
	csel	x8, x0, x11, eq
	ldr	w8, [x8]
	add	w8, w8, w2, sxth
	cmp	w9, #32
	b.eq	LBB5_43
; %bb.41:
	str	w8, [x10, x9, lsl #2]
LBB5_42:
	ldr	w8, [x0]
LBB5_43:
	ldr	w9, [sp, #36]
	lsl	w9, w9, #16
	add	w8, w8, w9, asr #14
	b	LBB5_59
LBB5_44:
	lsr	x13, x1, #32
	lsr	x12, x1, #24
	ldr	x11, [x0], #24
	add	x12, x11, w12, uxtb #2
	cmp	w9, #32
	csel	x12, x0, x12, eq
	add	x9, x11, w13, uxtb #2
	cmp	w10, #32
	csel	x9, x0, x9, eq
	ldr	w10, [x9]
	cbz	w10, LBB5_50
; %bb.45:
	mov	w9, #0                          ; =0x0
	ldr	w12, [x12]
	mov	w13, #1                         ; =0x1
LBB5_46:                                ; =>This Inner Loop Header: Depth=1
	neg	w14, w10
	and	w14, w10, w14
	tst	w14, w12
	csel	w15, wzr, w13, eq
	orr	w9, w15, w9
	lsl	w13, w13, #1
	subs	w10, w10, w14
	b.ne	LBB5_46
; %bb.47:
	cmp	w8, #32
	b.ne	LBB5_51
	b	LBB5_58
LBB5_48:
Ltmp53:
	add	x1, sp, #16
	bl	__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE
Ltmp54:
	b	LBB5_61
LBB5_49:
	ldr	w8, [x0]
	b	LBB5_59
LBB5_50:
	mov	w9, #0                          ; =0x0
	cmp	w8, #32
	b.eq	LBB5_58
LBB5_51:
	ubfx	x8, x1, #16, #8
	str	w9, [x11, x8, lsl #2]
	b	LBB5_57
LBB5_52:
	mov	w9, #0                          ; =0x0
	b	LBB5_55
LBB5_53:
	str	w9, [sp, #4]
	cmp	w9, w11
	add	x9, sp, #12
	add	x11, sp, #4
	csel	x9, x11, x9, gt
LBB5_54:
	ldr	w9, [x9]
LBB5_55:
	cmp	w8, #32
	b.eq	LBB5_58
; %bb.56:
	ubfx	x8, x1, #16, #8
	str	w9, [x10, x8, lsl #2]
LBB5_57:
	ldr	w9, [x0]
LBB5_58:
	ldr	w8, [sp, #36]
	lsl	w8, w8, #16
	add	w8, w9, w8, asr #14
LBB5_59:
	add	w8, w8, #4
LBB5_60:
	str	w8, [x0]
LBB5_61:
	ldur	x8, [x29, #-24]
Lloh25:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh26:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh27:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB5_65
; %bb.62:
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
LBB5_63:
Ltmp45:
	bl	__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.2
Ltmp46:
	b	LBB5_70
LBB5_64:
Ltmp41:
	bl	__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.1
Ltmp42:
	b	LBB5_70
LBB5_65:
	bl	___stack_chk_fail
LBB5_66:
	cmp	w11, #16
	b.ne	LBB5_68
; %bb.67:
Ltmp43:
	add	x1, sp, #16
	bl	__ZN7toy_sim12_GLOBAL__N_114ExecuteSyscallERNS_3CpuEPKNS_11InstructionE
Ltmp44:
	b	LBB5_70
LBB5_68:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp55:
Lloh28:
	adrp	x1, l_.str.10@PAGE
Lloh29:
	add	x1, x1, l_.str.10@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp56:
; %bb.69:
Ltmp58:
	mov	x0, x19
	bl	__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.3
Ltmp59:
LBB5_70:
	brk	#0x1
LBB5_71:
Ltmp57:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
LBB5_72:
Ltmp60:
	bl	__Unwind_Resume
	.loh AdrpLdrGotLdr	Lloh22, Lloh23, Lloh24
	.loh AdrpLdrGotLdr	Lloh25, Lloh26, Lloh27
	.loh AdrpAdd	Lloh28, Lloh29
Lfunc_end3:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table5:
Lexception3:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end3-Lcst_begin3
Lcst_begin3:
	.uleb128 Ltmp47-Lfunc_begin3            ; >> Call Site 1 <<
	.uleb128 Ltmp42-Ltmp47                  ;   Call between Ltmp47 and Ltmp42
	.uleb128 Ltmp60-Lfunc_begin3            ;     jumps to Ltmp60
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp42-Lfunc_begin3            ; >> Call Site 2 <<
	.uleb128 Ltmp43-Ltmp42                  ;   Call between Ltmp42 and Ltmp43
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp43-Lfunc_begin3            ; >> Call Site 3 <<
	.uleb128 Ltmp44-Ltmp43                  ;   Call between Ltmp43 and Ltmp44
	.uleb128 Ltmp60-Lfunc_begin3            ;     jumps to Ltmp60
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp44-Lfunc_begin3            ; >> Call Site 4 <<
	.uleb128 Ltmp55-Ltmp44                  ;   Call between Ltmp44 and Ltmp55
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp55-Lfunc_begin3            ; >> Call Site 5 <<
	.uleb128 Ltmp56-Ltmp55                  ;   Call between Ltmp55 and Ltmp56
	.uleb128 Ltmp57-Lfunc_begin3            ;     jumps to Ltmp57
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp58-Lfunc_begin3            ; >> Call Site 6 <<
	.uleb128 Ltmp59-Ltmp58                  ;   Call between Ltmp58 and Ltmp59
	.uleb128 Ltmp60-Lfunc_begin3            ;     jumps to Ltmp60
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp59-Lfunc_begin3            ; >> Call Site 7 <<
	.uleb128 Lfunc_end3-Ltmp59              ;   Call between Ltmp59 and Lfunc_end3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end3:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE
Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception4
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldrb	w10, [x1, #2]
	mov	x8, x0
	ldr	x9, [x8], #24
	add	x11, x9, x10, lsl #2
	cmp	w10, #32
	csel	x10, x8, x11, eq
	ldr	w10, [x10]
	ldr	w11, [x1, #8]
	lsl	w11, w11, #18
	add	w10, w10, w11, asr #18
	tst	x10, #0x3
	b.ne	LBB6_6
; %bb.1:
	ldr	x11, [x0, #32]
	ldr	x12, [x11]
	sub	x12, x12, #4
	cmp	x12, x10
	b.lo	LBB6_8
; %bb.2:
	ldrb	w12, [x1, #3]
	ldr	x11, [x11, #8]
	ldr	w10, [x11, x10]
	cmp	w12, #32
	b.ne	LBB6_4
; %bb.3:
	str	w10, [x8]
	b	LBB6_5
LBB6_4:
	str	w10, [x9, x12, lsl #2]
	ldr	w10, [x8]
LBB6_5:
	add	w8, w10, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh30:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh31:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	br	x2
LBB6_6:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp61:
Lloh32:
	adrp	x1, l_.str.8@PAGE
Lloh33:
	add	x1, x1, l_.str.8@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp62:
; %bb.7:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.1
LBB6_8:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp64:
Lloh34:
	adrp	x1, l_.str.6@PAGE
Lloh35:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp65:
; %bb.9:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.2
LBB6_10:
Ltmp66:
	b	LBB6_12
LBB6_11:
Ltmp63:
LBB6_12:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh32, Lloh33
	.loh AdrpAdd	Lloh34, Lloh35
Lfunc_end4:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table6:
Lexception4:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end4-Lcst_begin4
Lcst_begin4:
	.uleb128 Lfunc_begin4-Lfunc_begin4      ; >> Call Site 1 <<
	.uleb128 Ltmp61-Lfunc_begin4            ;   Call between Lfunc_begin4 and Ltmp61
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp61-Lfunc_begin4            ; >> Call Site 2 <<
	.uleb128 Ltmp62-Ltmp61                  ;   Call between Ltmp61 and Ltmp62
	.uleb128 Ltmp63-Lfunc_begin4            ;     jumps to Ltmp63
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp62-Lfunc_begin4            ; >> Call Site 3 <<
	.uleb128 Ltmp64-Ltmp62                  ;   Call between Ltmp62 and Ltmp64
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp64-Lfunc_begin4            ; >> Call Site 4 <<
	.uleb128 Ltmp65-Ltmp64                  ;   Call between Ltmp64 and Ltmp65
	.uleb128 Ltmp66-Lfunc_begin4            ;     jumps to Ltmp66
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp65-Lfunc_begin4            ; >> Call Site 5 <<
	.uleb128 Lfunc_end4-Ltmp65              ;   Call between Ltmp65 and Lfunc_end4
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end4:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteAddERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_110ExecuteAddERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteAddERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x1, #4]
	mov	x9, x0
	ldr	x10, [x9], #24
	ldrb	w11, [x1, #2]
	add	x12, x10, x11, lsl #2
	cmp	w11, #32
	csel	x11, x9, x12, eq
	ldr	w11, [x11]
	ldrb	w12, [x1, #3]
	add	x13, x10, x12, lsl #2
	cmp	w12, #32
	csel	x12, x9, x13, eq
	ldr	w12, [x12]
	add	w11, w12, w11
	cmp	x8, #32
	b.eq	LBB7_2
; %bb.1:
	str	w11, [x10, x8, lsl #2]
	ldr	w11, [x9]
LBB7_2:
	add	w8, w11, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh36:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh37:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
	.loh AdrpAdd	Lloh36, Lloh37
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteBeqERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_110ExecuteBeqERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteBeqERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x1, #2]
	ldr	x9, [x0], #24
	add	x10, x9, x8, lsl #2
	cmp	w8, #32
	csel	x8, x0, x10, eq
	ldr	w8, [x8]
	ldrb	w10, [x1, #3]
	add	x9, x9, x10, lsl #2
	cmp	w10, #32
	csel	x9, x0, x9, eq
	ldr	w9, [x9]
	cmp	w8, w9
	b.ne	LBB8_2
; %bb.1:
	ldr	w8, [x1, #8]
	lsl	w8, w8, #16
	ldr	w9, [x0]
	add	w8, w9, w8, asr #14
	str	w8, [x0]
	ret
LBB8_2:
	ldr	w8, [x0]
	add	w8, w8, #4
	str	w8, [x0]
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteLiERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_19ExecuteLiERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteLiERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w9, [x1, #2]
	ldrsh	w8, [x1, #8]
	cmp	x9, #32
	b.eq	LBB9_2
; %bb.1:
	ldr	x10, [x0]
	str	w8, [x10, x9, lsl #2]
	ldr	w8, [x0, #24]
LBB9_2:
	add	w8, w8, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh38:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh39:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
	.loh AdrpAdd	Lloh38, Lloh39
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE
Lfunc_begin5:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception5
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldrb	w10, [x1, #2]
	mov	x8, x0
	ldr	x9, [x8], #24
	add	x11, x9, x10, lsl #2
	cmp	w10, #32
	csel	x10, x8, x11, eq
	ldr	w10, [x10]
	ldr	w11, [x1, #8]
	lsl	w11, w11, #18
	add	w10, w10, w11, asr #18
	tst	x10, #0x3
	b.ne	LBB10_3
; %bb.1:
	ldr	x11, [x0, #32]
	ldr	x12, [x11]
	sub	x12, x12, #4
	cmp	x12, x10
	b.lo	LBB10_5
; %bb.2:
	ldrb	w12, [x1, #3]
	add	x9, x9, x12, lsl #2
	cmp	w12, #32
	csel	x8, x8, x9, eq
	ldr	w8, [x8]
	ldr	x9, [x11, #8]
	str	w8, [x9, x10]
	ldr	w8, [x0, #24]
	add	w8, w8, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh40:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh41:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	br	x2
LBB10_3:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp67:
Lloh42:
	adrp	x1, l_.str.8@PAGE
Lloh43:
	add	x1, x1, l_.str.8@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp68:
; %bb.4:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.1
LBB10_5:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp70:
Lloh44:
	adrp	x1, l_.str.6@PAGE
Lloh45:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp71:
; %bb.6:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.2
LBB10_7:
Ltmp72:
	b	LBB10_9
LBB10_8:
Ltmp69:
LBB10_9:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh42, Lloh43
	.loh AdrpAdd	Lloh44, Lloh45
Lfunc_end5:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table10:
Lexception5:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end5-Lcst_begin5
Lcst_begin5:
	.uleb128 Lfunc_begin5-Lfunc_begin5      ; >> Call Site 1 <<
	.uleb128 Ltmp67-Lfunc_begin5            ;   Call between Lfunc_begin5 and Ltmp67
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp67-Lfunc_begin5            ; >> Call Site 2 <<
	.uleb128 Ltmp68-Ltmp67                  ;   Call between Ltmp67 and Ltmp68
	.uleb128 Ltmp69-Lfunc_begin5            ;     jumps to Ltmp69
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp68-Lfunc_begin5            ; >> Call Site 3 <<
	.uleb128 Ltmp70-Ltmp68                  ;   Call between Ltmp68 and Ltmp70
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp70-Lfunc_begin5            ; >> Call Site 4 <<
	.uleb128 Ltmp71-Ltmp70                  ;   Call between Ltmp70 and Ltmp71
	.uleb128 Ltmp72-Lfunc_begin5            ;     jumps to Ltmp72
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp71-Lfunc_begin5            ; >> Call Site 5 <<
	.uleb128 Lfunc_end5-Ltmp71              ;   Call between Ltmp71 and Lfunc_end5
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end5:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE
Lfunc_begin6:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception6
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldrb	w9, [x1, #2]
	mov	x8, x0
	ldr	x10, [x8], #24
	add	x11, x10, x9, lsl #2
	cmp	w9, #32
	csel	x9, x8, x11, eq
	ldr	w9, [x9]
	ldr	w11, [x1, #8]
	lsl	w11, w11, #21
	add	w9, w9, w11, asr #21
	tst	x9, #0x3
	b.ne	LBB11_4
; %bb.1:
	ldr	x11, [x0, #32]
	ldr	x12, [x11]
	sub	x12, x12, #4
	cmp	x12, x9
	b.lo	LBB11_6
; %bb.2:
	ldrb	w12, [x1, #3]
	add	x10, x10, x12, lsl #2
	cmp	w12, #32
	csel	x10, x8, x10, eq
	ldr	w10, [x10]
	ldr	x11, [x11, #8]
	str	w10, [x11, x9]
	ldr	x10, [x0, #32]
	add	w9, w9, #4
	ldr	x11, [x10]
	sub	x11, x11, #4
	cmp	x11, x9
	b.lo	LBB11_8
; %bb.3:
	ldrb	w11, [x1, #4]
	ldr	x12, [x0]
	add	x12, x12, x11, lsl #2
	cmp	w11, #32
	csel	x8, x8, x12, eq
	ldr	w8, [x8]
	ldr	x10, [x10, #8]
	str	w8, [x10, x9]
	ldr	w8, [x0, #24]
	add	w8, w8, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh46:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh47:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	br	x2
LBB11_4:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp73:
Lloh48:
	adrp	x1, l_.str.8@PAGE
Lloh49:
	add	x1, x1, l_.str.8@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp74:
; %bb.5:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.1
LBB11_6:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp79:
Lloh50:
	adrp	x1, l_.str.6@PAGE
Lloh51:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp80:
; %bb.7:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.3
LBB11_8:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp76:
Lloh52:
	adrp	x1, l_.str.6@PAGE
Lloh53:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp77:
; %bb.9:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.2
LBB11_10:
Ltmp78:
	b	LBB11_13
LBB11_11:
Ltmp81:
	b	LBB11_13
LBB11_12:
Ltmp75:
LBB11_13:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpAdd	Lloh48, Lloh49
	.loh AdrpAdd	Lloh50, Lloh51
	.loh AdrpAdd	Lloh52, Lloh53
Lfunc_end6:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table11:
Lexception6:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end6-Lcst_begin6
Lcst_begin6:
	.uleb128 Lfunc_begin6-Lfunc_begin6      ; >> Call Site 1 <<
	.uleb128 Ltmp73-Lfunc_begin6            ;   Call between Lfunc_begin6 and Ltmp73
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp73-Lfunc_begin6            ; >> Call Site 2 <<
	.uleb128 Ltmp74-Ltmp73                  ;   Call between Ltmp73 and Ltmp74
	.uleb128 Ltmp75-Lfunc_begin6            ;     jumps to Ltmp75
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp74-Lfunc_begin6            ; >> Call Site 3 <<
	.uleb128 Ltmp79-Ltmp74                  ;   Call between Ltmp74 and Ltmp79
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp79-Lfunc_begin6            ; >> Call Site 4 <<
	.uleb128 Ltmp80-Ltmp79                  ;   Call between Ltmp79 and Ltmp80
	.uleb128 Ltmp81-Lfunc_begin6            ;     jumps to Ltmp81
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp80-Lfunc_begin6            ; >> Call Site 5 <<
	.uleb128 Ltmp76-Ltmp80                  ;   Call between Ltmp80 and Ltmp76
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp76-Lfunc_begin6            ; >> Call Site 6 <<
	.uleb128 Ltmp77-Ltmp76                  ;   Call between Ltmp76 and Ltmp77
	.uleb128 Ltmp78-Lfunc_begin6            ;     jumps to Ltmp78
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp77-Lfunc_begin6            ; >> Call Site 7 <<
	.uleb128 Lfunc_end6-Ltmp77              ;   Call between Ltmp77 and Lfunc_end6
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end6:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteAddiERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_111ExecuteAddiERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteAddiERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x1, #3]
	ldrb	w10, [x1, #2]
	mov	x9, x0
	ldr	x11, [x9], #24
	add	x12, x11, x10, lsl #2
	cmp	w10, #32
	csel	x10, x9, x12, eq
	ldr	w10, [x10]
	ldrsh	w12, [x1, #8]
	add	w10, w12, w10
	cmp	x8, #32
	b.eq	LBB12_2
; %bb.1:
	str	w10, [x11, x8, lsl #2]
	ldr	w10, [x9]
LBB12_2:
	add	w8, w10, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh54:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh55:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
	.loh AdrpAdd	Lloh54, Lloh55
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_18ExecuteJERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_18ExecuteJERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_18ExecuteJERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldr	w8, [x0, #24]
	and	w8, w8, #0xf0000000
	ldr	w9, [x1, #8]
	orr	w8, w8, w9, lsl #2
	str	w8, [x0, #24]
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE
Lfunc_begin7:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception7
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldrb	w8, [x1, #2]
	cmp	x8, #32
	b.ne	LBB14_2
; %bb.1:
	ldr	w9, [x0, #24]
	b	LBB14_3
LBB14_2:
	ldr	x9, [x0]
	ldr	w9, [x9, x8, lsl #2]
LBB14_3:
	tst	w9, #0x3
	b.ne	LBB14_11
; %bb.4:
	ldr	x10, [x0, #32]
	mov	w9, w9
	ldr	x11, [x10]
	sub	x11, x11, #4
	cmp	x11, x9
	b.lo	LBB14_13
; %bb.5:
	ldrb	w11, [x1, #3]
	ldr	x10, [x10, #8]
	ldr	w9, [x10, x9]
	cmp	w11, #32
	b.ne	LBB14_8
; %bb.6:
	str	w9, [x0, #24]
	cmp	w8, #32
	b.eq	LBB14_9
LBB14_7:
	ldr	x9, [x0]
	ldr	w10, [x9, x8, lsl #2]
	ldr	w11, [x1, #8]
	lsl	w11, w11, #18
	add	w10, w10, w11, asr #18
	str	w10, [x9, x8, lsl #2]
	ldr	w8, [x0, #24]
	b	LBB14_10
LBB14_8:
	ldr	x10, [x0]
	str	w9, [x10, x11, lsl #2]
	cmp	w8, #32
	b.ne	LBB14_7
LBB14_9:
	ldr	w8, [x0, #24]
	ldr	w9, [x1, #8]
	lsl	w9, w9, #18
	add	w8, w8, w9, asr #18
	str	w8, [x0, #24]
LBB14_10:
	add	w8, w8, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh56:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh57:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	br	x2
LBB14_11:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp82:
Lloh58:
	adrp	x1, l_.str.8@PAGE
Lloh59:
	add	x1, x1, l_.str.8@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp83:
; %bb.12:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.1
LBB14_13:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp85:
Lloh60:
	adrp	x1, l_.str.6@PAGE
Lloh61:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp86:
; %bb.14:
	mov	x0, x19
	bl	__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.2
LBB14_15:
Ltmp87:
	b	LBB14_17
LBB14_16:
Ltmp84:
LBB14_17:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpAdd	Lloh60, Lloh61
Lfunc_end7:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table14:
Lexception7:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end7-Lcst_begin7
Lcst_begin7:
	.uleb128 Lfunc_begin7-Lfunc_begin7      ; >> Call Site 1 <<
	.uleb128 Ltmp82-Lfunc_begin7            ;   Call between Lfunc_begin7 and Ltmp82
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp82-Lfunc_begin7            ; >> Call Site 2 <<
	.uleb128 Ltmp83-Ltmp82                  ;   Call between Ltmp82 and Ltmp83
	.uleb128 Ltmp84-Lfunc_begin7            ;     jumps to Ltmp84
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp83-Lfunc_begin7            ; >> Call Site 3 <<
	.uleb128 Ltmp85-Ltmp83                  ;   Call between Ltmp83 and Ltmp85
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp85-Lfunc_begin7            ; >> Call Site 4 <<
	.uleb128 Ltmp86-Ltmp85                  ;   Call between Ltmp85 and Ltmp86
	.uleb128 Ltmp87-Lfunc_begin7            ;     jumps to Ltmp87
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp86-Lfunc_begin7            ; >> Call Site 5 <<
	.uleb128 Lfunc_end7-Ltmp86              ;   Call between Ltmp86 and Lfunc_end7
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end7:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteNorERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_110ExecuteNorERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteNorERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x1, #4]
	ldrb	w11, [x1, #2]
	mov	x9, x0
	ldr	x10, [x9], #24
	add	x12, x10, x11, lsl #2
	cmp	w11, #32
	csel	x11, x9, x12, eq
	ldr	w11, [x11]
	ldrb	w12, [x1, #3]
	add	x13, x10, x12, lsl #2
	cmp	w12, #32
	csel	x12, x9, x13, eq
	ldr	w12, [x12]
	orr	w11, w12, w11
	mvn	w11, w11
	cmp	x8, #32
	b.eq	LBB15_2
; %bb.1:
	str	w11, [x10, x8, lsl #2]
	ldr	w11, [x9]
LBB15_2:
	add	w8, w11, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh62:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh63:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
	.loh AdrpAdd	Lloh62, Lloh63
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x0
	ldr	x9, [x8], #24
	ldrb	w10, [x1, #3]
	add	x11, x9, x10, lsl #2
	cmp	w10, #32
	csel	x11, x8, x11, eq
	ldr	w12, [x1, #8]
	cmp	w12, #32
	b.hs	LBB16_9
; %bb.1:
	ldrb	w10, [x1, #2]
	cbz	w12, LBB16_4
; %bb.2:
	ldr	w11, [x11]
	sub	w12, w12, #1
	mov	w13, #1                         ; =0x1
	lsl	w13, w13, w12
	neg	w12, w13
	stur	w12, [x29, #-4]
	sub	w13, w13, #1
	str	w13, [sp, #8]
	cmp	w11, #1
	b.lt	LBB16_5
; %bb.3:
	str	w11, [sp, #4]
	cmp	w11, w13
	add	x11, sp, #8
	add	x12, sp, #4
	csel	x11, x12, x11, lo
	b	LBB16_6
LBB16_4:
	mov	w11, #0                         ; =0x0
	cmp	w10, #32
	b.ne	LBB16_7
	b	LBB16_8
LBB16_5:
	str	w11, [sp, #4]
	cmp	w11, w12
	sub	x11, x29, #4
	add	x12, sp, #4
	csel	x11, x12, x11, gt
LBB16_6:
	ldr	w11, [x11]
	cmp	w10, #32
	b.eq	LBB16_8
LBB16_7:
	str	w11, [x9, x10, lsl #2]
	ldr	w11, [x8]
LBB16_8:
	add	w8, w11, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh64:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh65:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	br	x2
LBB16_9:
	bl	__ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE.cold.1
	.loh AdrpAdd	Lloh64, Lloh65
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteRbitERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_111ExecuteRbitERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteRbitERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x1, #2]
	ldrb	w9, [x1, #3]
	mov	x10, x0
	ldr	x11, [x10], #24
	add	x12, x11, x9, lsl #2
	cmp	w9, #32
	csel	x9, x10, x12, eq
	ldr	w9, [x9]
	rbit	w9, w9
	cmp	x8, #32
	b.eq	LBB17_2
; %bb.1:
	str	w9, [x11, x8, lsl #2]
	ldr	w9, [x10]
LBB17_2:
	add	w8, w9, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh66:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh67:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
	.loh AdrpAdd	Lloh66, Lloh67
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_114ExecuteSyscallERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_114ExecuteSyscallERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_114ExecuteSyscallERNS_3CpuEPKNS_11InstructionE



	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	ldr	w8, [x0, #24]
	add	w8, w8, #4
	str	w8, [x0, #24]
	mov	w0, #4                          ; =0x4
	bl	___cxa_allocate_exception
	ldr	w8, [x19, #8]
	str	w8, [x0]
Lloh68:
	adrp	x1, __ZTIN7toy_sim16SyscallExceptionE@PAGE
Lloh69:
	add	x1, x1, __ZTIN7toy_sim16SyscallExceptionE@PAGEOFF
	mov	x2, #0                          ; =0x0
	bl	___cxa_throw



                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteBextERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_111ExecuteBextERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteBextERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x1, #2]
	ldrb	w11, [x1, #3]
	mov	x9, x0
	ldr	x10, [x9], #24
	add	x12, x10, x11, lsl #2
	cmp	w11, #32
	csel	x13, x9, x12, eq
	ldrb	w11, [x1, #4]
	add	x12, x10, x11, lsl #2
	cmp	w11, #32
	csel	x11, x9, x12, eq
	ldr	w12, [x11]
	cbz	w12, LBB19_6
; %bb.1:
	mov	w11, #0                         ; =0x0
	ldr	w13, [x13]
	mov	w14, #1                         ; =0x1
LBB19_2:                                ; =>This Inner Loop Header: Depth=1
	neg	w15, w12
	and	w15, w12, w15
	tst	w15, w13
	csel	w16, wzr, w14, eq
	orr	w11, w16, w11
	lsl	w14, w14, #1
	subs	w12, w12, w15
	b.ne	LBB19_2
; %bb.3:
	cmp	w8, #32
	b.eq	LBB19_5
LBB19_4:
	str	w11, [x10, x8, lsl #2]
	ldr	w11, [x9]
LBB19_5:
	add	w8, w11, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh70:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh71:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
LBB19_6:
	mov	w11, #0                         ; =0x0
	cmp	w8, #32
	b.ne	LBB19_4
	b	LBB19_5
	.loh AdrpAdd	Lloh70, Lloh71
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE
	.cfi_startproc
; %bb.0:
	ldr	w9, [x1, #8]
	cmp	w9, #33
	b.hs	LBB20_4
; %bb.1:
	ldrb	w8, [x1, #2]
	ldrb	w12, [x1, #3]
	mov	x10, x0
	ldr	x11, [x10], #24
	add	x13, x11, x12, lsl #2
	cmp	w12, #32
	csel	x12, x10, x13, eq
	ldr	w12, [x12]
	neg	w9, w9
	mov	w13, #-1                        ; =0xffffffff
	lsr	w9, w13, w9
	cmp	w12, w9
	csel	w9, w12, w9, lo
	cmp	w8, #32
	b.eq	LBB20_3
; %bb.2:
	str	w9, [x11, x8, lsl #2]
	ldr	w9, [x10]
LBB20_3:
	add	w8, w9, #4
	str	w8, [x0, #24]
	ldrh	w8, [x1, #12]!
Lloh72:
	adrp	x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGE
Lloh73:
	add	x9, x9, __ZN7toy_sim12_GLOBAL__N_19kHandlersE@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	br	x2
LBB20_4:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE.cold.1
	.loh AdrpAdd	Lloh72, Lloh73
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_114ExecuteUnknownERNS_3CpuEPKNS_11InstructionE
__ZN7toy_sim12_GLOBAL__N_114ExecuteUnknownERNS_3CpuEPKNS_11InstructionE: ; @_ZN7toy_sim12_GLOBAL__N_114ExecuteUnknownERNS_3CpuEPKNS_11InstructionE
Lfunc_begin8:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception8
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp88:
Lloh74:
	adrp	x1, l_.str.10@PAGE
Lloh75:
	add	x1, x1, l_.str.10@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp89:
; %bb.1:
Lloh76:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh77:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh78:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh79:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB21_2:
Ltmp90:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpLdrGot	Lloh78, Lloh79
	.loh AdrpLdrGot	Lloh76, Lloh77
Lfunc_end8:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table21:
Lexception8:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end8-Lcst_begin8
Lcst_begin8:
	.uleb128 Lfunc_begin8-Lfunc_begin8      ; >> Call Site 1 <<
	.uleb128 Ltmp88-Lfunc_begin8            ;   Call between Lfunc_begin8 and Ltmp88
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp88-Lfunc_begin8            ; >> Call Site 2 <<
	.uleb128 Ltmp89-Ltmp88                  ;   Call between Ltmp88 and Ltmp89
	.uleb128 Ltmp90-Lfunc_begin8            ;     jumps to Ltmp90
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp89-Lfunc_begin8            ; >> Call Site 3 <<
	.uleb128 Lfunc_end8-Ltmp89              ;   Call between Ltmp89 and Lfunc_end8
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end8:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev ; -- Begin function _ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev
	.globl	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev
	.weak_def_can_be_hidden	__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev
	.p2align	2
__ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev: ; @_ZNSt3__16vectorIN7toy_sim11InstructionENS_9allocatorIS2_EEE20__throw_length_errorB9nqe210106Ev
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh80:
	adrp	x0, l_.str.1@PAGE
Lloh81:
	add	x0, x0, l_.str.1@PAGEOFF
	bl	__ZNSt3__120__throw_length_errorB9nqe210106EPKc
	.loh AdrpAdd	Lloh80, Lloh81
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__120__throw_length_errorB9nqe210106EPKc ; -- Begin function _ZNSt3__120__throw_length_errorB9nqe210106EPKc
	.globl	__ZNSt3__120__throw_length_errorB9nqe210106EPKc
	.weak_def_can_be_hidden	__ZNSt3__120__throw_length_errorB9nqe210106EPKc
	.p2align	2
__ZNSt3__120__throw_length_errorB9nqe210106EPKc: ; @_ZNSt3__120__throw_length_errorB9nqe210106EPKc
Lfunc_begin9:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception9
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x20, x0
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp91:
	mov	x1, x20
	bl	__ZNSt12length_errorC1B9nqe210106EPKc
Ltmp92:
; %bb.1:
Lloh82:
	adrp	x1, __ZTISt12length_error@GOTPAGE
Lloh83:
	ldr	x1, [x1, __ZTISt12length_error@GOTPAGEOFF]
Lloh84:
	adrp	x2, __ZNSt12length_errorD1Ev@GOTPAGE
Lloh85:
	ldr	x2, [x2, __ZNSt12length_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB23_2:
Ltmp93:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpLdrGot	Lloh84, Lloh85
	.loh AdrpLdrGot	Lloh82, Lloh83
Lfunc_end9:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table23:
Lexception9:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end9-Lcst_begin9
Lcst_begin9:
	.uleb128 Lfunc_begin9-Lfunc_begin9      ; >> Call Site 1 <<
	.uleb128 Ltmp91-Lfunc_begin9            ;   Call between Lfunc_begin9 and Ltmp91
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp91-Lfunc_begin9            ; >> Call Site 2 <<
	.uleb128 Ltmp92-Ltmp91                  ;   Call between Ltmp91 and Ltmp92
	.uleb128 Ltmp93-Lfunc_begin9            ;     jumps to Ltmp93
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp92-Lfunc_begin9            ; >> Call Site 3 <<
	.uleb128 Lfunc_end9-Ltmp92              ;   Call between Ltmp92 and Lfunc_end9
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end9:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt12length_errorC1B9nqe210106EPKc ; -- Begin function _ZNSt12length_errorC1B9nqe210106EPKc
	.globl	__ZNSt12length_errorC1B9nqe210106EPKc
	.weak_def_can_be_hidden	__ZNSt12length_errorC1B9nqe210106EPKc
	.p2align	2
__ZNSt12length_errorC1B9nqe210106EPKc:  ; @_ZNSt12length_errorC1B9nqe210106EPKc
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZNSt11logic_errorC2EPKc
Lloh86:
	adrp	x8, __ZTVSt12length_error@GOTPAGE
Lloh87:
	ldr	x8, [x8, __ZTVSt12length_error@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh86, Lloh87
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZSt28__throw_bad_array_new_lengthB9nqe210106v ; -- Begin function _ZSt28__throw_bad_array_new_lengthB9nqe210106v
	.globl	__ZSt28__throw_bad_array_new_lengthB9nqe210106v
	.weak_def_can_be_hidden	__ZSt28__throw_bad_array_new_lengthB9nqe210106v
	.p2align	2
__ZSt28__throw_bad_array_new_lengthB9nqe210106v: ; @_ZSt28__throw_bad_array_new_lengthB9nqe210106v
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #8                          ; =0x8
	bl	___cxa_allocate_exception
	bl	__ZNSt20bad_array_new_lengthC1Ev
Lloh88:
	adrp	x1, __ZTISt20bad_array_new_length@GOTPAGE
Lloh89:
	ldr	x1, [x1, __ZTISt20bad_array_new_length@GOTPAGEOFF]
Lloh90:
	adrp	x2, __ZNSt20bad_array_new_lengthD1Ev@GOTPAGE
Lloh91:
	ldr	x2, [x2, __ZNSt20bad_array_new_lengthD1Ev@GOTPAGEOFF]
	bl	___cxa_throw
	.loh AdrpLdrGot	Lloh90, Lloh91
	.loh AdrpLdrGot	Lloh88, Lloh89
	.cfi_endproc
                                        ; -- End function
	.globl	__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE25__emplace_unique_key_argsIjJNSA_IjS7_EEEEENSA_INS_15__hash_iteratorIPNS_11__hash_nodeIS8_PvEEEEbEERKT_DpOT0_ ; -- Begin function _ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE25__emplace_unique_key_argsIjJNSA_IjS7_EEEEENSA_INS_15__hash_iteratorIPNS_11__hash_nodeIS8_PvEEEEbEERKT_DpOT0_
	.weak_def_can_be_hidden	__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE25__emplace_unique_key_argsIjJNSA_IjS7_EEEEENSA_INS_15__hash_iteratorIPNS_11__hash_nodeIS8_PvEEEEbEERKT_DpOT0_
	.p2align	2
__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE25__emplace_unique_key_argsIjJNSA_IjS7_EEEEENSA_INS_15__hash_iteratorIPNS_11__hash_nodeIS8_PvEEEEbEERKT_DpOT0_: ; @_ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE25__emplace_unique_key_argsIjJNSA_IjS7_EEEEENSA_INS_15__hash_iteratorIPNS_11__hash_nodeIS8_PvEEEEbEERKT_DpOT0_
Lfunc_begin10:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception10
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x21, x2
	mov	x19, x0
	ldr	w22, [x1]
	ldr	x23, [x0, #8]
	cbz	x23, LBB26_4
; %bb.1:
	sub	x8, x23, #1
	tst	x23, x8
	b.eq	LBB26_5
; %bb.2:
	mov	x25, x22
	cmp	x23, x22
	b.hi	LBB26_6
; %bb.3:
	udiv	w9, w22, w23
	msub	w25, w9, w23, w22
	b	LBB26_6
LBB26_4:
                                        ; implicit-def: $x25
	b	LBB26_8
LBB26_5:
	sub	w9, w23, #1
	and	x25, x9, x22
LBB26_6:
	ldr	x9, [x19]
	ldr	x9, [x9, x25, lsl #3]
	cbz	x9, LBB26_8
; %bb.7:
	ldr	x20, [x9]
	cbnz	x20, LBB26_14
LBB26_8:
	add	x24, x19, #16
	mov	w0, #48                         ; =0x30
	bl	__Znwm
	mov	x20, x0
	stp	x0, x24, [sp, #8]
	mov	w8, #1                          ; =0x1
	str	x8, [sp, #24]
	stp	xzr, x22, [x0]
	ldr	w8, [x21]
	str	w8, [x0, #16]
	ldur	q0, [x21, #8]
	stur	q0, [x0, #24]
	ldr	x8, [x21, #24]
	str	x8, [x0, #40]
	stp	xzr, xzr, [x21, #8]
	str	xzr, [x21, #24]
	ldr	x8, [x19, #24]
	add	x8, x8, #1
	ucvtf	s0, x8
	ldr	s1, [x19, #32]
	cbz	x23, LBB26_10
; %bb.9:
	ucvtf	s2, x23
	fmul	s2, s1, s2
	fcmp	s2, s0
	b.pl	LBB26_37
LBB26_10:
	lsl	x8, x23, #1
	mov	w9, #1                          ; =0x1
	sub	x10, x23, #1
	tst	x23, x10
	cset	w10, ne
	cmp	x23, #3
	csel	x9, x9, x10, lo
	orr	x8, x9, x8
	fdiv	s0, s0, s1
	fcvtpu	x9, s0
	cmp	x8, x9
	csel	x21, x8, x9, hi
	subs	x8, x21, #1
	b.ne	LBB26_20
; %bb.11:
	mov	w21, #2                         ; =0x2
	b	LBB26_23
LBB26_12:                               ;   in Loop: Header=BB26_14 Depth=1
	ldr	w9, [x20, #16]
	cmp	w9, w22
	b.eq	LBB26_29
LBB26_13:                               ;   in Loop: Header=BB26_14 Depth=1
	ldr	x20, [x20]
	cbz	x20, LBB26_8
LBB26_14:                               ; =>This Inner Loop Header: Depth=1
	ldr	x9, [x20, #8]
	cmp	x9, x22
	b.eq	LBB26_12
; %bb.15:                               ;   in Loop: Header=BB26_14 Depth=1
	tst	x23, x8
	b.eq	LBB26_19
; %bb.16:                               ;   in Loop: Header=BB26_14 Depth=1
	cmp	x9, x23
	b.lo	LBB26_18
; %bb.17:                               ;   in Loop: Header=BB26_14 Depth=1
	udiv	x10, x9, x23
	msub	x9, x10, x23, x9
LBB26_18:                               ;   in Loop: Header=BB26_14 Depth=1
	cmp	x9, x25
	b.eq	LBB26_13
	b	LBB26_8
LBB26_19:                               ;   in Loop: Header=BB26_14 Depth=1
	and	x9, x9, x8
	cmp	x9, x25
	b.eq	LBB26_13
	b	LBB26_8
LBB26_20:
	tst	x21, x8
	b.eq	LBB26_23
; %bb.21:
Ltmp94:
	mov	x0, x21
	bl	__ZNSt3__112__next_primeEm
Ltmp95:
; %bb.22:
	mov	x21, x0
LBB26_23:
	ldr	x23, [x19, #8]
	cmp	x21, x23
	b.ls	LBB26_25
LBB26_24:
Ltmp98:
	mov	x0, x19
	mov	x1, x21
	bl	__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE11__do_rehashILb1EEEvm
Ltmp99:
	b	LBB26_32
LBB26_25:
	b.hs	LBB26_32
; %bb.26:
	ldr	x8, [x19, #24]
	ucvtf	s0, x8
	ldr	s1, [x19, #32]
	fdiv	s0, s0, s1
	fcvtpu	x0, s0
	cmp	x23, #3
	b.lo	LBB26_30
; %bb.27:
	sub	x8, x23, #1
	and	x8, x23, x8
	cbnz	x8, LBB26_30
; %bb.28:
	sub	x8, x0, #1
	clz	x8, x8
	neg	x8, x8
	mov	w9, #1                          ; =0x1
	lsl	x8, x9, x8
	cmp	x0, #2
	csel	x0, x0, x8, lo
	b	LBB26_31
LBB26_29:
	mov	x1, #0                          ; =0x0
	b	LBB26_40
LBB26_30:
Ltmp96:
	bl	__ZNSt3__112__next_primeEm
Ltmp97:
LBB26_31:
	cmp	x21, x0
	csel	x21, x21, x0, hi
	cmp	x21, x23
	b.lo	LBB26_24
LBB26_32:
	ldr	x23, [x19, #8]
	sub	x8, x23, #1
	tst	x23, x8
	b.eq	LBB26_35
; %bb.33:
	cmp	x23, x22
	b.ls	LBB26_36
; %bb.34:
	mov	x25, x22
	b	LBB26_37
LBB26_35:
	sub	w8, w23, #1
	and	x25, x8, x22
	b	LBB26_37
LBB26_36:
	udiv	x8, x22, x23
	msub	x25, x8, x23, x22
LBB26_37:
	ldr	x8, [x19]
	ldr	x9, [x8, x25, lsl #3]
	cbz	x9, LBB26_41
; %bb.38:
	ldr	x8, [x9]
	str	x8, [x20]
	str	x20, [x9]
LBB26_39:
	ldr	x8, [x19, #24]
	add	x8, x8, #1
	str	x8, [x19, #24]
	mov	w1, #1                          ; =0x1
LBB26_40:
	mov	x0, x20
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB26_41:
	ldr	x9, [x24]
	str	x9, [x20]
	str	x20, [x24]
	str	x24, [x8, x25, lsl #3]
	ldr	x9, [x20]
	cbz	x9, LBB26_39
; %bb.42:
	ldr	x9, [x9, #8]
	sub	x10, x23, #1
	tst	x23, x10
	b.eq	LBB26_46
; %bb.43:
	cmp	x9, x23
	b.lo	LBB26_45
; %bb.44:
	udiv	x10, x9, x23
	msub	x9, x10, x23, x9
LBB26_45:
	str	x20, [x8, x9, lsl #3]
	b	LBB26_39
LBB26_46:
	and	x9, x9, x10
	str	x20, [x8, x9, lsl #3]
	b	LBB26_39
LBB26_47:
Ltmp100:
	mov	x19, x0
	add	x0, sp, #8
	bl	__ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev
	mov	x0, x19
	bl	__Unwind_Resume
Lfunc_end10:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table26:
Lexception10:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end10-Lcst_begin10
Lcst_begin10:
	.uleb128 Lfunc_begin10-Lfunc_begin10    ; >> Call Site 1 <<
	.uleb128 Ltmp94-Lfunc_begin10           ;   Call between Lfunc_begin10 and Ltmp94
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp94-Lfunc_begin10           ; >> Call Site 2 <<
	.uleb128 Ltmp97-Ltmp94                  ;   Call between Ltmp94 and Ltmp97
	.uleb128 Ltmp100-Lfunc_begin10          ;     jumps to Ltmp100
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp97-Lfunc_begin10           ; >> Call Site 3 <<
	.uleb128 Lfunc_end10-Ltmp97             ;   Call between Ltmp97 and Lfunc_end10
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end10:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev ; -- Begin function _ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev
	.globl	__ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev
	.weak_def_can_be_hidden	__ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev
	.p2align	2
__ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev: ; @_ZNSt3__110unique_ptrINS_11__hash_nodeINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS5_EEEEEEPvEENS_22__hash_node_destructorINS6_ISB_EEEEED1B9nqe210106Ev
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	ldr	x0, [x0]
	str	xzr, [x8]
	cbz	x0, LBB27_5
; %bb.1:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x8
	ldrb	w8, [x8, #16]
	cmp	w8, #1
	b.ne	LBB27_4
; %bb.2:
	ldr	x8, [x0, #24]
	cbz	x8, LBB27_4
; %bb.3:
	str	x8, [x0, #32]
	mov	x20, x0
	mov	x0, x8
	bl	__ZdlPv
	mov	x0, x20
LBB27_4:
	bl	__ZdlPv
	mov	x8, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
LBB27_5:
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE11__do_rehashILb1EEEvm ; -- Begin function _ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE11__do_rehashILb1EEEvm
	.weak_def_can_be_hidden	__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE11__do_rehashILb1EEEvm
	.p2align	2
__ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE11__do_rehashILb1EEEvm: ; @_ZNSt3__112__hash_tableINS_17__hash_value_typeIjNS_6vectorIN7toy_sim11InstructionENS_9allocatorIS4_EEEEEENS_22__unordered_map_hasherIjNS_4pairIKjS7_EENS_4hashIjEENS_8equal_toIjEELb1EEENS_21__unordered_map_equalIjSC_SG_SE_Lb1EEENS5_ISC_EEE11__do_rehashILb1EEEvm
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x21, x0
	cbz	x1, LBB28_8
; %bb.1:
	mov	x19, x1
	lsr	x8, x1, #61
	cbnz	x8, LBB28_24
; %bb.2:
	lsl	x22, x19, #3
	mov	x0, x22
	bl	__Znwm
	mov	x20, x0
	ldr	x0, [x21]
	str	x20, [x21]
	cbz	x0, LBB28_4
; %bb.3:
	bl	__ZdlPv
	ldr	x20, [x21]
LBB28_4:
	str	x19, [x21, #8]
	mov	x0, x20
	mov	x1, x22
	bl	_bzero
	ldr	x9, [x21, #16]!
	cbz	x9, LBB28_13
; %bb.5:
	ldr	x10, [x9, #8]
	sub	x8, x19, #1
	tst	x19, x8
	b.eq	LBB28_11
; %bb.6:
	cmp	x10, x19
	b.lo	LBB28_12
; %bb.7:
	udiv	x11, x10, x19
	msub	x10, x11, x19, x10
	b	LBB28_12
LBB28_8:
	ldr	x0, [x21]
	str	xzr, [x21]
	cbz	x0, LBB28_10
; %bb.9:
	bl	__ZdlPv
LBB28_10:
	str	xzr, [x21, #8]
	b	LBB28_13
LBB28_11:
	and	x10, x10, x8
LBB28_12:
	str	x21, [x20, x10, lsl #3]
	ldr	x11, [x9]
	cbnz	x11, LBB28_17
LBB28_13:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB28_14:                               ;   in Loop: Header=BB28_17 Depth=1
	ldr	x13, [x11]
	str	x13, [x9]
	ldr	x13, [x20, x12, lsl #3]
	ldr	x13, [x13]
	str	x13, [x11]
	ldr	x12, [x20, x12, lsl #3]
	str	x11, [x12]
	mov	x11, x9
LBB28_15:                               ;   in Loop: Header=BB28_17 Depth=1
	mov	x12, x10
LBB28_16:                               ;   in Loop: Header=BB28_17 Depth=1
	mov	x9, x11
	ldr	x11, [x11]
	mov	x10, x12
	cbz	x11, LBB28_13
LBB28_17:                               ; =>This Inner Loop Header: Depth=1
	ldr	x12, [x11, #8]
	tst	x19, x8
	b.eq	LBB28_21
; %bb.18:                               ;   in Loop: Header=BB28_17 Depth=1
	cmp	x12, x19
	b.lo	LBB28_20
; %bb.19:                               ;   in Loop: Header=BB28_17 Depth=1
	udiv	x13, x12, x19
	msub	x12, x13, x19, x12
LBB28_20:                               ;   in Loop: Header=BB28_17 Depth=1
	cmp	x12, x10
	b.eq	LBB28_15
	b	LBB28_22
LBB28_21:                               ;   in Loop: Header=BB28_17 Depth=1
	and	x12, x12, x8
	cmp	x12, x10
	b.eq	LBB28_15
LBB28_22:                               ;   in Loop: Header=BB28_17 Depth=1
	ldr	x13, [x20, x12, lsl #3]
	cbnz	x13, LBB28_14
; %bb.23:                               ;   in Loop: Header=BB28_17 Depth=1
	str	x9, [x20, x12, lsl #3]
	b	LBB28_16
LBB28_24:
	bl	__ZSt28__throw_bad_array_new_lengthB9nqe210106v
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.1
__ZN7toy_sim3Cpu6DecodeEj.cold.1:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.2
__ZN7toy_sim3Cpu6DecodeEj.cold.2:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.3
__ZN7toy_sim3Cpu6DecodeEj.cold.3:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.3
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.4
__ZN7toy_sim3Cpu6DecodeEj.cold.4:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.4
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.5
__ZN7toy_sim3Cpu6DecodeEj.cold.5:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.5
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.6
__ZN7toy_sim3Cpu6DecodeEj.cold.6:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.6
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu6DecodeEj.cold.7
__ZN7toy_sim3Cpu6DecodeEj.cold.7:       ; @_ZN7toy_sim3Cpu6DecodeEj.cold.7
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.1
__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.1: ; @_ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.2
__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.2: ; @_ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_2
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.3
__ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.3: ; @_ZN7toy_sim3Cpu7ExecuteENS_11InstructionE.cold.3
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.1
__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.1: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.2
__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.2: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.1
__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.1: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.2
__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.2: ; @_ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.1
__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.1: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.2
__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.2: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.3
__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.3: ; @_ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE.cold.3
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.1
__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.1: ; @_ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.2
__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.2: ; @_ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_0
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE.cold.1
__ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE.cold.1: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_2
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE.cold.1
__ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE.cold.1: ; @_ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_OUTLINED_FUNCTION_1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function OUTLINED_FUNCTION_0
_OUTLINED_FUNCTION_0:                   ; @OUTLINED_FUNCTION_0 Thunk
	.cfi_startproc
; %bb.0:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	b	___cxa_throw
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function OUTLINED_FUNCTION_1
_OUTLINED_FUNCTION_1:                   ; @OUTLINED_FUNCTION_1 Thunk
	.cfi_startproc
; %bb.0:
	adrp	x0, l___func__._ZN7toy_sim12_GLOBAL__N_116SaturateUnsignedEjm@PAGE
	add	x0, x0, l___func__._ZN7toy_sim12_GLOBAL__N_116SaturateUnsignedEjm@PAGEOFF
	adrp	x1, l_.str.2@PAGE
	add	x1, x1, l_.str.2@PAGEOFF
	adrp	x3, l_.str.7@PAGE
	add	x3, x3, l_.str.7@PAGEOFF
	mov	w2, #89                         ; =0x59
	b	___assert_rtn
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function OUTLINED_FUNCTION_2
_OUTLINED_FUNCTION_2:                   ; @OUTLINED_FUNCTION_2 Thunk
	.cfi_startproc
; %bb.0:
	adrp	x0, l___func__._ZN7toy_sim12_GLOBAL__N_114SaturateSignedEjm@PAGE
	add	x0, x0, l___func__._ZN7toy_sim12_GLOBAL__N_114SaturateSignedEjm@PAGEOFF
	adrp	x1, l_.str.2@PAGE
	add	x1, x1, l_.str.2@PAGEOFF
	adrp	x3, l_.str.9@PAGE
	add	x3, x3, l_.str.9@PAGEOFF
	mov	w2, #78                         ; =0x4e
	b	___assert_rtn
	.cfi_endproc
                                        ; -- End function
	.section	__DATA,__const
	.p2align	3, 0x0                          ; @_ZN7toy_sim12_GLOBAL__N_19kHandlersE
__ZN7toy_sim12_GLOBAL__N_19kHandlersE:
	.quad	__ZN7toy_sim12_GLOBAL__N_114ExecuteUnknownERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_114ExecuteSyscallERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_110ExecuteAddERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_111ExecuteBextERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_110ExecuteNorERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_111ExecuteRbitERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_113ExecuteLdPostERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_111ExecuteAddiERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_110ExecuteBeqERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_111ExecuteSsatERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_19ExecuteLdERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_19ExecuteLiERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_19ExecuteStERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_111ExecuteUsatERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_18ExecuteJERNS_3CpuEPKNS_11InstructionE
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	__ZN7toy_sim12_GLOBAL__N_110ExecuteStpERNS_3CpuEPKNS_11InstructionE

	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Decoder: failed to identify the instruction"

l_.str.1:                               ; @.str.1
	.asciz	"vector"

l_.str.2:                               ; @.str.2
	.asciz	"cpu.cpp"

l_.str.6:                               ; @.str.6
	.asciz	"Segfault"

l_.str.7:                               ; @.str.7
	.asciz	"n <= 32"

l_.str.8:                               ; @.str.8
	.asciz	"Executor: MisalignedAccess"

l___func__._ZN7toy_sim12_GLOBAL__N_114SaturateSignedEjm: ; @__func__._ZN7toy_sim12_GLOBAL__N_114SaturateSignedEjm
	.asciz	"SaturateSigned"

l_.str.9:                               ; @.str.9
	.asciz	"n <= 31"

	.private_extern	__ZTIN7toy_sim16SyscallExceptionE ; @_ZTIN7toy_sim16SyscallExceptionE
	.section	__DATA,__const
	.globl	__ZTIN7toy_sim16SyscallExceptionE
	.weak_definition	__ZTIN7toy_sim16SyscallExceptionE
	.p2align	3, 0x0
__ZTIN7toy_sim16SyscallExceptionE:
	.quad	__ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	__ZTSN7toy_sim16SyscallExceptionE-9223372036854775808

	.private_extern	__ZTSN7toy_sim16SyscallExceptionE ; @_ZTSN7toy_sim16SyscallExceptionE
	.section	__TEXT,__const
	.globl	__ZTSN7toy_sim16SyscallExceptionE
	.weak_definition	__ZTSN7toy_sim16SyscallExceptionE
__ZTSN7toy_sim16SyscallExceptionE:
	.asciz	"N7toy_sim16SyscallExceptionE"

	.section	__TEXT,__cstring,cstring_literals
l___func__._ZN7toy_sim12_GLOBAL__N_116SaturateUnsignedEjm: ; @__func__._ZN7toy_sim12_GLOBAL__N_116SaturateUnsignedEjm
	.asciz	"SaturateUnsigned"

l_.str.10:                              ; @.str.10
	.asciz	"Executor: Unknown Instruction"

.subsections_via_symbols
