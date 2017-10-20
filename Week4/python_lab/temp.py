# generate a list that contains the pov modded file, pov output name 
# and image output name.
def create_pov_file_list(file_content):
    t = 0.0
    y = 2.8
    file_num = 0#the image and pov file name indexes
    radius_list = []
    while t < (2 * math.pi):
        z = 8 * math.cos(t)
        x = 8 * math.sin(t)
        y += .01
        t += .01;
        modded_file = mod_file(file_content, (x, y, z))#file with new coordinates
        out_pov_name = 'data\\%s.pov' % str(file_num)#pov output name
        out_image_name = 'img\\%s.png' % str(file_num)#image output name
        file_num += 1
        pov_tuple = (modded_file, out_pov_name, out_image_name)
        radius_list.append(pov_tuple)
    
    return radius_list