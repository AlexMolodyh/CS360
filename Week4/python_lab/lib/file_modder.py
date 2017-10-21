import os
import sys


class StringParser:

    def findIt(filename):
        file_lines = open(filename, 'r').readline()
        for l in file_lines:
            for c in l:
                
