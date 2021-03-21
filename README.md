# emusaver

A program to save ff5 files (for now) and give them a uniqueish name, and crank em up to s3, & pull em back down too.

## setup
`install python3-pip` # apt, brew, whatever  
`pip3 install virtualenvwrapper` & then follow these instructions: https://medium.com/@gitudaniel/installing-virtualenvwrapper-for-python3-ad3dfea7c717  
`mkvirtualenv -p python3 emusave` # there's no python involved, I just wanted a nice home for the awscli  
`pip install -r requirements.txt`  
add the aws keys as authorized to my stuff  
put in the bashy path of where your game is/is going to be, and the script will take it from & put it back there.
