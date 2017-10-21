import basic_shape
import modifiers

def main():
    vector1 = modifiers.Vector(2, 3, 4)
    vector2 = modifiers.Vector(0, 0, 0)
    pigment = modifiers.Pigment('Green')
    finish = modifiers.Finish('brilliance', 3)
    finish.finish_items['ambient'] = 2
    finish.finish_items["difuse"] = 3
    finish.finish_items['phong'] = ''
    items_list = [pigment, finish]
    cylinder = basic_shape.Cylinder(vector1, vector2, 1, '', items_list)

    print cylinder.build()



if __name__ == '__main__':
  main()