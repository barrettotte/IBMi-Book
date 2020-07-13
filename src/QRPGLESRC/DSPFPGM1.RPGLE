**free

ctl-opt main(main);
ctl-opt option(*srcstmt:*noDebugIO:*nounref) dftActGrp(*no);

dcl-f SIMPLEDSPF workstn indDs(dspf) usropn;

dcl-ds dspf qualified;
  exit    ind pos(3);
  refresh ind pos(5);
end-ds;

dcl-pr main extpgm('DSPFPGM1') end-pr;

dcl-proc main;
  monitor;
    open SIMPLEDSPF;
    dspfHandler();
    close SIMPLEDSPF;
  on-error *file;
    dsply ('Error opening display file.');
  endmon;

  *INLR = *on;
  return;
end-proc;


// display file loop
dcl-proc dspfHandler;
  monitor;
    doU (dspf.exit);
      exfmt #MYRCD1;

      if (dspf.exit);
        leave;
      elseif (dspf.refresh);
        resetScreen();
      elseif (#1NAME <> *blanks);
        #1MSG = 'Hello ' + %trim(#1NAME);
      endif;
    enddo;
  on-error;
    #1MSG = 'Unexpected error occurred handling display file';
  endmon;
end-proc;


// Reset fields on screen
dcl-proc resetScreen;
  clear #1MSG;
  clear #1NAME;
end-proc;

