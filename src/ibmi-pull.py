# Quick and very dirty util for fetching a couple files from IBM i so I can "version control" them.

import ftplib, json, getpass, os
config = {}

with open("./repo.json", 'r') as f: 
  config = json.load(f)

ftp_client = ftplib.FTP()
host = input("Enter Host: ") if not "host" in config else config["host"]
user = input("Enter User: ") if not "user" in config else config["user"]
password = getpass.getpass("Enter Password: ")

try:
  ftp_client.connect(host, timeout=10000)
  ftp_client.login(user, password)
  lib = config['library']

  for spf in config['spfs']:
    print("Fetching member(s) from {}/{}".format(lib, spf['name']))
    if not os.path.exists('./'+spf['name']): os.makedirs(spf['name'])
    
    for mbr in spf['members']:
      resp = []
      cmd = "RETR {}".format("/QSYS.lib/{}.lib/{}.file/{}.mbr").format(lib, spf['name'], mbr)
      ftp_client.retrlines(cmd, resp.append)
      filepath = spf['name'] + '/' + mbr + '.' + spf['extension']
      
      with open(filepath, 'w+') as f:
        for line in resp: 
          f.write(str(line) + '\n')
      print("  Saved " + filepath)

except ftplib.all_errors as e:
  print("Error occurred with FTP.\n" + str(e))
except Exception as e:
  exit("Some other error occurred\n" + str(e))
finally:
  ftp_client.quit()