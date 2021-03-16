
import os
from functools import reduce

#testing code

#os.system("clang++ -emit-llvm -S -fno-discard-value-names -c -o "  + f.split(".")[0] +".ll " + f + " -g" + "-I")
#os.system("opt -load /cis547vm/lab2/build/InstrumentPass.so -Instrument -S "  + f.split(".")[0] + ".ll -o "+ f.split(".")[0] + ".instrumented.ll")
#os.system("clang++ " + files_to_compile +  " -lruntime -L/cis547vm/lab2/build -Wl,-rpath,/cis547vm/lab2/build")
#end testing code

# clang++ -emit-llvm -S -fno-discard-value-names -c -o num_occurs.ll ../src/ast/num_occurs.cpp -g -I../src/util -I../src/math/polynomial -I../src -D_MP_INTERNAL

#includes = "-I../src/util -I../src/math/polynomial -I../src "
includes = "-I../src -I../src/ast -I../src/ast/proofs -I../src/ast/pattern -I../src/ast/rewriter -I../src/ast/rewriter/bit_blaster -I../src/ast/substitution -I../src/ast/normal_forms -I../src/ast/euf -I../src/ast/macros -I../src/ast/fpa -I../src/ackermannization -I../src/opt -I../src/sat -I../src/sat/smt -I../src/sat/sat_solver -I../src/sat/tactic -I../src/cmd_context -I../src/cmd_context/extra_cmds -I../src/muz -I../src/muz/bmc -I../src/muz/spacer -I../src/muz/transforms -I../src/muz/dataflow -I../src/muz/base -I../src/muz/rel -I../src/muz/fp -I../src/muz/ddnf -I../src/muz/clp -I../src/muz/tab -I../src/model -I../src/solver -I../src/util -I../src/parsers -I../src/parsers/smt2 -I../src/parsers/util -I../src/qe -I../src/qe/mbp -I../src/test -I../src/test/fuzzing -I../src/test/lp -I../src/smt -I../src/smt/proto_model -I../src/smt/tactic -I../src/smt/params -I../src/shell -I../src/math -I../src/math/hilbert -I../src/math/polynomial -I../src/math/interval -I../src/math/automata -I../src/math/subpaving -I../src/math/subpaving/tactic -I../src/math/simplex -I../src/math/lp -I../src/math/grobner -I../src/math/realclosure -I../src/math/dd -I../src/tactic -I../src/tactic/arith -I../src/tactic/ufbv -I../src/tactic/aig -I../src/tactic/fd_solver -I../src/tactic/sls -I../src/tactic/bv -I../src/tactic/core -I../src/tactic/fpa -I../src/tactic/smtlogics -I../src/tactic/portfolio -I../src/params -I../src/nlsat -I../src/nlsat/tactic -I../src/api -I../src/api/dll -I../src/api/c++ -I../src/api/java -I../src/api/ml -I../src/api/dotnet -I../src/api/dotnet/Properties -I../src/api/python -I../src/api/python/z3 -I../src/api/julia"
flags = "-D_MP_INTERNAL -DNDEBUG -D_EXTERNAL_RELEASE -D_USE_THREAD_LOCAL"

#root_dir  = "/cis547vm/lab2/builder/top"
root_dir = "/cis547vm/lab2/builder/z3/src/"
base_dir = "/cis547vm/lab2/builder/"

files = []

# root_dir needs a trailing slash (i.e. /root/dir/) get all the  files
x =  [os.path.join(r,file) for r,d,f in os.walk(root_dir) for file in f]

for filename in x:
    
     if ".c" in filename:
        files.append(filename)

#build ll files then compile them into .ll and instrument
build_file = open("build_custom.sh", "w")
files = list(filter( lambda x :  not "api/dll" in x , files ))
for f in files:
        
        if ".c" in f:
            #print("compilation runs below")
            #os.system("clang++ -emit-llvm -S -fno-discard-value-names -c -o "  + f.split(".")[0] +".ll " + f + " -g " + includes + flags)
            build_file.write("clang++ -emit-llvm -S -fno-discard-value-names -c -o "  + f.split(".")[0] +".ll " + f + " -g " + includes + flags + "\n")
            #print("instrumentation runs below")
            #os.system("opt -load /cis547vm/lab2/build/InstrumentPass.so -Instrument -S "  + f.split(".")[0] + ".ll -o "+ f.split(".")[0] + ".instrumented.ll") 
            build_file.write("opt -load /cis547vm/lab2/build/InstrumentPass.so -Instrument -S "  + f.split(".")[0] + ".ll -o "+ f.split(".")[0] + ".instrumented.ll" + "\n")
           


build_file.close()
print("runnng buildfile")
#os.system("chmod 777 build_custom.sh;./build_custom.sh")

files = list(map(lambda f : (f.split(".")[0]) + ".instrumented.ll", files ))
files_to_compile = list(filter(lambda x :  ( not "dotnet" in x) and ( not "api/ml"  in x) and ( not "util/z3_version"  in x) and ( not "api/julia" in x) and (not "test/" in x), files))
files_to_compile = reduce(lambda x,y : x + " " + y, files_to_compile)


os.system("clang++ " + files_to_compile +  " -lpthread -lgmp -lruntime -L/cis547vm/lab2/build -Wl,-rpath,/cis547vm/lab2/build")


