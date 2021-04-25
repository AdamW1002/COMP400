import json

raw_data = json.loads(open("/cis547vm/lab2/COMP400/bug_urls/transformed_data.json").read())


code_and_level = {}


for k in raw_data.keys(): #id and code 
    extracted = raw_data[k]["body"].split("```")
    if(len(extracted) >= 3): #if theres a code section
        datum = {}
        datum["body"] = extracted[1]
        datum["priority"] = raw_data[k]["priority"]
        code_and_level[k] = datum

json.dump(code_and_level, open("bug_urls/code_and_levels.json", "w"))
print()       