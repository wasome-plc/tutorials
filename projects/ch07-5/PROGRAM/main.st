PROGRAM PLC_PRG
VAR
    V1: INT; (* Comment *)
END_VAR
    s2_fc6_100 := s1_fc3_100;
    V1 := s1_fc3_101[0];
    s2_fc6_101[0] := V1;
    s2_fc6_101[1] := s1_fc3_101[1];
    s2_fc6_101[2] := s1_fc3_101[2];

    s2_fc6_104[0] := s1_fc3_104[0];
    s2_fc6_104[1] := s1_fc3_104[1];

    s2_fc5_130[0] := s1_fc1_130[0];
    s2_fc5_130[1] := s1_fc1_130[1];

END_PROGRAM
