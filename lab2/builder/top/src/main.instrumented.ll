; ModuleID = '/cis547vm/lab2/builder/top/src/main.ll'
source_filename = "/cis547vm/lab2/builder/top/src/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@Test = private unnamed_addr constant [11 x i8] c"i32 1 bar \00", align 1
@Test.1 = private unnamed_addr constant [4 x i8] c"bar\00", align 1
@Test.2 = private unnamed_addr constant [82 x i8] c"i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0) call printf \00", align 1
@Test.3 = private unnamed_addr constant [7 x i8] c"printf\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @__log_function__(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @Test.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @Test, i32 0, i32 0))
  %call = call i32 @bar(i32 1), !dbg !12
  call void @__log_function__(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @Test.3, i32 0, i32 0), i8* getelementptr inbounds ([82 x i8], [82 x i8]* @Test.2, i32 0, i32 0))
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %call), !dbg !13
  ret i32 0, !dbg !14
}

declare dso_local i32 @printf(i8*, ...) #1

declare dso_local i32 @bar(i32) #1

declare void @__log_function__(i8*, i8*)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.1- (branches/release_80)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "/cis547vm/lab2/builder/top/src/main.c", directory: "/cis547vm/lab2/builder")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.1- (branches/release_80)"}
!7 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 4, type: !9, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "top/src/main.c", directory: "/cis547vm/lab2/builder")
!9 = !DISubroutineType(types: !10)
!10 = !{!11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocation(line: 7, column: 16, scope: !7)
!13 = !DILocation(line: 7, column: 1, scope: !7)
!14 = !DILocation(line: 8, column: 1, scope: !7)
