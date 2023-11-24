
'''
PUF_out.txt, which contains your analog output matrix, should be in the run directory of this script
'''

with open("./PUF_out.txt",'r') as output_file:
	for line in output_file:
		arr_out = []
		arr = line.split(" ")
		for x in arr:
			fx = float(x)
			if fx > 0.88:
				arr_out.append('1')
			elif fx < 0.22:
				arr_out.append('0')
		print "".join(arr_out)
			