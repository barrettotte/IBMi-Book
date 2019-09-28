# Fetching Source Members from the IBMi


After a month or so of learning the IBMi, I realized I wanted to start exporting my code to a GitHub repository.


I will preface this section with saying that there is 100% a better way to include your source members in a repository.
You could make some tooling on the IBMi itself and leverage the IFS in some way (I think).


Instead, I decided to use something I was a little more comfortable with at the time. 
I wrote a simple Python utility for pulling source members from the IBMi through FTP. 
Its definitely not very performant, but I believe its very intuitive for someone new to the IBMi.


One limitation to this utility is that it expects everything to be in a single library.
The script can easily be changed to specify a library for each source physical file if really needed since its JSON configured.


To configure this utility, you include a ```repo.json``` file with member names and source physical file targets. 
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

<br>

The Python script itself is very simple. 
A more detailed explanation can be found here https://dev.to/barrettotte/simple-util-to-pull-code-from-the-ibmi-5hfp

```python
# Quick and very dirty util for fetching a couple files from the IBMi so I can "version control" them.

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

