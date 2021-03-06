import operator
import os
import json
import validators
import functools
import requests


z3_repo = "https://api.github.com/repos/Z3Prover/z3/issues"
cvc4_repo = "https://api.github.com/repos/CVC4/CVC4/issues"

files = ["/home/aweiss13/comp400/COMP400/bug_urls/cvc4urlsSF.txt", "/home/aweiss13/comp400/COMP400/bug_urls/z3urlsSF.txt","/home/aweiss13/comp400/COMP400/bug_urls/cvc4urlsTOM.txt", "/home/aweiss13/comp400/COMP400/bug_urls/z3urlsTOM.txt"] #files with links to bug issues
#files = ["bug_urls/z3urlsSF.txt", "bug_urls/z3urlsTOM.txt"]  # cvc4 is weird :(
#files = ["/home/aweiss13/comp400/COMP400/bug_urls/cvc4urlsSF.txt", "/home/aweiss13/comp400/COMP400/bug_urls/cvc4urlsTOM.txt"]

def get_issue(repo: str, issue: int):  # get a single issue from a repo
    return json.loads(requests.get(repo + "/" + str(issue), auth =  requests.auth.HTTPBasicAuth('AdamW1002', '1559610a504b8fa84bc2fd01484518f7a379bd72')).text)
            #os.popen(
            #"curl -u AdamW1002:1559610a504b8fa84bc2fd01484518f7a379bd72 \-H \"Accept: application/vnd.github.v3+json\" \ " + repo + "/" + str(
             #   issue)).read())


def get_urls_from_file(file_name: str):  # get all urls and comments from a file
    tokens = open(file_name).read().split()
    urls = []
    for i in range(0, len(tokens)):
        if (validators.url(tokens[i])):
            urls.append([tokens[i], tokens[i + 1]])
    return urls


def get_issue_from_url(url):  # determine which repo and issue number
    link, descriptor = url
    issue_number = os.path.basename(os.path.normpath(link))
    return [get_issue(z3_repo if "z3" in link else cvc4_repo, issue_number), descriptor]


def extract_data(url):  # get data about an issue
    link, status = url
    issue = get_issue_from_url(url)
    try:
        return [issue[0]["body"], issue[0]["created_at"], issue[0]["closed_at"], status]
    except KeyError:
        return None

def dictify(l):
    dict = {}
    for i in range(0, len(l)):
        dict[i] = l[i]
    return dict


x = list(filter(lambda a: a[1] != "Dup",
                functools.reduce(lambda a, b: a + b, (map(lambda y: get_urls_from_file(y), files[:10])))))

x = list(map(lambda a: extract_data(a), x))
x = list(filter(lambda a : a != None,x))
# x is now a list of lists of characteristics


x = list(map(dictify, x))
# the lists are dicts now

# transform each dict into a nested dict
for i in range(0, len(x)):
    x[i] = {i: json.dumps(x[i])}

x = functools.reduce(lambda a, b: {**a, **b}, x)

f = open("/home/aweiss13/comp400/COMP400/bug_urls/bug_report_data.json", "w")  # clear the file
json.dump(x, f)
f.close()
