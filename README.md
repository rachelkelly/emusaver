# emusaver

A program to save ff5 files (for now) and give them a uniqueish name, and crank em up to s3, & pull em back down too.  the use case for this is for more than one person to be sharing the same emulated video game using the emulator Snes9x, but good cloud saving solutions with multiple logins don't really exist in the very homebrew space of emulation, so this is enough to tide us over.

## setup
`install python3-pip` # apt, brew, whatever  
`pip3 install virtualenvwrapper` & then follow these instructions: https://medium.com/@gitudaniel/installing-virtualenvwrapper-for-python3-ad3dfea7c717  
`mkvirtualenv -p python3 emusave` # there's no python involved, I just wanted a nice home for the awscli  
`pip install -r requirements.txt`  
add the aws keys as authorized to my stuff  
put in the bashy path of where your game is/is going to be, and the script will take it from & put it back there.  
note: this means "/mnt/c/Program Files (x86)", not C:\

## usage
as it currently stands you need to have access as granted by me to the aws bucket.  you can see it right there.  you need to have your own aws bucket to send this to, and if you do, you can replace the $bucket var.  you will need to have credentials to this bucket.  you cannot have credentials to mine.

### using the stuff as laid out with no changes
* the aws credentials I give you.  plug them in when you run `aws configure`  
* set a special dir where you want to keep stuff.  if you want to use the same as what I've got in my script, you'll need to `mkdir -p /mnt/c/snesstuff/EMUPROJ`

### adapting this to your own emulation manual cloudsaver
* an aws bucket with locked down permissions.  the permissions part isn't important for the script, it's important for ~*~ life ~*~ so keep it locked up  
* a destination for an entire bundle of a game.  for me I define that bundle to be everything that Snes9x needs to run - the .exe, the config file, and all its myriad directories.  I put my own dir in there because this tool is for me and a friend to play the same game.  your dir would probably be different.  
