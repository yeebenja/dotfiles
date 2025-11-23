#!/usr/bin/env python3
#
# Convert .itermcolors files to kitty terminal color settings.
# Modded from https://gist.github.com/MSylvia/4e90860743f1a4de187d
# Might need to adjust dicts[i][NUMBER].text per your file.

import sys
import xml.etree.ElementTree as ET

def rgb_to_hex(rgb):
	return '#%02x%02x%02x' % rgb


def main():
	if len(sys.argv) < 2:
		print("usage: ./iterm2kitty.py file.itermcolors")
		exit()

	tree = ET.parse(sys.argv[1])
	root = tree.getroot()

	keys = root.findall("./dict/key")
	dicts = root.findall("./dict/dict")
	conversion_table = {
		"Background Color" : "background",
		"Cursor Color" : "cursor",
		"Cursor Text Color" : "cursor_text_color",
		"Foreground Color" : "foreground",
		"Link Color" : "url_color",
		"Selected Text Color" : "selection_foreground",
		"Selection Color" : "selection_background",
		}


	for i in range(len(keys)):
		b = int( float( dicts[i][3].text) * 255.0)
		g = int( float( dicts[i][7].text) * 255.0)
		r = int( float( dicts[i][9].text) * 255.0)
		if keys[i].text.split()[1].isdigit():
			print("color{} {}".format(keys[i].text.split()[1], rgb_to_hex((r,g,b))))
		elif keys[i].text in conversion_table:
			print("{} {}".format(conversion_table[keys[i].text], rgb_to_hex((r,g,b)))) 

if __name__ == '__main__':
	main()
