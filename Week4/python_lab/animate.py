import os
import math
import re
import lib

## Author: Alexander Molodyh
## Date: 10/21/2017
## Class: CS360
## Assignment: Python_Lab Part 1 and 2

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
        z = -8 * math.cos(t)#z coordinate for the camera
        x = 8 * math.sin(t)# x coordinate for the camera
        x2 = (-2 * math.cos(t)) * -1 #x coordinate for the cylindar above the paper
        z2 = (2 * math.sin(t)) * -1#x coordinate for the cylindar above the paper
        y += .001#y coordinate for the camera
        t += .008;
        v1 = lib.Vector(x=x2, y=.5, z=z2)#cylinder vector for lower section
        v2 = lib.Vector(x=0, y=2, z=0)#cylinder vector for center section

        modded_file = get_replaced_cylinder(create_cylinder(v1, v2), file_content)
        modded_file = mod_file(modded_file, (x, y, z))#file with new coordinates
        out_pov_name = 'data\\%s.pov' % str(file_num)#pov output name
        out_image_name = 'img\\%s.png' % str(file_num)#image output name
        file_num += 1
        #file with changed x, and z coordinates pov file number and image number
        pov_tuple = (modded_file, out_pov_name, out_image_name)

        #contains the pov file content, number, and the image name for every iteration
        radius_list.append(pov_tuple)
    
    return radius_list


#searches for the cylinder, replaces it and then returns a
#new file with the modified areas.
def get_replaced_cylinder(cylinder, pov_file):
    cylinder_reg = r'cylinder {<(\S+, \S+, \S+)>, <(\S+, \S+, \S+)>, (\S+) pigment {(\S+)} finish { (\S+)( )+(\d) } }//to change'
    replaced = re.sub(cylinder_reg, cylinder.build(), pov_file)
    return replaced 


## Creates a cylinder object for pov-ray.
## param v1, v2 must be Vectors from the lib.modifiers module.
def create_cylinder(v1, v2):
    pigment = lib.Pigment('Red')
    finish = lib.Finish('ambient', 2)
    items_list = [pigment, finish]
    cylinder = lib.Cylinder(v1, v2, .15, '', items_list)
    return cylinder


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


#compiles the video from the image names provided in a list
def compile_movie(images):
    images_path = 'mencoder mf://@img/image_names -mf w=800:h=600:fps=35:type=png -ovc lavc \
    -lavcopts vcodec=mpeg4:mbd=2:trell -oac copy -o output.avi '
    os.system(images_path)

#creates and returns a list of image names
def create_image_names_file(image_names_list):
    image_names_file = 'img/image_names'
    imgs_file = open(image_names_file, 'w')
    for img in image_names_list:
        imgs_file.write(img[2] + '\n')
    imgs_file.close()
    return imgs_file


def main():
    pov_file = open_file('base.pov')#read in initial pov file
    #create a list of tuples containing modified pov files 
    #and file names for both pov and image files.
    pov_file_list = create_pov_file_list(pov_file)
    create_pov_files(pov_file_list)#generates all the pov files
    create_images(pov_file_list)#generates all the image files
    img_names = create_image_names_file(pov_file_list)#creates a list of image names
    compile_movie(img_names)#compiles the movie


if __name__ == '__main__':
  main()