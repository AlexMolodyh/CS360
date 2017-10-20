import os


class pov_vector:
    x = 0.0
    y = 0.0
    z = 0.0

    def __init__(self, x, y, z):
        pov_vector.x = x
        pov_vector.y = y
        pov_vector.z = z

    
    def build_vector(self):
        vector_str = '<' + str(pov_vector.x) + ', ' + \
        str(pov_vector.y) + ', ' + str(pov_vector.z) + '>'
        return vector_str



class pov_cylinder:
    cyl_param_list = []
