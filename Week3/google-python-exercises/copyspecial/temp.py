import sys
import re
import os
import shutil
import commands


def get_special_paths(dirname):
    """Given a dirname, returns a list of all its special files."""
    result = []
    paths = os.listdir(dirname)  # list of paths in that dir
    for fname in paths:
        match = re.search(r'__(\w+)__', fname)
        if match:
            result.append(os.path.abspath(os.path.join(dirname, fname)))
    return result


def main():
    print get_special_paths(sys.argv[2])


if __name__ == "__main__":
    main()
