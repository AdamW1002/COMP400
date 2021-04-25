import json
import os 

code_and_level = json.loads( open("/cis547vm/lab2/COMP400/bug_urls/code_and_levels.json").read())


for k in code_and_level.keys():
    
    code = code_and_level[k]['body']#get code
    code_file = open("/cis547vm/lab2/builder/z3/build/code.smt2", "w") #code file
    code_file.write(code)
    os.system("rm /cis547vm/lab2/builder/z3/build/instrumentation-log.log") #remove old log and run code
    os.system("cd /cis547vm/lab2/builder/z3/build/; ./a.out code.smt2")
    os.system("cp /cis547vm/lab2/builder/z3/build/instrumentation-log.log instrumentation-log.log") #copy file here
    os.system("c++filt < instrumentation-log.log > filtered.log") #c++ name filtering
    
    log = open("filtered.log")
    contents = log.readlines() #read the filtered file and removed std calls and debug info
    contents = list(filter(lambda x : not "llvm.dbg.declare" in x and not "std::__cxx11" in x, contents))
    result = open(f"z3logs/{k}-cleaned_log.log", "w")
    result.writelines(contents)
  


x = 10