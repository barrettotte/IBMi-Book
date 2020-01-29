/* Display job info */
PGM
  DCL VAR(&username) TYPE(*CHAR) LEN(10)
  DCL VAR(&jobname)  TYPE(*CHAR) LEN(10)
  DCL VAR(&jobnum)   TYPE(*CHAR) LEN(6)
  DCL VAR(&jobtype)  TYPE(*CHAR) LEN(1)
  DCL VAR(&sysname)  TYPE(*CHAR) LEN(8)

  /* Job type:  0=batch, 1=interactive */
  RTVJOBA JOB(&jobname) CURUSER(&username) NBR(&jobnum) +
    TYPE(&jobtype)

  RTVNETA SYSNAME(&sysname)

  SNDUSRMSG MSG(&jobnum   *TCAT '/' +
             !! &username *TCAT '/' +
             !! &jobname)

  SNDUSRMSG MSG(&jobtype)
  SNDUSRMSG MSG(&sysname)

ENDPGM
