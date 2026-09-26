#!/bin/bash
#level 1 the basics 
#Mission: Create a directory named Arena and then inside it, create three files: warrior.txt, mage.txt, and archer.txt

#create directory named Arena
mkdir -p Arena

#change to the Arena directory
cd Arena

# create the three files
touch warrior.txt mage.txt archer.txt

#list the contents of the Arena directory to verify the files were created
ls -l