#!/usr/bin/env python

import os
import git
import json
import re

pwd = os.getcwd()
home = os.getenv("HOME")

def listPathChain(startDir):
    # Return a list of all the paths between the specified 'startDir' and
    # either $HOME or "/", whichever is encountered first.

    result = []

    path = startDir

    while True:
        result.append(path)
        lastSlash = path.rfind("/")
        if -1 == lastSlash:
            return result
        if "/" == path or home == path:
            return result
        path = path[:lastSlash]

pathChain = listPathChain(pwd)  # folders in chain from pwd to root (or home)

def listPathsWithFile(paths, fileName):
    # Return a list of all directories in the specified 'paths' containing the
    # specified 'fileName'.

    result = []

    for path in paths:
        if os.path.exists(path + "/" + fileName):
            result.append(path)

    return result

def listRootsInFile(bdeMetaPath):
    # Return a list of all the roots in the file at the specified 'bdeMetaPath'
    # path.

    content = open(bdeMetaPath, "r")
    meta = json.load(content)
    return meta["roots"]

def listAllRoots():
    # List all roots to sources for the software starting from the current
    # working directory.

    metaFile = ".bdemetarc"

    result = []

    # Don't look at metafile chain unless there is a metafile in the current
    # directory.

    if os.path.exists(metaFile):
        metaPaths = listPathsWithFile(pathChain, metaFile)
        for path in metaPaths:
            roots = listRootsInFile(path + "/" + metaFile)
            result.extend(roots)
    else:
        # Otherwise, try current directory and things listed in ".sources"
        result.append(pwd)
        sourcesFile = ".sources"
        sourcePaths = listPathsWithFile(pathChain, sourcesFile)
        for path in sourcePaths:
            fullPath = path + "/" + sourcesFile
            sources = open(fullPath).read().split("\n")
            # last one will be empty, from trailing newline
            sources = sources[:len(sources) - 1]
            result.extend(sources)

    return result

def listFilesInRepo(result, path):
    # Append, to the specified 'result' array, the files contained in the git
    # repository at the specified 'path'.

    repo = git.cmd.Git(path)
    files = repo.ls_files()
    files = files.split("\n")
    for localPath in files:
        result.append(path + "/" + localPath)

def createPruneRegex():
    # Read all the '.ignorePaths' in the current chain and generate a regex
    # from their contents.

    ignoreFile = ".ignorePaths"
    paths = listPathsWithFile(pathChain, ignoreFile)
    regex = ""
    for path in paths:
        data = open(path + "/" + ignoreFile, "r").read()
        regs = data.replace("\n","|")
        if "|" == regs[len(regs) - 1]:
            regs = regs[:len(regs) - 1]
        if "" == regex:
            regex = regs
        else:
            regex = "|" + regs
    return regex

def pruneList(paths):
    # Return the result of pruning all the paths based on the regular
    # expressions in the '.ignorePaths' files.
    expr = createPruneRegex()
    if "" == expr:
        return paths
    prog = re.compile(expr)
    result = []
    for path in paths:
        if None == prog.search(path):
            result.append(path)
    return result

def listFiles():
    roots = listAllRoots()
    paths = []
    for root in roots:
        listFilesInRepo(paths, root)
    paths = pruneList(paths)
    return paths

pwdPrefix = pwd + "/"

def clean(path):
    if path.startswith(pwdPrefix):
        return path[len(pwdPrefix):]
    elif path.startswith(home):
        return "~" + path[len(home):]
    else:
        return path

def comparePaths(l, r):
    # we want to put paths with absolute dir last, and paths with cwd first
    if l[0] == r[0]:
        return cmp(l, r) # same first char, use normal logic
    if l[0] == "/":
        return 1         # left absolute, right not, left is larger
    if r[0] == "/":
        return -1        # right absolute, left not, left is smaller
    if l[0] == "~":
        return 1         # right must be local, so left is larger
    if r[0] == "~":
        return -1        # left must be local, so smaller
    # both are local
    return cmp(l, r)

files = map(clean, listFiles())
files.sort(cmp=comparePaths)

# Print out all the relevant files, removing the prefix for the current working
# directory before printing.

for path in files:
    if path.startswith(pwdPrefix):
        print path[len(pwdPrefix):]
    elif path.startswith(home):
        print "~" + path[len(home):]
    else:
        print path
