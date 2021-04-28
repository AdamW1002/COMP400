from github import Github

g = Github("71ea8463fbaa18d9d1931c29212a9390a5cc595c")

repo = g.get_repo("Z3Prover/z3")

contents = repo.get_contents("")
while contents:
    file_content = contents.pop(0)
    if file_content.type == "dir":
      contents.extend(repo.get_contents(file_content.path))
    else:
      print(file_content.decoded_content)