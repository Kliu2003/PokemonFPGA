filename = input("File name (eg. Ethan_16_palette): ")
palettename = input("Palette name (eg. Palette): ")
f2 = open("./testingthis/" + filename + "_postprocess.txt", 'w')
counter = 0
with open("./testingthis/" + filename + ".txt", 'r') as f:
  s = f.readline()
  while (s != ""):
    f2.write(f"assign {palettename}[{counter}] = 24'h{s[:-1]};\n")
    counter += 1
    s = f.readline()
f2.close()
