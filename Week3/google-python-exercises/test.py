import sys

# Define a main() function that prints a little greeting.
def main():
    raw = r'this\t\n and that'
    print raw

    raw2 = 'this\t and that'
    print raw2
    print "this is a stripped version of raw2 " + raw2.strip()

    cLikeStr = "hello there %s how old are you? %d" % ("Alex", 27)

    print cLikeStr


# This is the standard boilerplate that calls the main() function.
if __name__ == '__main__':
  main()