/* Fizzbuzz in CL */

PGM PARM(&inIter)

         /* Variable Declarations */
         DCL VAR(&inIter)  TYPE(*CHAR) LEN(10)
         DCL VAR(&iter)    TYPE(*DEC)  LEN(2 0) VALUE(1)
         DCL VAR(&curIter) TYPE(*DEC)  LEN(2 0) VALUE(1)
         DCL VAR(&uname)   TYPE(*CHAR) LEN(10)
         DCL VAR(&outMsg)  TYPE(*CHAR) LEN(64)

         DCL VAR(&modLft)  TYPE(*DEC)  LEN(2 0)
         DCL VAR(&modRgt)  TYPE(*DEC)  LEN(2 0)
         DCL VAR(&modRes)  TYPE(*DEC)  LEN(2 0)
         DCL VAR(&modTmp)  TYPE(*DEC)  LEN(2 0)
         DCL VAR(&modRem)  TYPE(*DEC)  LEN(2 0)


         /* Convert input char to correct data type */
         CHGVAR VAR(&iter) VALUE(%INT(&inIter))


         /* Fetch username of current user */
         RTVUSRPRF USRPRF(*CURRENT) RTNUSRPRF(&uname)


         /* Output greeting message with username */
         CHGVAR VAR(&outMsg) VALUE('Hello' *BCAT &uname *TCAT 'Ü')
         SNDUSRMSG MSG(&outMsg)


         /* Simple sanity check message (optional) */
         CHGVAR VAR(&outMsg) VALUE('Running Fizzbuzz for' +
            *BCAT %CHAR(&iter) *BCAT 'iteration(s)')
         SNDUSRMSG MSG(&outMsg)


         /* Fizzbuzz loop */
         DOUNTIL (&curIter *GT &iter)
            CHGVAR VAR(&modLft) VALUE(&curIter)
            CALLSUBR SUBR(FZBZ)
            CHGVAR VAR(&curIter) VALUE(&curIter + 1)
         ENDDO
         GOTO END


SUBR     SUBR(PRNT)
         SNDUSRMSG MSG(%CHAR(&curIter) *BCAT '-' *BCAT &outMsg)
ENDSUBR


SUBR     SUBR(FZBZ)
         CHGVAR VAR(&outMsg) VALUE('FIZZBUZZ')
         CHGVAR VAR(&modRgt) VALUE(15)
         CALLSUBR SUBR(MOD)
         IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
         ELSE (CALLSUBR SUBR(BUZZ))
ENDSUBR


SUBR     SUBR(BUZZ)
         CHGVAR VAR(&outMsg) VALUE('BUZZ')
         CHGVAR VAR(&modRgt) VALUE(5)
         CALLSUBR SUBR(MOD)
         IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
         ELSE (CALLSUBR SUBR(FIZZ))
ENDSUBR


SUBR     SUBR(FIZZ)
         CHGVAR VAR(&outMsg) VALUE('FIZZ')
         CHGVAR VAR(&modRgt) VALUE(3)
         CALLSUBR SUBR(MOD)
         IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
         ELSE (SNDUSRMSG MSG(%CHAR(&curIter)))
ENDSUBR


SUBR     SUBR(MOD)
         CHGVAR VAR(&modRes) VALUE(&modLft / &modRgt)
         CHGVAR VAR(&modTmp) VALUE(&modRes * &modRgt)
         CHGVAR VAR(&modRem) VALUE(&modLft - &modTmp)
ENDSUBR


END:

ENDPGM
