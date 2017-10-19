import os


def get_camera():
    camera_match = r"camera\{(\s*?.*?)*?\}"
    location = r"location\s+<\d+.+>"
    look_at = r"look_at\s+<\d+.+>"

def launch_pov_engine():
    pov_cmd = "pvengine.exe +I%s +O%s -D -V +A +H600 +W800 /EXIT"
    cmd = pov_cmd % ('base.pov', 'base.png')
    os.system(cmd)


def open_pov_file(filename):
    fin = open(filename)
    sdl = fin.read()
    fin.close
    return sdl



def main():
    povfile = open_pov_file('base.pov')
    print povfile
    # launch_pov_engine()


if __name__ == '__main__':
  main()