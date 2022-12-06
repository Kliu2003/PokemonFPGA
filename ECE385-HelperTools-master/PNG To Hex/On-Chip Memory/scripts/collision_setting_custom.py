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

def setCollision(arr, x, y):
   for i in range(widthchar):
       if(x+i < width and fileAsArr[x+i][y] == 0):
           arr[x][y][0] = 1
       if(y+heightchar < height and x+i < width and fileAsArr[x+i][y+heightchar] == 0):
           arr[x][y][2] = 1
   for i in range(heightchar):
       if(y+i < height and fileAsArr[x][y+i] == 0):
           arr[x][y][1] = 1
       if(x+widthchar < width and y+i < height and fileAsArr[x+widthchar][y+i] == 0):
           arr[x][y][3] = 1


for i in range(width):
  for j in range(height):
    setCollision(ret, i, j)

f2 = open("./testingthis/mem__" + filename + ".txt", 'w')
for i in range(width):
  for j in range(height):
    f2.write(f"{int(ret[i][j][0])}{int(ret[i][j][1])}{int(ret[i][j][2])}{int(ret[i][j][3])}\n")
f2.close()
