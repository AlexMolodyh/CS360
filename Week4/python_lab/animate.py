import os
import math
import re
import lib

# inserts content into the designated file. 
# Ex: if we have an element "look_at<%s, 0, %s>" and we insert
# x, z as our parameters, then look_at will become <value of x, 0, value of z>
def mod_file(file_to_mod, file_content):
    modded_file = file_to_mod % file_content
    return modded_file


# generate a list that contains the pov modded file, pov output name 
# and image output name.
def create_pov_file_list(file_content):
    t = 0.0
    y = 2.6
    file_num = 0#the image and pov file name indexes
    radius_list = []
    while t < (2 * math.pi):
        z = -8 * math.cos(t)
        x = 8 * math.sin(t)
        x2 = (-2 * math.cos(t)) * -1
        z2 = (2 * math.sin(t)) * -1
        print 'z2 is: ' + str(z2)
        print 'x2 is: ' + str(x2)
        y += .01
        t += .1;
        modded_file = mod_file(file_content, (x, y, z, x2, z2))#file with new coordinates
        out_pov_name = 'data\\%s.pov' % str(file_num)#pov output name
        out_image_name = 'img\\%s.png' % str(file_num)#image output name
        file_num += 1
        pov_tuple = (modded_file, out_pov_name, out_image_name)
        radius_list.append(pov_tuple)
    
    return radius_list

# generates all of the pov files for every x, y, z iteration
def create_pov_files(pov_file_list):
    for pov in pov_file_list:
        create_pov_file(pov[0], pov[1])

# generates a single pov file
def create_pov_file(file_content, out_file_name):
    file_output = open(out_file_name, 'w')
    file_output.write(file_content)
    file_output.close()
    return file_output


def get_camera():
    camera_match = r"camera\{(\s*?.*?)*?\}"
    location = r"location\s+<\d+.+>"
    look_at = r"look_at\s+<\d+.+>"


# generates all of the images based off all the pov files
def create_images(pov_file_list):
    for pov in pov_file_list:
        create_image(pov[1], pov[2])

# generates a single image file 
def create_image(file_name, output_img_name):
    pov_cmd = "pvengine.exe +I%s +O%s -D -V +A +H600 +W800 /EXIT"
    cmd = pov_cmd % (file_name, output_img_name)
    os.system(cmd)

# opens a file and returns it as a string
def open_file(filename):
    fin = open(filename)
    sdl = fin.read()
    fin.close
    return sdl


def compile_movie(images):
    images_path = 'mencoder mf://@img/image_names -mf w=800:h=600:fps=35:type=png -ovc lavc \
    -lavcopts vcodec=mpeg4:mbd=2:trell -oac copy -o output.avi '
    # images_path = 'mencoder mf://%s -mf w=800:h=600:fps=25:type=png -ovc copy -oac copy -o output.avi' % images
    os.system(images_path)


def create_image_names_file(image_names_list):
    image_names_file = 'img/image_names'
    imgs_file = open(image_names_file, 'w')
    for img in image_names_list:
        imgs_file.write(img[2] + '\n')
    imgs_file.close()
    return imgs_file


def main():
    cylinder_reg = r'cylinder {<(\S+, \S+, \S+)>, <(\S+, \S+, \S+)>, (\S+) pigment {(\S+)} finish { (\S+)( )+(\d) } }//to change'

    pov_file = open_file('base.pov')
    
    # pov_file_list = create_pov_file_list(pov_file)
    # create_pov_files(pov_file_list)
    # create_images(pov_file_list)
    # img_names = create_image_names_file(pov_file_list)
    # compile_movie(img_names)

    #print pov_file[-1:]

    m = re.search(cylinder_reg, pov_file)
    vector1 = lib.Vector(-3, 3, 3)
    vector2 = lib.Vector(0, 0, 0)
    pigment = lib.Pigment('Red')
    finish = lib.Finish('ambient', 2)
    items_list = [pigment, finish]
    cylinder = lib.Cylinder(vector1, vector2, .15, '', items_list)
    if m:
        replaced = re.sub(cylinder_reg, cylinder.build(), pov_file)
        print replaced
        print pov_file

if __name__ == '__main__':
  main()