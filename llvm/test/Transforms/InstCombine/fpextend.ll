; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define float @test(float %x) nounwind  {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[T34:%.*]] = fadd float [[X:%.*]], 0.000000e+00
; CHECK-NEXT:    ret float [[T34]]
;
  %t1 = fpext float %x to double
  %t3 = fadd double %t1, 0.000000e+00
  %t34 = fptrunc double %t3 to float
  ret float %t34
}

define float @test2(float %x, float %y) nounwind  {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[T56:%.*]] = fmul float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext float %x to double
  %t23 = fpext float %y to double
  %t5 = fmul double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test3(float %x, float %y) nounwind  {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[T56:%.*]] = fdiv float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext float %x to double
  %t23 = fpext float %y to double
  %t5 = fdiv double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test4(float %x) nounwind  {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[T34:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    ret float [[T34]]
;
  %t1 = fpext float %x to double
  %t2 = fsub double -0.000000e+00, %t1
  %t34 = fptrunc double %t2 to float
  ret float %t34
}

define float @test4_unary_fneg(float %x) nounwind  {
; CHECK-LABEL: @test4_unary_fneg(
; CHECK-NEXT:    [[T34:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    ret float [[T34]]
;
  %t1 = fpext float %x to double
  %t2 = fneg double %t1
  %t34 = fptrunc double %t2 to float
  ret float %t34
}

; Test with vector splat constant
define <2 x float> @test5(<2 x float> %x) nounwind  {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[T34:%.*]] = fadd <2 x float> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x float> [[T34]]
;
  %t1 = fpext <2 x float> %x to <2 x double>
  %t3 = fadd <2 x double> %t1, <double 0.000000e+00, double 0.000000e+00>
  %t34 = fptrunc <2 x double> %t3 to <2 x float>
  ret <2 x float> %t34
}

; Test with a non-splat constant
define <2 x float> @test6(<2 x float> %x) nounwind  {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[T34:%.*]] = fadd <2 x float> [[X:%.*]], <float 0.000000e+00, float -0.000000e+00>
; CHECK-NEXT:    ret <2 x float> [[T34]]
;
  %t1 = fpext <2 x float> %x to <2 x double>
  %t3 = fadd <2 x double> %t1, <double 0.000000e+00, double -0.000000e+00>
  %t34 = fptrunc <2 x double> %t3 to <2 x float>
  ret <2 x float> %t34
}

; Test with an undef element
define <2 x float> @test6_undef(<2 x float> %x) nounwind  {
; CHECK-LABEL: @test6_undef(
; CHECK-NEXT:    [[T34:%.*]] = fadd <2 x float> [[X:%.*]], <float 0.000000e+00, float undef>
; CHECK-NEXT:    ret <2 x float> [[T34]]
;
  %t1 = fpext <2 x float> %x to <2 x double>
  %t3 = fadd <2 x double> %t1, <double 0.000000e+00, double undef>
  %t34 = fptrunc <2 x double> %t3 to <2 x float>
  ret <2 x float> %t34
}

define <2 x float> @not_half_shrinkable(<2 x float> %x) {
; CHECK-LABEL: @not_half_shrinkable(
; CHECK-NEXT:    [[R:%.*]] = fadd <2 x float> [[X:%.*]], <float 0.000000e+00, float 2.049000e+03>
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %ext = fpext <2 x float> %x to <2 x double>
  %add = fadd <2 x double> %ext, <double 0.0, double 2049.0>
  %r = fptrunc <2 x double> %add to <2 x float>
  ret <2 x float>  %r
}

define half @test7(float %a) nounwind {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[Z:%.*]] = fptrunc float [[A:%.*]] to half
; CHECK-NEXT:    ret half [[Z]]
;
  %y = fpext float %a to double
  %z = fptrunc double %y to half
  ret half %z
}

define float @test8(half %a) nounwind {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[Z:%.*]] = fpext half [[A:%.*]] to float
; CHECK-NEXT:    ret float [[Z]]
;
  %y = fpext half %a to double
  %z = fptrunc double %y to float
  ret float %z
}

define float @test9(half %x, half %y) nounwind  {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP2:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[T56:%.*]] = fmul float [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext half %x to double
  %t23 = fpext half %y to double
  %t5 = fmul double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test10(half %x, float %y) nounwind  {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[T56:%.*]] = fmul float [[Y:%.*]], [[TMP1]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext half %x to double
  %t23 = fpext float %y to double
  %t5 = fmul double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test11(half %x) nounwind  {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[T34:%.*]] = fadd float [[TMP1]], 0.000000e+00
; CHECK-NEXT:    ret float [[T34]]
;
  %t1 = fpext half %x to double
  %t3 = fadd double %t1, 0.000000e+00
  %t34 = fptrunc double %t3 to float
  ret float %t34
}

define float @test12(float %x, half %y) nounwind  {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[T34:%.*]] = fadd float [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret float [[T34]]
;
  %t1 = fpext float %x to double
  %t2 = fpext half %y to double
  %t3 = fadd double %t1, %t2
  %t34 = fptrunc double %t3 to float
  ret float %t34
}

define float @test13(half %x, float %y) nounwind  {
; CHECK-LABEL: @test13(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[T56:%.*]] = fdiv float [[TMP1]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext half %x to double
  %t23 = fpext float %y to double
  %t5 = fdiv double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test14(float %x, half %y) nounwind  {
; CHECK-LABEL: @test14(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[T56:%.*]] = fdiv float [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext float %x to double
  %t23 = fpext half %y to double
  %t5 = fdiv double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test15(half %x, half %y) nounwind  {
; CHECK-LABEL: @test15(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP2:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[T56:%.*]] = fdiv float [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext half %x to double
  %t23 = fpext half %y to double
  %t5 = fdiv double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test16(half %x, float %y) nounwind  {
; CHECK-LABEL: @test16(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP2:%.*]] = frem float [[TMP1]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %t1 = fpext half %x to double
  %t23 = fpext float %y to double
  %t5 = frem double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test17(float %x, half %y) nounwind  {
; CHECK-LABEL: @test17(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[TMP2:%.*]] = frem float [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %t1 = fpext float %x to double
  %t23 = fpext half %y to double
  %t5 = frem double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

define float @test18(half %x, half %y) nounwind  {
; CHECK-LABEL: @test18(
; CHECK-NEXT:    [[TMP1:%.*]] = frem half [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T56:%.*]] = fpext half [[TMP1]] to float
; CHECK-NEXT:    ret float [[T56]]
;
  %t1 = fpext half %x to double
  %t23 = fpext half %y to double
  %t5 = frem double %t1, %t23
  %t56 = fptrunc double %t5 to float
  ret float %t56
}

; Convert from integer is exact, so convert directly to double.

define double @ItoFtoF_s25_f32_f64(i25 %i) {
; CHECK-LABEL: @ItoFtoF_s25_f32_f64(
; CHECK-NEXT:    [[R:%.*]] = sitofp i25 [[I:%.*]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %x = sitofp i25 %i to float
  %r = fpext float %x to double
  ret double %r
}

; Convert from integer is exact, so convert directly to fp128.

define fp128 @ItoFtoF_u24_f32_f128(i24 %i) {
; CHECK-LABEL: @ItoFtoF_u24_f32_f128(
; CHECK-NEXT:    [[R:%.*]] = uitofp i24 [[I:%.*]] to fp128
; CHECK-NEXT:    ret fp128 [[R]]
;
  %x = uitofp i24 %i to float
  %r = fpext float %x to fp128
  ret fp128 %r
}

; Negative test - intermediate rounding in float type.

define double @ItoFtoF_s26_f32_f64(i26 %i) {
; CHECK-LABEL: @ItoFtoF_s26_f32_f64(
; CHECK-NEXT:    [[X:%.*]] = sitofp i26 [[I:%.*]] to float
; CHECK-NEXT:    [[R:%.*]] = fpext float [[X]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %x = sitofp i26 %i to float
  %r = fpext float %x to double
  ret double %r
}

; Negative test - intermediate rounding in float type.

define double @ItoFtoF_u25_f32_f64(i25 %i) {
; CHECK-LABEL: @ItoFtoF_u25_f32_f64(
; CHECK-NEXT:    [[X:%.*]] = uitofp i25 [[I:%.*]] to float
; CHECK-NEXT:    [[R:%.*]] = fpext float [[X]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %x = uitofp i25 %i to float
  %r = fpext float %x to double
  ret double %r
}

; UB on overflow guarantees that the input is small enough to fit in i32.

define double @FtoItoFtoF_f32_s32_f32_f64(float %f) {
; CHECK-LABEL: @FtoItoFtoF_f32_s32_f32_f64(
; CHECK-NEXT:    [[I:%.*]] = fptosi float [[F:%.*]] to i32
; CHECK-NEXT:    [[R:%.*]] = sitofp i32 [[I]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %i = fptosi float %f to i32
  %x = sitofp i32 %i to float
  %r = fpext float %x to double
  ret double %r
}

declare void @use_i32(i32)
declare void @use_f32(float)

; Extra uses are ok; unsigned is ok.

define double @FtoItoFtoF_f32_u32_f32_f64_extra_uses(float %f) {
; CHECK-LABEL: @FtoItoFtoF_f32_u32_f32_f64_extra_uses(
; CHECK-NEXT:    [[I:%.*]] = fptoui float [[F:%.*]] to i32
; CHECK-NEXT:    call void @use_i32(i32 [[I]])
; CHECK-NEXT:    [[X:%.*]] = uitofp i32 [[I]] to float
; CHECK-NEXT:    call void @use_f32(float [[X]])
; CHECK-NEXT:    [[R:%.*]] = uitofp i32 [[I]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %i = fptoui float %f to i32
  call void @use_i32(i32 %i)
  %x = uitofp i32 %i to float
  call void @use_f32(float %x)
  %r = fpext float %x to double
  ret double %r
}

; Vectors are ok; initial type can be smaller than intermediate type.

define <3 x double> @FtoItoFtoF_v3f16_v3s32_v3f32_v3f64(<3 x half> %f) {
; CHECK-LABEL: @FtoItoFtoF_v3f16_v3s32_v3f32_v3f64(
; CHECK-NEXT:    [[I:%.*]] = fptosi <3 x half> [[F:%.*]] to <3 x i32>
; CHECK-NEXT:    [[R:%.*]] = sitofp <3 x i32> [[I]] to <3 x double>
; CHECK-NEXT:    ret <3 x double> [[R]]
;
  %i = fptosi <3 x half> %f to <3 x i32>
  %x = sitofp <3 x i32> %i to <3 x float>
  %r = fpext <3 x float> %x to <3 x double>
  ret <3 x double> %r
}

; Wider than double is ok.

define fp128 @FtoItoFtoF_f32_s64_f64_f128(float %f) {
; CHECK-LABEL: @FtoItoFtoF_f32_s64_f64_f128(
; CHECK-NEXT:    [[I:%.*]] = fptosi float [[F:%.*]] to i64
; CHECK-NEXT:    [[R:%.*]] = sitofp i64 [[I]] to fp128
; CHECK-NEXT:    ret fp128 [[R]]
;
  %i = fptosi float %f to i64
  %x = sitofp i64 %i to double
  %r = fpext double %x to fp128
  ret fp128 %r
}

; Target-specific type is ok.

define x86_fp80 @FtoItoFtoF_f64_u54_f64_f80(double %f) {
; CHECK-LABEL: @FtoItoFtoF_f64_u54_f64_f80(
; CHECK-NEXT:    [[I:%.*]] = fptoui double [[F:%.*]] to i54
; CHECK-NEXT:    [[R:%.*]] = uitofp i54 [[I]] to x86_fp80
; CHECK-NEXT:    ret x86_fp80 [[R]]
;
  %i = fptoui double %f to i54
  %x = uitofp i54 %i to double
  %r = fpext double %x to x86_fp80
  ret x86_fp80 %r
}

; Weird target-specific type is ok (not possible to extend *from* that type).

define ppc_fp128 @FtoItoFtoF_f64_u54_f64_p128(double %f) {
; CHECK-LABEL: @FtoItoFtoF_f64_u54_f64_p128(
; CHECK-NEXT:    [[I:%.*]] = fptoui double [[F:%.*]] to i54
; CHECK-NEXT:    [[R:%.*]] = uitofp i54 [[I]] to ppc_fp128
; CHECK-NEXT:    ret ppc_fp128 [[R]]
;
  %i = fptoui double %f to i54
  %x = uitofp i54 %i to double
  %r = fpext double %x to ppc_fp128
  ret ppc_fp128 %r
}

; Unsigned to signed is ok because signed int has smaller magnitude.

define double @FtoItoFtoF_f32_us32_f32_f64(float %f) {
; CHECK-LABEL: @FtoItoFtoF_f32_us32_f32_f64(
; CHECK-NEXT:    [[I:%.*]] = fptoui float [[F:%.*]] to i32
; CHECK-NEXT:    [[R:%.*]] = sitofp i32 [[I]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %i = fptoui float %f to i32
  %x = sitofp i32 %i to float
  %r = fpext float %x to double
  ret double %r
}

; Negative test: consider -1.0

define double @FtoItoFtoF_f32_su32_f32_f64(float %f) {
; CHECK-LABEL: @FtoItoFtoF_f32_su32_f32_f64(
; CHECK-NEXT:    [[I:%.*]] = fptosi float [[F:%.*]] to i32
; CHECK-NEXT:    [[X:%.*]] = uitofp i32 [[I]] to float
; CHECK-NEXT:    [[R:%.*]] = fpext float [[X]] to double
; CHECK-NEXT:    ret double [[R]]
;
  %i = fptosi float %f to i32
  %x = uitofp i32 %i to float
  %r = fpext float %x to double
  ret double %r
}

define half @bf16_to_f32_to_f16(bfloat %a) nounwind {
; CHECK-LABEL: @bf16_to_f32_to_f16(
; CHECK-NEXT:    [[Y:%.*]] = fpext bfloat [[A:%.*]] to float
; CHECK-NEXT:    [[Z:%.*]] = fptrunc float [[Y]] to half
; CHECK-NEXT:    ret half [[Z]]
;
  %y = fpext bfloat %a to float
  %z = fptrunc float %y to half
  ret half %z
}

define bfloat @bf16_frem(bfloat %x) {
; CHECK-LABEL: @bf16_frem(
; CHECK-NEXT:    [[TMP1:%.*]] = frem bfloat [[X:%.*]], 0xR40C9
; CHECK-NEXT:    ret bfloat [[TMP1]]
;
  %t1 = fpext bfloat %x to float
  %t2 = frem float %t1, 6.281250e+00
  %t3 = fptrunc float %t2 to bfloat
  ret bfloat %t3
}

define <4 x float> @v4f32_fadd(<4 x float> %a) {
; CHECK-LABEL: @v4f32_fadd(
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <4 x float> [[A:%.*]], splat (float -1.000000e+00)
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %2 = fpext <4 x float> %a to <4 x double>
  %4 = fadd <4 x double> %2, splat (double -1.000000e+00)
  %5 = fptrunc <4 x double> %4 to <4 x float>
  ret <4 x float> %5
}
