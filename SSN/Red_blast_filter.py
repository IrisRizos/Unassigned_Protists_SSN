import fileinput
files=['SSN_noSH_2.tab']
outfile=open("SSN_noSH_2_filtered.tab","w")
iter=fileinput.input(files)
ilin=0
for line in iter:
	ilin+=1
	u=line.split('\t')[0:2]
	us=sorted(u)
        uu=us[0]+'==='+us[1]
	if(ilin==1):
		slist=set([uu])
                outfile.write(line)
	elif(ilin>1):
		if uu not in slist:
			slist.add(uu)
			outfile.write(line)
	if(ilin%10**6==0):
		print('Read lines=',ilin, " no of unique=",len(slist))
print("Read ",ilin," lines.  Found unique ",len(slist))
outfile.close()
fileinput.close()



