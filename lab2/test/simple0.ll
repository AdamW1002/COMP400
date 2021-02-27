; ModuleID = 'simple0.c'
source_filename = "simple0.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"foo\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"bar\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @a(i32 %b) #0 !dbg !7 {
entry:
  %b.addr = alloca i32, align 4
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !11, metadata !DIExpression()), !dbg !12
  %0 = load i32, i32* %b.addr, align 4, !dbg !13
  %add = add nsw i32 %0, 2, !dbg !14
  ret i32 %add, !dbg !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @b(i8* %chars) #0 !dbg !16 {
entry:
  %chars.addr = alloca i8*, align 8
  store i8* %chars, i8** %chars.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %chars.addr, metadata !21, metadata !DIExpression()), !dbg !22
  ret i32 1, !dbg !23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !24 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %w = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @a(i32 1), !dbg !27
  %call1 = call i32 @b(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)), !dbg !28
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0)), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %x, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 0, i32* %x, align 4, !dbg !31
  call void @llvm.dbg.declare(metadata i32* %y, metadata !32, metadata !DIExpression()), !dbg !33
  %0 = load i32, i32* %x, align 4, !dbg !34
  store i32 %0, i32* %y, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata i32* %w, metadata !35, metadata !DIExpression()), !dbg !36
  %1 = load i32, i32* %x, align 4, !dbg !37
  %and = and i32 %1, 2, !dbg !38
  store i32 %and, i32* %w, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata i32* %z, metadata !39, metadata !DIExpression()), !dbg !40
  %2 = load i32, i32* %y, align 4, !dbg !41
  %3 = load i32, i32* %x, align 4, !dbg !42
  %div = sdiv i32 %2, %3, !dbg !43
  store i32 %div, i32* %z, align 4, !dbg !40
  ret i32 0, !dbg !44
}

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 11.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "simple0.c", directory: "/home/aweiss13/comp400/lab2/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 11.0.0"}
!7 = distinct !DISubprogram(name: "a", scope: !1, file: !1, line: 4, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "b", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!12 = !DILocation(line: 4, column: 12, scope: !7)
!13 = !DILocation(line: 7, column: 8, scope: !7)
!14 = !DILocation(line: 7, column: 9, scope: !7)
!15 = !DILocation(line: 7, column: 1, scope: !7)
!16 = distinct !DISubprogram(name: "b", scope: !1, file: !1, line: 12, type: !17, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!10, !19}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!21 = !DILocalVariable(name: "chars", arg: 1, scope: !16, file: !1, line: 12, type: !19)
!22 = !DILocation(line: 12, column: 13, scope: !16)
!23 = !DILocation(line: 15, column: 3, scope: !16)
!24 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !25, scopeLine: 18, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!25 = !DISubroutineType(types: !26)
!26 = !{!10}
!27 = !DILocation(line: 20, column: 3, scope: !24)
!28 = !DILocation(line: 21, column: 3, scope: !24)
!29 = !DILocation(line: 22, column: 3, scope: !24)
!30 = !DILocalVariable(name: "x", scope: !24, file: !1, line: 24, type: !10)
!31 = !DILocation(line: 24, column: 7, scope: !24)
!32 = !DILocalVariable(name: "y", scope: !24, file: !1, line: 25, type: !10)
!33 = !DILocation(line: 25, column: 7, scope: !24)
!34 = !DILocation(line: 25, column: 11, scope: !24)
!35 = !DILocalVariable(name: "w", scope: !24, file: !1, line: 26, type: !10)
!36 = !DILocation(line: 26, column: 7, scope: !24)
!37 = !DILocation(line: 26, column: 11, scope: !24)
!38 = !DILocation(line: 26, column: 14, scope: !24)
!39 = !DILocalVariable(name: "z", scope: !24, file: !1, line: 27, type: !10)
!40 = !DILocation(line: 27, column: 7, scope: !24)
!41 = !DILocation(line: 27, column: 11, scope: !24)
!42 = !DILocation(line: 27, column: 15, scope: !24)
!43 = !DILocation(line: 27, column: 13, scope: !24)
!44 = !DILocation(line: 31, column: 3, scope: !24)
