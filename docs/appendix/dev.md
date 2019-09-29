# Book Development


I tried to use Gitbook at first, but it was far too janky with its deploys...


So, I saw a lot of good things about [Docsify](https://docsify.js.org). 


Here are some commands so I don't forget them:
* Install globally ```npm install docsify-cli -g```
* Init ```docsify init ./docs```
* Serve ```docsify serve docs```


## Lazy Scripts
I'm a very lazy person. If I can type 1 word instead of 3 I'm going to make a script for it.

Batch - ```run.bat```
```batch
@ECHO OFF

docsify serve docs

REM listens on http://localhost:3000
```

<br>

Bash - ```run.sh```
```bash
#!/bin/bash

docsify serve docs

# listens on http://localhost:3000
```