#Reference - https://careerkarma.com/blog/python-list-files-in-directory/#:~:text=The%20Python%20os.,in%20an%20entire%20file%20tree.
import os

path = '/home/vishalraj/AESD/Project/meta-gui/recipes-gui/gui/files'

print 'Starting to modify recepie...'

files = os.listdir(path)

for f in files:
	print(f)


#Create a new recepie and add content
new_recepie = "/home/vishalraj/AESD/Project/meta-gui/recipes-gui/gui/gui_1.0.bb"
file1 = open(new_recepie, "w")

file1.writelines("SUMMARY = \"QT Example Recipe\"\n")
file1.writelines("LICENSE = \"CLOSED\"\n\n")

file1.writelines("SRC_URI = \"")

for f in files:
	if (files.index(f) == 0): #for first dont keep tab
		string = "file://" + f + " \ \n"
	elif (files.index(f) == (len(files)-1)): #for last entry dont put escape character
		string = "\tfile://" + f + "\"\n\n"
	else:
		string = "\tfile://" + f + " \ \n"
	file1.writelines(string)

last_string = "DEPENDS += \"qtbase\" \n\nRDEPENDS_${PN} += \"qtwayland\" \n\n\
FILES_${PN} += \"${bindir}/SampleProject\" \n\nS = \"${WORKDIR}\" \n\n\
do_install:append () {\n\t install -d ${D}${bindir} \n\t install -m 0755 SampleProject ${D}${bindir}/\n} \
\n\ninherit qmake5"

file1.writelines(last_string)

file1.close()