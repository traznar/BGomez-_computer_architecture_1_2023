import PIL

from PIL import __version__
PIL.PILLOW_VERSION = __version__
from PIL import Image

print(PIL.PILLOW_VERSION)

def fileReader(path):
    file = open(path, 'r')
    data = file.read()
    file.close()
    return data
def toList(data):
    listedData = []
    temp = ''
    for i in data:
        if i != ' ':
            temp += i
        else:
            listedData.append(int(temp))
            temp = ''
    if(temp[0:1]!='\x00'):
        listedData.append(int(temp))
    else:
        return listedData
    
def toList2(data):
    listedData = []
    temp = ''
    for i in data:
        if i != ' ':
            temp += i
        else:
            listedData.append(int(temp))
            temp = ''
    
    listedData.append(int(temp))
    return listedData
def main():
    path = "/home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/Proyectox86/5.txt"
    path2 = "/home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/Proyectox86/decrypted1.txt"
   
    ecryptedPic = fileReader(path)
    ecryptedPic = toList2(ecryptedPic)

    decryptedPic1 = fileReader(path2)
    decryptedPic1 = toList(decryptedPic1)

    
    print(decryptedPic1)

    pic = Image.new('L', (640, 480))
    pic.putdata(decryptedPic1)
    pic.save("/home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/decryptedPic1.png")
    pic.show()

    
    pic2 = Image.new('L', (640, 960))
    pic2.putdata(ecryptedPic)
    pic2.save("/home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/ecrypted.png")
    pic2.show()

    

main()