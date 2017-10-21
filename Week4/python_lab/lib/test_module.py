import basic_shape
import modifiers


def key_func(**kwargs):
      print kwargs

def main():
      
      key_func(x=2, z=3, y=4)

    # cylinder_match = r'cylinder {<(\S+, \S+, \S+)>, <(\S+, \S+, \S+)>, (\S+) pigment {(\S+)} finish { (\S+)( )+(\d) } }//to change'
    # vector1 = modifiers.Vector(2, 3, -4)
    # vector2 = modifiers.Vector(0, 0, 0)
    # pigment = modifiers.Pigment('Green')
    # finish = modifiers.Finish('brilliance', 3)
    # finish.finish_items['ambient'] = 2
    # finish.finish_items["difuse"] = 3
    # finish.finish_items['phong'] = ''
    # items_list = [pigment, finish]
    # cylinder = basic_shape.Cylinder(vector1, vector2, 1, '', items_list)

    # print cylinder.build()



if __name__ == '__main__':
  main()