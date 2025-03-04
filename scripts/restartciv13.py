# restarts the ACTIVE server only

import os
import psutil
import signal

pids = [pid for pid in os.listdir('/proc') if pid.isdigit()]
currdir = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(currdir,"paths.txt")) as lines:
	for line in lines:
		if "mdir:" in line:
			mdir = line.replace("\n", "")
			mdir = mdir.replace("mdir:", "")
		if "cdir:" in line:
			cdir = line.replace("\n", "")
			cdir = cdir.replace("cdir:", "")
		if "port:" in line:
			port = line.replace("\n", "")
			port = cdir.replace("port:", "")
			
for pid in pids:
	try:
		name = open(os.path.join('/proc', pid, 'cmdline'), 'r').read()
		if "civ13.dmb" in name:
			if not "sudo" in name:

				# main server logic: for some reason I could get a valid string/int for port so we're just using "in"
				# civ13 is the active server; restart civ13
				if port in name:
					process = psutil.Process(int(pid))
					if process is not None:
						os.kill(int(pid), signal.SIGUSR1)
						print("Restarted ACTIVE server on port {}.".format(port))

	except IOError:
		continue
