#Reference - https://careerkarma.com/blog/python-list-files-in-directory/#:~:text=The%20Python%20os.,in%20an%20entire%20file%20tree.
import os

path = '/home/vishalraj/AESD/Project/meta-gui/recipes-gui/gui/files'

print 'Starting to modify recepie...'

files = os.listdir(path)

for f in files:
	print(f)


#Create a new file
new_recepie = 
f = 