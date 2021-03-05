; ModuleID = '/cis547vm/lab2/builder/top/src/foo.ll'
source_filename = "/cis547vm/lab2/builder/top/src/foo.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@Test = private unnamed_addr constant [78 x i8] c"metadata i32* %a.addr metadata !12 metadata !DIExpression() llvm.dbg.declare \00", align 1
@Test.1 = private unnamed_addr constant [17 x i8] c"llvm.dbg.declare\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %a) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @__log_function__(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @Test.1, i32 0, i32 0), i8* getelementptr inbounds ([78 x i8], [78 x i8]* @Test, i32 0, i32 0))
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !12, metadata !DIExpression()), !dbg !13
  %0 = load i32, i32* %a.addr, align 4, !dbg !14
  %add = add nsw i32 %0, 1, !dbg !15
  ret i32 %add, !dbg !16
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__log_function__(i8*, i8*)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.1- (branches/release_80)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "/cis547vm/lab2/builder/top/src/foo.c", directory: "/cis547vm/lab2/builder")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.1- (branches/release_80)"}
!7 = distinct !DISubprogram(name: "bar", scope: !8, file: !8, line: 1, type: !9, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "top/src/foo.c", directory: "/cis547vm/lab2/builder")
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !8, line: 1, type: !11)
!13 = !DILocation(line: 1, column: 13, scope: !7)
!14 = !DILocation(line: 4, column: 8, scope: !7)
!15 = !DILocation(line: 4, column: 9, scope: !7)
!16 = !DILocation(line: 4, column: 1, scope: !7)
