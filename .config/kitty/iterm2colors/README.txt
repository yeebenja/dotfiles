if you want to use an iterm2 color:
1. download the .itermcolors file
	EXAMPLE: https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Crayon%20Pony%20Fish.itermcolors
2. run command to convert .itermcolors file to .conf
python3 iterm2kitty.py [.itermcolors file]

3. put output in a .conf file in kitty/kitty-themes/

4. put this line in kitty.conf
	include ./kitty-themes/kittytheme.conf
