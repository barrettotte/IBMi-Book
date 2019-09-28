/* Prompt for user input and echo it back as a message */
PGM

  DCL VAR(&in) TYPE(*CHAR) LEN(64)

  SNDUSRMSG MSG('Input Something') +
     MSGTYPE(*INQ) MSGRPY(&in)

  SNDUSRMSG MSG(&in)

ENDPGM
