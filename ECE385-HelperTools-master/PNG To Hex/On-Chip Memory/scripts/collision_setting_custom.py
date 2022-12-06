import numpy as np

filename = input("File name in sprite_originals (eg. map_violet-city-medres-collision): ")
width = int(input("First dimension (ex. 320): "))
height = int(input("Second dimension (ex. 240): "))
widthchar = int(input("Character width (ex. 19): "))
heightchar = int(input("Character height (ex. 28): "))

fileAsArr = np.zeros((width, height))
ret = np.zeros((width, height, 4)) # 0 - up, 2 - down, 1 - left, 3 - right
with open("./testingthis/" + filename + ".txt", 'r') as f:
  for i in range(width):
    for j in range(height):
      fileAsArr[i][j] = int(f.readline())

def setCollision(arr, x, y, dir):
  if (x >= 0 and x < width and y >= 0 and y < height):
    arr[x][y][dir] = 1 # 1 means collision is occurring here

for i in range(width):
  for j in range(height):
    if (fileAsArr[i][j] == 0):
      for m in range(widthchar):
        setCollision(ret, i + m, j + 1, 0)
        setCollision(ret, i + m, j + heightchar - 1, 2)
      for n in range(heightchar):
        setCollision(ret, i + 1, j + n, 1)
        setCollision(ret, i + widthchar - 1, j + n, 3)

f2 = open("./testingthis/mem__" + filename + ".txt", 'w')
for i in range(width):
  for j in range(height):
    f2.write(f"{int(ret[i][j][0])}{int(ret[i][j][1])}{int(ret[i][j][2])}{int(ret[i][j][3])}\n")
f2.close()
