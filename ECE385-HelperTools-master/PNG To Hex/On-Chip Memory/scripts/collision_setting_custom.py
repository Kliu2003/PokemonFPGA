import numpy as np

filename = input("File name in testingthis (eg. Violet_Gym_HGSS-collision_2): ")
width = int(input("First dimension (ex. 320): "))
height = int(input("Second dimension (ex. 240): "))
widthchar = int(input("Character width (ex. 19): "))
heightchar = int(input("Character height (ex. 29): "))

fileAsArr = np.zeros((height, width))
ret = np.zeros((height, width, 4)) # 0 - up, 2 - down, 1 - left, 3 - right
with open("./testingthis/" + filename + ".txt", 'r') as f:
  for i in range(height):
    for j in range(width):
      fileAsArr[i][j] = int(f.readline())

def setCollision(arr, x, y):
    topRow = y-1
    bottomRow = y+heightchar
    leftCol = x-1
    rightCol = x+widthchar
    
    if(topRow >= 0):
        for i in range(widthchar):
            if(x+i < width and fileAsArr[topRow][x+i] == 0):
                arr[y][x][0] = 1
    else:
        arr[y][x][0] = 1
    
    if(bottomRow < height):
        for i in range(widthchar):
            if(x+i < width and fileAsArr[bottomRow][x+i] == 0):
                arr[y][x][2] = 1
    else:
        arr[y][x][2] = 1

    if(leftCol >= 0):
        for i in range(heightchar):
            if(y+i < height and fileAsArr[y+i][leftCol] == 0):
                arr[y][x][1] = 1
    else:
        arr[y][x][1] = 1

    if(rightCol < width):
        for i in range(heightchar):
            if(y+i < height and fileAsArr[y+i][rightCol] == 0):
                arr[y][x][3] = 1
    else:
        arr[y][x][3] = 1


for i in range(height):
  for j in range(width):
    setCollision(ret, j, i)

f2 = open("./testingthis/mem__" + filename + ".txt", 'w')
for i in range(height):
  for j in range(width):
    f2.write(f"{int(ret[i][j][0])}{int(ret[i][j][1])}{int(ret[i][j][2])}{int(ret[i][j][3])}\n")
f2.close()
