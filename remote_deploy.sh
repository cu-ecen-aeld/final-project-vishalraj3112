#!/bin/bash

gui_app_path='/home/vishalraj/AESD/Project/build/tmp/work/raspberrypi3-poky-linux-gnueabi/core-image-sato/1.0-r0/rootfs/usr/bin/SampleProject'

#Todo: Copy files from host QT folder to recepie folder
dest_recepie_path='/home/vishalraj/AESD/Project/meta-gui/recipes-gui/gui/files'
source_file_path='/home/vishalraj/Qt_Projects/Qt-Files/SampleProject/*'

echo "Copying all gui files now..."
rm ${dest_recepie_path}/*
cp ${source_file_path} ${dest_recepie_path} 
ret_val=$?

if [ $ret_val -ne 0 ]; then
	echo "ERROR:Copying failed, check source and destination path."
	exit $ret_val
else
	echo "Copying succedded."
fi

echo "Starting 'SampleProject.pro' file processing"
#File processing on SampleProject.pro
ogi_file='/home/vishalraj/AESD/Project/meta-gui/recipes-gui/gui/files/SampleProject.pro'
dupli_file='/home/vishalraj/AESD/Project/meta-gui/recipes-gui/gui/files/SampleProject_new.pro'

sed '/# Default/d' ${ogi_file} > ${dupli_file}
cat ${dupli_file} > ${ogi_file}
 sed '/qnx:/d' ${ogi_file} > ${dupli_file}
  cat ${dupli_file} > ${ogi_file}
   sed '/else/d' ${ogi_file} > ${dupli_file}
    cat ${dupli_file} > ${ogi_file}
     sed '/!isEmpty/d' ${ogi_file} > ${dupli_file}
      cat ${dupli_file} > ${ogi_file}

rm -f ${dupli_file}

#Todo: Modify GUI recipie
python recepie_modify.py

#Todo: Read the ip address from user


#Todo: run build.sh, check exit and scp
echo "#################### Starting Build #######################"
./build.sh 
ret_val=$?

if [ $ret_val -ne 0 ]; then
	echo "ERROR:build.sh failed!"
	exit $ret_val
else
	echo "Build succedded, now sending GUI application on target!"
fi

echo "################## Starting Remote Deploy #####################"

scp ${gui_app_path} root@10.0.0.120:/usr/bin
ret_val=$?

if [ $ret_val -ne 0 ]; then
	echo "ERROR:scp failed! Check source path and target ip address."
	exit $ret_val
else
	echo "GUI application deployed! Now run the application on target."
fi
