/*********************************************************************/
/*                      Fizzbuzz in CL                               */
/*                                                                   */
/*   Call using CMD    FIZZBUZZ(10)                                  */
/*   Call using  CL    CALL CLFIZZBUZZ PARM('10')                    */
/*                                                                   */
/*********************************************************************/

PGM PARM(&inIter)

    /* Variable Declarations */
    DCL VAR(&inIter)  TYPE(*CHAR) LEN(10)
    DCL VAR(&iter)    TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&curIter) TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&uname)   TYPE(*CHAR) LEN(10)
    DCL VAR(&outMsg)  TYPE(*CHAR) LEN(64)

    /* Only used in modulus subroutine */
    DCL VAR(&modLft)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRgt)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRes)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modTmp)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRem)  TYPE(*DEC)  LEN(2 0)

    /* Convert input char to correct data type */
    CHGVAR VAR(&iter) VALUE(%INT(&inIter))
    MONMSG MSGID(CPF0818) EXEC(GOTO BADPARM) /* Failed convert */
    MONMSG MSGID(MCH3601) EXEC(GOTO BADPARM) /* Missing param  */

    /* Fetch username of current user */
    RTVUSRPRF USRPRF(*CURRENT) RTNUSRPRF(&uname)

    /* Output greeting message with username */
    CHGVAR VAR(&outMsg) VALUE('Hello' *BCAT &uname)
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)

    /* Simple sanity check message (optional) */
    CHGVAR VAR(&outMsg) VALUE('Running Fizzbuzz for' +
       *BCAT %CHAR(&iter) *BCAT 'iteration(s)')
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)

    /* Fizzbuzz loop */
    DOUNTIL (&curIter *GT &iter)
      CHGVAR VAR(&modLft) VALUE(&curIter)
      CALLSUBR SUBR(FZBZ)
      CHGVAR VAR(&curIter) VALUE(&curIter + 1)
    ENDDO

    GOTO END


BADPARM: SNDUSRMSG MSG('Bad iteration parameter passed.') +
           MSGTYPE(*INFO)

END:     SNDUSRMSG MSG('Done') MSGTYPE(*INFO)


/*********************************************************************/
/*                        SUBROUTINES                                */
/*********************************************************************/

    SUBR     SUBR(PRNT)
             SNDUSRMSG MSG(%CHAR(&curIter) *BCAT '-' *BCAT &outMsg) +
               MSGTYPE(*INFO)
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


    /* Since CL doesn't have a modulus op, let's make one */
    SUBR     SUBR(MOD)
             CHGVAR VAR(&modRes) VALUE(&modLft / &modRgt)
             CHGVAR VAR(&modTmp) VALUE(&modRes * &modRgt)
             CHGVAR VAR(&modRem) VALUE(&modLft - &modTmp)
    ENDSUBR

ENDPGM
