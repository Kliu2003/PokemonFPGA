from PIL import Image

filename = input("Image name? (./sprite_originals/___.png): ")
img = Image.open("./sprite_originals/" + filename + ".png")
numcolors = int(input("How many colors in palette? (ideally powers of 2): "))
# img_converted = img.convert(colors=16)
img_converted = img.convert(mode='P', colors=numcolors)
img_converted.save("./testingthis/" + filename + '_' + str(numcolors) + ".png")

outfile = open("./testingthis/" + filename + '_' + str(numcolors) + '.txt', 'w')
colorfile = open("./testingthis/" + filename + '_' + str(numcolors) + '_palette.txt', 'w')
# for color in img_converted.getcolors():
#   outfile.write(','.join(map(str, color)))
#   outfile.write('\n')

for pix in img_converted.getdata():
  outfile.write('%x' % pix + '\n')

# palette = img_converted.getpalette()
# palette_rgbformat = [','.join(map(str, palette[i:i+3])) for i in range(numcolors)]
# for color in palette_rgbformat:
#   colorfile.write(str(color) + '\n')

palette = img_converted.getpalette()
for i in range(numcolors):
  colorfile.write('%02x%02x%02x' % tuple(palette[3*i:3*i+3]) + '\n')

outfile.close()
