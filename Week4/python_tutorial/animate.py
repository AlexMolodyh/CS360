import os





def open_pov_file(filename):
    fin = open(filename)
    sdl = fin.read()
    fin.close
    return sdl



def main():
    povfile = open_pov_file('base.pov')
    print povfile


if __name__ == '__main__':
  main()