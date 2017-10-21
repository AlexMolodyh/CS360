import os
import modifiers

## Author: Alexander Molodyh
## Date: 10/21/2017
## Class: CS360
## Assignment: Python_Lab Part 1 and 2

## A cylinder object for pov-ray.
## To create a cylinder file you must pass in two vectors
## one for each side of the cylinder, a radius, an open modifier if you want it
## to be an open cylinder, and a list of item modifiers such as pigment, and finish.
class Cylinder:

    def __init__(self, v1, v2, r, opn, f_items):
        self.cyl_param_list = []
        self.cyl_param_list.append(v1.build())
        self.cyl_param_list.append(v2.build())
        self.radius = r
        self.open = opn if opn else ''
        self.features_list = []
        self.features_list.extend(f_items)

    # returns a cylinder string ready to be inserted into the pov file.
    def build(self):
        cylinder_str = 'cylinder {'
        for v in self.cyl_param_list:
            cylinder_str += v + ', '

        cylinder_str += str(self.radius) + ' '
        cylinder_str += self.open if self.open else ''

        for item in self.features_list:
            cylinder_str += item.build() + ' '

        cylinder_str += '}'

        return cylinder_str