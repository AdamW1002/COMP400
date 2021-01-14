import json
import datetime



def transform_data(datum):
    #0 is text, 1 is start date, 2 is end date, 3 is the description
    #let's not transform the text





    start_date = datetime.datetime.strptime(datum['1'],'%Y-%m-%dT%H:%M:%SZ')#get the date

    end_date = None

    try:
       end_date = datetime.datetime.strptime(datum['2'],'%Y-%m-%dT%H:%M:%SZ')

    except TypeError:
       end_date = None

    delta_time: int = 0

    if(end_date != None): #if not yet resolved, say resolved in far future
        delta_time = end_date - start_date
    else:
        delta_time = datetime.timedelta(weeks= 52)


    priority = 0 # 0 is lp, 1 is hp
    #think about dates

    if(datum['3'] == "Won't fix"):
        priority = 0 #Low priority

    elif(datum['3'] == "Fixed"):
       if(delta_time > datetime.timedelta(weeks= 52)):
           priority = 0
       else:
           priority = 1

    return {"body" : datum['0'], "priority" : priority}


f = open("bug_urls/bug_report_data.json")

dicts = json.loads(f.read()) #get all the dicts
#process the json




for x in dicts.keys():
    dicts[x] = json.loads(dicts[x])

for x in dicts.keys():
    dicts[x] = transform_data(dicts[x])






print()