## Small Example Programs

Since I'm probably awful at teaching, here is where I leverage the good ole "learn by example" tactic.
Unfortunately, there's not going to be too many interesting programs here.
Later on I will show examples of using RPGLE with files and embedded SQL.



## Fizzbuzz
I always have to include the classic fizzbuzz program as an example.

```php
**free

dcl-s num int(10);

for num = 1 to 25;
  if (%rem(num:3) = 0 and %rem(num:5) = 0);
    dsply ('num - ' + %char(num) + ' FIZZBUZZ');
  elseif (%rem(num:3) = 0);
    dsply ('num - ' + %char(num) + ' FIZZ');
  elseif (%rem(num:5) = 0);
    dsply ('num - ' + %char(num) + ' BUZZ');
  endif;
endfor;

*INLR = *ON;
return;
```


## Program Status Data Structure (PSDS)
This is a short example of how to get data from PSDS. PSDS holds a bunch of cool information about various things that we can access within an RPGLE program.

Read more about **PSDS** [here](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzasd/psdsdt9.htm)

```php
**free

ctl-opt main(main);
ctl-opt option(*srcstmt:*noDebugIO:*nounref) dftActGrp(*no);

dcl-ds pgmDs PSDS qualified;
  date     char(8)  pos(191);
  user     char(10) pos(244);
  jobNum   char(10) pos(254);
  procName *proc;
end-ds;

dcl-pr main extPgm('TESTPSDS') end-pr;

dcl-proc main;
  dsply (pgmDs.date);
  dsply (pgmDs.user);
  dsply (pgmDs.jobNum);
  dsply (pgmDs.procName);

  *INLR = *ON;
  return;
end-proc;
```


## Calling a System API
This short program works just like the CL example in a prior section. To call a system API just setup a prototype, match the parameter types, and invoke it.
In this case, I just do a simple ```DSPJOB OUTPUT(*PRINT)``` which won't really do anything. This is just a simple example of calling **QCMDEXC** (Execute Command API).

More information on **QCMDEXC** [here](https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/apis/qcmdexc.htm).


```php
**free

dcl-pr qcmd extpgm('QCMDEXC');
  cmd    char(3000) const;
  cmdLen packed(15:5) const;
  dbcs   char(3) const options(*nopass);
end-pr;

dcl-s cmd varchar(128);

cmd = 'DSPJOB OUTPUT(*PRINT)';
qcmd(cmd: %len(cmd));

*INLR=*ON;
return;
```


## Calling QUILNGTX (Display Long Text API)
This program shows off calling a system API **QUILNGTX** to make a popup to show text.
**QUILNGTX** is very useful for quickly displaying a long string.

More information on **QUILNGTX** [here](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/apis/quilngtx.htm).

```php
**free

ctl-opt main(main);
ctl-opt option(*srcstmt:*noDebugIO:*nounref) dftActGrp(*no);
ctl-opt datfmt(*iso) timfmt(*iso);

dcl-pr main extPgm('TESTPOPUP') end-pr;

dcl-pr QUILNGTX extPgm('QUILNGTX');
  text      char(6800) const options(*varsize);
  length    int(10)    const;
  msgid     char(7)    const;
  qualmsgf  char(20)   const;
  errorCode char(8)    const;
end-pr;

dcl-ds errorNull;
  bytesProv  int(10) inz(0);
  bytesAvail int(10) inz(0);
end-ds;

dcl-s message varchar(6800);

dcl-proc main;
  message = 'hello world';
  QUILNGTX(message: %len(message): 'POPUP': 'TITLE': errorNull);
end-proc;
```