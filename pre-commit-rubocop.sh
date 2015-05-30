#!/bin/bash
# Preparing analysis of the repository and commit

# We need to get on the root directory
while [ ! -d "$PWD/features" ]
do
	cd ..
done

cd 'lib'
error=$(ruby convention.rb)

# Delete old tests reports / doc
rm -rf */junit*
rm -rf */screen/*
rm -rf */result*.html
rm -rf tests*.json

# Finally, block commit if errors
if [ "$error" != "" ]
then
	echo "$error"
	echo "---------------------------------"
	echo "To commit anyway, use --no-verify"
	exit 1
fi
