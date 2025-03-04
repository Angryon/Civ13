import os
import shutil
import time

t1 = time.time()

print("Updating git...")
currdir = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(currdir,"paths.txt")) as lines:
	for line in lines:
		if "mdir:" in line:
			mdir = line.replace("\n", "")
			mdir = mdir.replace("mdir:", "")
		if "cdir:" in line:
			cdir = line.replace("\n", "")
			cdir = cdir.replace("cdir:", "")
os.chdir(os.path.join(mdir,"civ13-git"))
os.system("sudo git pull")
os.system("sudo git reset --hard origin/master")

print("Rebuilding binaries...")

os.system("sudo DreamMaker civ13.dme")

os.system("cd")

print("Copying configuration settings...")

os.system("sudo python3 scripts/copyconfigfiles.py")

print("Copying binaries...")

dmb = os.path.join(mdir,'civ13-git/civ13.dmb')
rsc = os.path.join(mdir,'civ13-git/civ13.rsc')

shutil.copyfile(dmb, os.path.join(mdir,cdir,'civ13.dmb'))


shutil.copyfile(rsc, os.path.join(mdir,cdir,'civ13.rsc'))

t2 = time.time() - t1

print("Finished updating all directories in {} seconds".format(t2))
