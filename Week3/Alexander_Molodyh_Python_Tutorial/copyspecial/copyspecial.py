#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import sys
import re
import os
import shutil
import commands

"""Copy Special exercise
"""


def get_special_paths(directory):
    paths = []
    # check if path exists first
    if os.path.exists(directory):
        # list all the directories and files
        dirs = os.listdir(directory)
        # loop through the directories
        for d in dirs:
            # find the file in the directory
            filematch = re.search(r'__(\w+)__', d)
            if filematch:
                # join the directory and the new file together
                newpath = os.path.join(directory, d)
                # append the new directory to a list
                paths.append(os.path.abspath(newpath))
    return paths


def copy_to(paths, directory):
    # if the directory doesn't exitst, create one.
    if not os.path.exists(directory):
        os.makedirs(directory)
    for curpath in paths:  # loop through all paths
        # get the filename in the current path
        filename = os.path.basename(curpath)
        # get the file we need to copy
        filetocopy = os.path.join(directory, filename)
        shutil.copy(curpath, filetocopy)  # copy file to new directory


def zip_to(paths, zipfile):
    zipcommand = 'zip -j ' + zipfile + ' ' + ' '.join(paths)
    print "Command I'm going to do:" + zipcommand
    (errorstatus, erroroutput) = commands.getstatusoutput(zipcommand)

    if errorstatus:
        sys.stderr.write(erroroutput)
        sys.exit(1)


# Write functions and modify main() to call them


def main():
    # This basic command line argument parsing code is provided.
    # Add code to call your functions below.

    # Make a list of command line arguments, omitting the [0] element
    # which is the script itself.
    args = sys.argv[1:]
    if not args:
        print "usage: [--todir dir][--tozip zipfile] dir [dir ...]"
        sys.exit(1)

    # todir and tozip are either set from command line
    # or left as the empty string.
    # The args array is left just containing the dirs.
    todir = ''
    if args[0] == '--todir':
        todir = args[1]
        del args[0:2]
    
    tozip = ''
    if args[0] == '--tozip':
        tozip = args[1]
        del args[0:2]
    
    if len(args) == 0:
        print "error: must specify one or more dirs"
        sys.exit(1)

    paths = []
    for d in args:
        # gather all paths and put them all in one list
        temppaths = get_special_paths(d)
        paths.extend(temppaths)

    if todir:
        copy_to(paths, todir)
    elif tozip:
        zip_to(paths, tozip)
    else:
        print '\n'.join(paths)

    # +++your code here+++
    # Call your functions


if __name__ == "__main__":
    main()
