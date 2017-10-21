import os


class Vector:

    def __init__(self, **kws):
        self.x = kws['x']
        self.y = kws['y']
        self.z = kws['z']
        

    def build(self):
        vector_str = '<' + str(self.x) + ', ' + \
        str(self.y) + ', ' + str(self.z) + '>'
        return vector_str


class Pigment:
    
    def __init__(self, color):
        self.color = color

    def build(self):
        pig_string = 'pigment {' + str(self.color) + '}'
        return pig_string


class Finish:

    def __init__(self, item, value):
        self.finish_items = {}
        self.finish_items[item] = value

    def build(self):
        finish_str = 'finish { '
        for k, v in self.finish_items.items():
            finish_str += str(k) + ' ' + (str(v) if v else '') + ' '
        finish_str += '}'
        return finish_str




