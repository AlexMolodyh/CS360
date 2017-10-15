#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import os
import re
import sys
import urllib

"""Logpuzzle exercise
Given an apache logfile, find the puzzle urls and download the images.

Here's what a puzzle url looks like:
10.254.254.28 - - [06/Aug/2007:00:13:48 -0700] "GET /~foo/puzzle-bar-aaab.jpg HTTP/1.0" 302 528 "-" "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6"
"""


def urlsortbykey(url):
    ##we use this pattern to sort by the first four characters
    urlmatch = re.search(r'(-(\w+)\.(\w)+)', url)
    if urlmatch:
        return urlmatch.group(2)
    else:
        return url


def read_urls(filename):
    """Returns a list of the puzzle urls from the given log file,
    extracting the hostname from the filename itself.
    Screens out duplicate urls and returns the urls sorted into
    increasing order."""

    ##get the host server name
    hostname = ''
    hostmatch = re.search(r'_((\S+)+\.(\S)+\.(\S)+)', filename)
    if hostmatch:
        hostname = hostmatch.group(1)

    urls = {}
    ##read in the server log file
    logfile = open(filename, 'r')

    for line in logfile:
        ##match the GET url that contains puzzle and the image right away
        urlmatch = re.search(r'(GET ((\S+)(puzzle/)(\S+)))', line)

        ##if there was a match, then we know that it's the whole path
        ##so we append it to urls dict
        if urlmatch:
            urls['http://' + hostname + urlmatch.group(2)] = 1

    logfile.close()
    ##sort the list and return it
    sortedlist = sorted(urls.keys(), key=urlsortbykey)
    return sortedlist


def download_images(img_urls, dest_dir):
    """Given the urls already in the correct order, downloads
    each image into the given directory.
    Gives the images local filenames img0, img1, and so on.
    Creates an index.html in the directory
    with an img tag to show each local image file.
    Creates the directory if necessary.
    """
    # +++your code here+++


def main():
    args = sys.argv[1:]

    if not args:
        print 'usage: [--todir dir] logfile '
        sys.exit(1)

    todir = ''
    if args[0] == '--todir':
        todir = args[1]
        del args[0:2]

    img_urls = read_urls(args[0])
    for url in img_urls:
        print url

    if todir:
        download_images(img_urls, todir)
    else:
        print '\n'.join(img_urls)


if __name__ == '__main__':
    main()
