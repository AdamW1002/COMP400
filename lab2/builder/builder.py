
import os
from functools import reduce

root_dir  = "/cis547vm/lab2/builder/top"

files = []

# root_dir needs a trailing slash (i.e. /root/dir/) get all the  files
x =  [os.path.join(r,file) for r,d,f in os.walk(root_dir) for file in f]

for filename in x:
     print(filename)
     if ".c" in filename:
        files.append(filename)

#build ll files then compile them into .ll and instrument
for f in files:
        
        if ".c" in f:
            os.system("clang -emit-llvm -S -fno-discard-value-names -c -o "  + f.split(".")[0] +".ll " + f + " -g")
            os.system("opt -load /cis547vm/lab2/build/InstrumentPass.so -Instrument -S "  + f.split(".")[0] + ".ll -o "+ f.split(".")[0] + ".instrumented.ll") 
           

files = list(map(lambda f : (f.split(".")[0]) + ".instrumented.ll", files ))
files_to_compile = reduce(lambda x,y : x + " " + y, files)


os.system("clang " + files_to_compile +  " -lruntime -L/cis547vm/lab2/build -Wl,-rpath,/cis547vm/lab2/build")