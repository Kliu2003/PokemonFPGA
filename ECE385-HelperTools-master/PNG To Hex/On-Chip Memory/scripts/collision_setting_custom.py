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
    topRow = y-1
    bottomRow = y+heightchar
    leftCol = x-1
    rightCol = x+widthchar
    
    if(topRow >= 0):
        for i in range(widthchar):
            if(x+i < width and fileAsArr[x+i][topRow] == 0):
                arr[x][y][0] = 1
    else:
        arr[x][y][0] = 1
    
    if(bottomRow < height):
        for i in range(widthchar):
            if(x+i < width and fileAsArr[x+i][bottomRow] == 0):
                arr[x][y][2] = 1
    else:
        arr[x][y][2] = 1

    if(leftCol >= 0):
        for i in range(heightchar):
            if(y+i < height and fileAsArr[leftCol][y+i] == 0):
                arr[x][y][1] = 1
    else:
        arr[x][y][1] = 1

    if(rightCol < width):
        for i in range(heightchar):
            if(y+i < height and fileAsArr[rightCol][y+i] == 0):
                arr[x][y][3] = 1
    else:
        arr[x][y][3] = 1


for i in range(width):
  for j in range(height):
    setCollision(ret, i, j)

f2 = open("./testingthis/mem__" + filename + ".txt", 'w')
for i in range(width):
  for j in range(height):
    f2.write(f"{int(ret[i][j][0])}{int(ret[i][j][1])}{int(ret[i][j][2])}{int(ret[i][j][3])}\n")
f2.close()
