# Fetching Source Members from IBM i


I will preface this section with saying that there is 100% a better way to include your source members in a repository.
You could make some tooling in IBM i itself and leverage the IFS in some way (I think).


Instead, I decided to use something I was a little more comfortable with at the time. 
I wrote a simple Python utility for pulling source members from IBM i through FTP. 
Its definitely not performant, but I believe its very intuitive for someone new to IBM i.


One limitation to this utility is that it expects everything to be in a single library.
If needed, the script can easily be changed to specify a library 
for each source physical file since its JSON configured and Python is a friendly language.


To configure this utility, you create a ```repo.json``` with member names and source physical file targets.
Here is an example:

```json
{
  "host": "PUB400.COM",
  "user": "OTTEB",
  "library": "OTTEB1",
  "spfs": [
    {
      "name": "QDDSSRC",
      "extension": "PF",
      "members": [
        "TODOITEMS",
        "TODOSTATUS",
        "TODOLABELS"
      ]
    },
    {
      "name": "QDDSSRC",
      "extension": "LF",
      "members": [
        "TODOITLBL1",
        "TODOITSTS1"
      ]
    },
    {
      "name": "QRPGLESRC",
      "extension": "RPGLE",
      "members": [
        "TODOLIST"
      ]
    }
  ],
  "output": "./"
}
```

The fields **host** and **user** are optional. If they are not included, you will be prompted by the script for them.
For the file extensions, I'm sure there's a way that I could set this up automatically. 
But, I figured that I would leave it in a config file for complete configuration.

<br>

The Python script itself is very simple. 
Open connection, read config file, loop over SPFs, fetch from IBM i, write source member text to file, close connection
A more detailed explanation can be found here https://dev.to/barrettotte/simple-util-to-pull-code-from-the-ibmi-5hfp

```python
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
  exit(1)
except Exception as e:
  print("Some other error occurred\n" + str(e))
  exit(1)
finally:
  ftp_client.quit()
```


<br>


This utility outputs a folder structure similar to the IFS.
Each source physical file is a directory.

