import os
import json
import validators

z3_repo = "https://api.github.com/repos/Z3Prover/z3/issues"
cvc4_repo = "https://api.github.com/repos/CVC4/cvc4-projects/issues"


files = ["bug_urls/cvc4urlsSF.txt", "bug_urls/z3urlsSF.txt","bug_urls/cvc4urlsTOM.txt", "bug_urls/z3urlsTOM.txt"]


def get_issue(repo: str, issue: int):
    print(repo + "/" + str(issue))
    return json.loads(
        os.popen("curl -u AdamW1002:5859fcf550cc30bd9e2a93f5de7ba3e3a752d76b \-H \"Accept: application/vnd.github.v3+json\" \ " + repo + "/" + str(issue)).read())


def get_urls_from_file(file_name : str):
 tokens = open(file_name).read().split()
 urls = []
 for i in range(0, len(tokens)):
     if(validators.url(tokens[i])):
        urls.append([tokens[i],  tokens[i+1]])
 return urls


def get_issue_from_url(url ):
    link, _ = url
    issue_number  = os.path.basename(os.path.normpath(link))
    return get_issue(z3_repo if "z3" in link else cvc4_repo, issue_number )





x = list(map(lambda  x : get_urls_from_file(x), files))


y = get_issue_from_url(x[3][0])

print(y)
