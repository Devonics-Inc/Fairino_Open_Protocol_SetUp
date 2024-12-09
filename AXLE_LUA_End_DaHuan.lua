Rcmd1,Rcmd2,Rcmd3,Rcmd4 = GetGripCmd()
T1 = {0x01,0x06,0x01,0x00,0x00,0x01,0x49,0xF6}
T2 = {0x01,0x06,0x01,0x03,0x01,0xF4,0x78,0x21}
T3 = {0x01,0x06,0x01,0x04,0x00,0x32,0x48,0x22}
T4 = {0x01,0x06,0x01,0x01,0x00,0x1E,0x59,0xFE}
T5 = {0x01,0x03,0x02,0x00,0x00,0x01,0x85,0xB2}
T6 = {0x01,0x03,0x02,0x01,0x00,0x01,0xD4,0x72}
T7 = {0x01,0x03,0x02,0x02,0x00,0x01,0x24,0x72}
if(Rcmd1 == 1) then
    DelayMs(3)
    T1[1] = Rcmd2
    T2[1] = Rcmd2
    T3[1] = Rcmd2
    T4[1] = Rcmd2
    T5[1] = Rcmd2
    T6[1] = Rcmd2
    T7[1] = Rcmd2
    if(Rcmd3 == 0x02) then
    T1[7],T1[8] = CrcValue(T1[1],T1[2],T1[3],T1[4],T1[5],T1[6])
    EndTxGripData(T1[1],T1[2],T1[3],T1[4],T1[5],T1[6],T1[7],T1[8])
    DelayMs(10)
    Rxd1,Rxd2,Rxd3,Rxd4,Rxd5= EndRxGripData()
    GripStateBack(Rxd3)
    end
    if(Rcmd3 == 0x03) then
    X = Rcmd4*10
    T2[5] = (X>>8)
    T2[6] = (X&0x00FF)
    T2[7],T2[8] = CrcValue(T2[1],T2[2],T2[3],T2[4],T2[5],T2[6])
    EndTxGripData(T2[1],T2[2],T2[3],T2[4],T2[5],T2[6],T2[7],T2[8])
    DelayMs(10)
    Rxd1,Rxd2,Rxd3,Rxd4,Rxd5= EndRxGripData()
    GripStateBack(Rxd3)
    end
    if(Rcmd3 == 0x04) then
    T3[5] = 0
    T3[6] = Rcmd4
    T3[7],T3[8] = CrcValue(T3[1],T3[2],T3[3],T3[4],T3[5],T3[6])
    EndTxGripData(T3[1],T3[2],T3[3],T3[4],T3[5],T3[6],T3[7],T3[8])
    DelayMs(10)
    Rxd1,Rxd2,Rxd3,Rxd4,Rxd5= EndRxGripData()
    GripStateBack(Rxd3)
    end
    if(Rcmd3 == 0x05) then
    T4[5] = 0
    T4[6] = Rcmd4
    T4[7],T4[8] = CrcValue(T4[1],T4[2],T4[3],T4[4],T4[5],T4[6])
    EndTxGripData(T4[1],T4[2],T4[3],T4[4],T4[5],T4[6],T4[7],T4[8])
    DelayMs(10)
    Rxd1,Rxd2,Rxd3,Rxd4,Rxd5= EndRxGripData()
    GripStateBack(Rxd3)
    end
    if(Rcmd3 == 0x08) then
    T5[7],T5[8] = CrcValue(T5[1],T5[2],T5[3],T5[4],T5[5],T5[6])
    EndTxGripData(T5[1],T5[2],T5[3],T5[4],T5[5],T5[6],T5[7],T5[8])
    DelayMs(10)
    a,Rxd1,Rxd2,Rxd3,Rxd4,Rxd5 = EndRxGripData()
        if ((a == 8) and (Rxd1 == Rcmd2) and (Rxd2 == 0x03) and (Rxd3 == 0x02)) then
            GripStateBack(Rxd5)
        end
    end
    if (Rcmd3 == 0x07) then
    T6[7],T6[8] = CrcValue(T6[1],T6[2],T6[3],T6[4],T6[5],T6[6])
    EndTxGripData(T6[1],T6[2],T6[3],T6[4],T6[5],T6[6],T6[7],T6[8])
    DelayMs(10)
    a, Rxd1, Rxd2, Rxd3, Rxd4, Rxd5 = EndRxGripData()
        if ((a == 8) and (Rxd1 == Rcmd2) and (Rxd2 == 0x03) and (Rxd3 == 0x02)) then
            GripStateBack(Rxd5)
        end
    end
    if (Rcmd3 == 0x0a) then
    T7[7],T7[8] = CrcValue(T7[1],T7[2],T7[3],T7[4],T7[5],T7[6])
    EndTxGripData(T7[1],T7[2],T7[3],T7[4],T7[5],T7[6],T7[7],T7[8])
    DelayMs(10)
    a, Rxd1, Rxd2, Rxd3, Rxd4, Rxd5 = EndRxGripData()
        if ((a == 8) and (Rxd1 == Rcmd2) and (Rxd2 == 0x03) and (Rxd3 == 0x02)) then
            P = (((Rxd4<<8)+Rxd5)//10)
            GripStateBack(P)
        end
    end
end
