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
  
  *INLR=*ON;
  return;
end-proc;

