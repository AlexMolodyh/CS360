#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import sys
import re

"""Baby Names exercise

Define the extract_names() function below and change main()
to call it.

For writing regex, it's nice to include a copy of the target
text for inspiration.

Here's what the html looks like in the baby.html files:
...
<h3 align="center">Popularity in 1990</h3>
....
<tr align="right"><td>1</td><td>Michael</td><td>Jessica</td>
<tr align="right"><td>2</td><td>Christopher</td><td>Ashley</td>
<tr align="right"><td>3</td><td>Matthew</td><td>Brittany</td>
...

Suggested milestones for incremental development:
 -Extract the year and print it
 -Extract the names and rank numbers and just print them
 -Get the names data into a dict and print it
 -Build the [year, 'name rank', ... ] list and print it
 -Fix main() to use the extract_names list
"""


def extract_names(filename):
    """
    Given a file name for baby.html, returns a list starting with the year string
    followed by the name-rank strings in alphabetical order.
    ['2006', 'Aaliyah 91', Aaron 57', 'Abagail 895', ' ...]
    """
    ##regular expressions for year and a line of text that includes rank, boy name, and girl name
    year = r'(Popularity in )([0-9]{4})'
    listreg = r'([0-9]{1,5})\S{9}([a-zA-Z]{1,24})\S{9}([a-zA-Z]{1,24})'
    popularnames = []##we're goint to store all names here

    ##open file and store all content into a words then close the file
    tmpfile = open(filename, 'r')
    words = tmpfile.read()
    tmpfile.close()

    ##if year is a match then store the year into the first index of popularnames list
    yearmatch = re.search(year, words)
    if yearmatch:
          popularnames.append(yearmatch.group(2))
    else:
          print "Couldn't find the year. Goodbye"
          sys.exit()

    ##reads every line that contains the rank, boy, and girl names
    ##which are separated into 3 groups
    rawlist = re.findall(listreg, words)

    dict = {}

    ##go through every line and assign rank, boy, and girl names into 
    ##their respective variables that are contained in (rank, boy, girl)
    for line in rawlist:
          (rank, boy, girl) = line
          if not boy in dict:
                dict[boy] = rank
          if not girl in dict:
                dict[girl] = rank

    ##make a sorted list by name
    sortednames = sorted(dict.keys())

    ##append the names to popular list in sorted order
    for name in sortednames:
          popularnames.append(name + ' ' + dict[name])

    return popularnames


def main():
    # This command-line parsing code is provided.
    # Make a list of command line arguments, omitting the [0] element
    # which is the script itself.
    args = sys.argv[1:]

    if not args:
        print 'usage: [--summaryfile] file [file ...]'
        sys.exit(1)

    # Notice the summary flag and remove it from args if it is present.
    summary = False
    if args[0] == '--summaryfile':
        summary = True
        del args[0]


    for fname in args:
          names = extract_names(fname)

          textforfile = '\n'.join(names)

          if summary:
                outputfile = open(fname, 'w')
                outputfile.write(textforfile + '\n')
                outputfile.close()
          else:
                print textforfile
    # For each filename, get the names, then either print the text output
    # or write it to a summary file


if __name__ == '__main__':
    main()
