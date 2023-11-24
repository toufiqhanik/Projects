
'''
challenges.txt should be in the run directory of this script
'''

cs = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]

with open("./challenges.txt",'r') as challenges:
	for line in challenges:
		for idx in range(0,16):
			if line[idx] == '0':
				cs[idx].append('0')
			else:
				cs[idx].append('1.1')

for i,x in enumerate(cs):
	pwl = ["Vc" + str(i) + " c" + str(i) + " GND PWL(0n " + x[0] + " 5ns " + x[0] + " "]
	time = 5
	for y in x[1:]:
		time_1 = time + 0.1
		time_2 = time + 5
		pwl.append(str(time_1) + "n " + y + " " + str(time_2) + "n " + y)
		pwl.append(" ")
		time = time_2
	pwl = pwl[:-1]
	pwl.append(")")
	print "".join(pwl)
	