; ModuleID = 'simple11.c'
source_filename = "simple11.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo(i32 %bar) #0 !dbg !7 {
entry:
  %bar.addr = alloca i32, align 4
  store i32 %bar, i32* %bar.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %bar.addr, metadata !11, metadata !DIExpression()), !dbg !12
  %0 = load i32, i32* %bar.addr, align 4, !dbg !13
  %add = add nsw i32 %0, 1, !dbg !14
  ret i32 %add, !dbg !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo2(i32 %bar) #0 !dbg !16 {
entry:
  %bar.addr = alloca i32, align 4
  store i32 %bar, i32* %bar.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %bar.addr, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = load i32, i32* %bar.addr, align 4, !dbg !19
  %call = call i32 @foo(i32 %0), !dbg !20
  %mul = mul nsw i32 2, %call, !dbg !21
  ret i32 %mul, !dbg !22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !23 {
entry:
  %retval = alloca i32, align 4
  %str = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i32 @foo2(i32 0), !dbg !26
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %call), !dbg !27
  call void @llvm.dbg.declare(metadata i8** %str, metadata !28, metadata !DIExpression()), !dbg !31
  store i8* null, i8** %str, align 8, !dbg !31
  %0 = load i8*, i8** %str, align 8, !dbg !32
  %arrayidx = getelementptr inbounds i8, i8* %0, i64 0, !dbg !32
  store i8 97, i8* %arrayidx, align 1, !dbg !33
  %call2 = call i32 (i8*, ...) @printf(i8* null), !dbg !34
  ret i32 0, !dbg !35
}

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 11.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "simple11.c", directory: "/home/aweiss13/comp400/lab2/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 11.0.0"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "bar", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!12 = !DILocation(line: 4, column: 13, scope: !7)
!13 = !DILocation(line: 6, column: 8, scope: !7)
!14 = !DILocation(line: 6, column: 11, scope: !7)
!15 = !DILocation(line: 6, column: 1, scope: !7)
!16 = distinct !DISubprogram(name: "foo2", scope: !1, file: !1, line: 11, type: !8, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DILocalVariable(name: "bar", arg: 1, scope: !16, file: !1, line: 11, type: !10)
!18 = !DILocation(line: 11, column: 14, scope: !16)
!19 = !DILocation(line: 13, column: 14, scope: !16)
!20 = !DILocation(line: 13, column: 10, scope: !16)
!21 = !DILocation(line: 13, column: 9, scope: !16)
!22 = !DILocation(line: 13, column: 1, scope: !16)
!23 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !24, scopeLine: 18, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{!10}
!26 = !DILocation(line: 20, column: 20, scope: !23)
!27 = !DILocation(line: 20, column: 5, scope: !23)
!28 = !DILocalVariable(name: "str", scope: !23, file: !1, line: 21, type: !29)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!31 = !DILocation(line: 21, column: 11, scope: !23)
!32 = !DILocation(line: 22, column: 5, scope: !23)
!33 = !DILocation(line: 22, column: 12, scope: !23)
!34 = !DILocation(line: 23, column: 5, scope: !23)
!35 = !DILocation(line: 25, column: 5, scope: !23)
