from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
filename = input("What's the image name? ")
new_w, new_h = map(int, input("What's the new height x width? Like 28 28. ").split(' '))
palette_hex = ['0x6159a0','0x60a7d3','0x925e29','0xd4d8dc','0xd49f68','0x339ada','0xaa9667','0x68c6da','0x2a68a3','0x6497a5','0x63945d','0x375c5d','0xa1a798','0x55292e','0x36256f','0x8ecea9','0x6c4d74','0xa0b0d1','0xa8cad5','0x593492','0x4f3355','0x65c3a1','0x949435','0x3c9377','0xd06e2a','0xdfb99d','0x393a8c','0x706317','0x6666c4','0x368fb6','0x394335','0x1870d0','0x906a69','0x886496','0xf4c59f','0x5d802a','0xc77d47','0xe5833d','0xc9bbca','0xa6a9af','0x79d4b2','0x39bdee','0xa08060','0x53672c','0x4a5632','0x979aa4','0x957858','0x5c7825','0x6f9722','0x9da4a6','0x484a33','0x3cc2ee','0xafb0b7','0x9b836d','0x74c8a8','0x939499','0x78664f','0x658726','0x77a527','0x856a4f','0x70b698','0x468769','0x6ea88c','0x676789','0x737692','0x928b89','0x4f674e','0x43c8ee','0x545973','0x72796b','0x627c2a','0x522a99','0x4b584c','0x6f5946','0x6d5637','0x526373','0x844950','0x50a788','0x6d9579','0x84b42e','0x7a464c','0x70886f','0x5a32a2','0x4b494c','0x363532','0x997d62','0x3a6551','0x4b9878','0x2f2a23','0x43bbe7','0x507554','0x59b795','0x38876d','0x709b83','0x384863','0x633bab','0x69666d','0x525691','0x737355','0x6b4a35','0x34394b','0x7bbab5','0x357a66','0x39434d','0x4b382f','0x6b3743','0x5556b2','0x99815a','0x6b3775','0x845b93','0x462874','0x8485a3','0x517966','0x74868e','0x312955','0x37a8ea','0xabc298','0x2e688e','0xa57b57','0x47486b','0x716633','0x54688a','0x4b86b3','0x4f3967','0x424889','0xa39894','0x38735b','0x855750']
palette_rgb = [hex_to_rgb(color) for color in palette_hex]

pixel_tree = KDTree(palette_rgb)
# im = Image.open("./sprite_originals/" + filename+ ".png") #Can be many different formats.
im = Image.open("./sprite_originals/" + filename+ ".jpg")
im = im.convert("RGBA")
layer = Image.new('RGBA',(new_w, new_h), (0,0,0,0))
layer.paste(im, (0, 0))
im = layer
#im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize
pix = im.load()
pix_freqs = Counter([pix[x, y] for x in range(im.size[0]) for y in range(im.size[1])])
pix_freqs_sorted = sorted(pix_freqs.items(), key=lambda x: x[1])
pix_freqs_sorted.reverse()
print(pix)
outImg = Image.new('RGB', im.size, color='white')
outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
i = 0
for y in range(im.size[1]):
    for x in range(im.size[0]):
        pixel = im.getpixel((x,y))
        print(pixel)
        if(pixel[3] < 200):
            outImg.putpixel((x,y), palette_rgb[0])
            outFile.write("%x\n" %(0))
            print(i)
        else:
            index = pixel_tree.query(pixel[:3])[1]
            outImg.putpixel((x,y), palette_rgb[index])
            outFile.write("%x\n" %(index))
        i += 1
outFile.close()
outImg.save("./sprite_converted/" + filename + ".png" )
