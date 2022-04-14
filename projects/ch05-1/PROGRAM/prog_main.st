PROGRAM PLC_PRG
VAR
    b: BOOL; (* Comment *)
END_VAR

    WA_LOG('g_iVar1=%d, g_iVar2=%d, g_bVar=%d, g_fVar1=%f, g_sVar=%s', 
        g_iVar1, g_iVar2, TO_INT(g_bVar), g_fVar1, g_sVar);

    g_fVar1 := g_fVar1 + 0.1;
 
END_PROGRAM
