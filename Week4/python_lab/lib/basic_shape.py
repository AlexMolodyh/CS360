import os
import modifiers

class Cylinder:
    cyl_param_list = []
    radius = 0.0
    open = ''
    features_list = []

    def __init__(self, v1, v2, r, opn, f_items):
        self.cyl_param_list.append(v1.build())
        self.cyl_param_list.append(v2.build())
        self.radius = r
        self.open = opn
        self.features_list.extend(f_items)

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