## RV64G(IMAFD, Zicsr, Zifencei)
1. [ ] RV64 I
   1. [ ] ALUR; Op=0110011, func7[0]=0
      1. [ ] ADD, SUB; func3=000
         1. [ ] addw; func7[1]=0
         2. [ ] subw; func7[1]=1
      2. [ ] xor; func3=100
      3. [ ] or; func3=110
      4. [ ] and; func3=111
      5. [ ] Shift Logical or Arith; func3=101
         1. [ ] srl; func7[1]=0
         2. [ ] sra; func7[1]=1
      6. [ ] slt, Set Less Than; func3=010
      7. [ ] sltu, Set Less Than (U); func3=011
   2. [ ] ALUI; Op=0010011, func7[0]=0
      1. [ ] ADD, SUB; func3=000
         1. [ ] addiw; func7[1]=0
         2. [ ] subiw; func7[1]=1
      2. [ ] xori; func3=100
      3. [ ] ori; func3=110
      4. [ ] andi; func3=111
      5. [ ] Shift Logical or Arith; func3=101
         1. [ ] srl; func7[1]=0
         2. [ ] sra; func7[1]=1
      6. [ ] Set Less Than; func3=010
      7. [ ] Set Less Than (U); func3=011
   3. [ ] Load; Op=0000011
      1. [ ] lb, Load Byte; func3=000
      2. [ ] lh, Load Half; func3=001
      3. [ ] lw, Load Word; func3=010
      4. [ ] ld, Load Double Word; func3=011
      5. [ ] lbu, Load Byte (U); func3=100
      6. [ ] lhu, Load Half (U); func3=101
      7. [ ] lwu, Load Word (U); func3=110
   4. [ ] Store; Op=0100011
      1. [ ] sb, Store Byte; func3=000
      2. [ ] sh, Store Half; func3=001
      3. [ ] sw Store Word; func3=010
      4. [ ] sd Store Word; func3=100
   5. [ ] Branch; Op=1100011
      1. [ ] beq; func3=000
      2. [ ] bne; func3=001
      3. [ ] blt; func3=100
      4. [ ] bge; func3=101
      5. [ ] bltu; func3=110
      6. [ ] begu; func3=111
   6. [ ] Jump And Link; Op=1101111, 
   7. [ ] Jump And Link; Reg Op=1100111
   8. [ ] Load Upper Imm; Op=0110111
   9.  [ ] Add Upper Imm to PC; Op=0010111
   10. [ ] Environment Op=1110011
       1.  [ ] Environment Call, Transfer control to OS
       2.  [ ] Environment Break, Transfer control to debugger
2. [ ] RV32 M Op=0110011, func7[0]=1
   1. [ ] mul; func3=000
   2. [ ] mulh, MUL High; func3=001
   3. [ ] mulhsu, MUL High (S) (U); func3=010
   4. [ ] mulhu, MUL High (U); func3=011
   5. [ ] div; func3=100
   6. [ ] divu, DIV (U); func3=101
   7. [ ] rem, Remainder; func3=110
   8. [ ] remu, Remainder (U); func3=111
3. [ ] RV64 M Op=0110011, func7[0]=1
   1. [ ] mul; func3=000
   2. [ ] mulh, MUL High; func3=001
   3. [ ] mulhsu, MUL High (S) (U); func3=010
   4. [ ] mulhu, MUL High (U); func3=011
   5. [ ] div; func3=100
   6. [ ] divu, DIV (U); func3=101
   7. [ ] rem, Remainder; func3=110
   8. [ ] remu, Remainder (U); func3=111
4. [ ] RV32 A Op=0101111, func3=010
   1. [ ] amoadd.w, Atomic ADD; func5=00000
   2. [ ] amoswap.w, Atomic Swap; func5=00001
   3. [ ] lr.w, Load Reserved; func5=00010
   4. [ ] c.w, Store Conditional; func5=00011
   5. [ ] amoxor.w, Atomix XOR; func5=00100
   6. [ ] amoor.w, Atomic OR; func5=01000
   7. [ ] amoand.w, Atomic AND; func5=01100
   8. [ ] amomin.w, Atomic MIN; func5=10000
   9. [ ] amomax.w, Atomic MAX; func5=10100
   10. [ ] amominu.w, Atomic MIN (U); func5=11000
   11. [ ] amomax.w, Atomic MAX (U); func5=11100
5.  [ ] RV64 A Op=0101111, func3=011
   1. [ ] amoadd.d, Atomic ADD; func5=00000
   2. [ ] amoswap.d, Atomic Swap; func5=00001
   3. [ ] lr.d, Load Reserved; func5=00010
   4. [ ] c.d, Store Conditional; func5=00011
   5. [ ] amoxor.d, Atomix XOR; func5=00100
   6. [ ] amoor.d, Atomic OR; func5=01000
   7. [ ] amoand.d, Atomic AND; func5=01100
   8. [ ] amomin.d, Atomic MIN; func5=10000
   9. [ ] amomax.d, Atomic MAX; func5=10100
   10. [ ] amominu.d, Atomic MIN (U); func5=11000
   11. [ ] amomax.d, Atomic MAX (U); func5=11100
6. [ ] RV32 F/D
7. [ ] RV64 Zicsr Op=1110011
   1. [ ] csrrw; func3=001
   2. [ ] csrrs; func3=010
   3. [ ] csrrc; func3=011
   4. [ ] csrewi; func3=101
   5. [ ] csresi; func3=110
   6. [ ] csrrci; func3=111
8. [ ] RV64 Zifencei
   1. [ ] fence
   2. [ ] fence.i
   3. [ ] fence.tso
9. [ ] pause Op=0001111
10. [ ] Environment Call or Break Op=1110011
    1.  [ ] ecall; imm=0
    2.  [ ] ebreak; imm=1

---

<font face="楷体" color=silver>

参考资料
- *riscv-unprivileged*
- *riscv-privileged*
- 《计算机组成与设计：硬件/软件接口 RISC-V版》（原书第2版） [美]戴维·A. 帕特森 [美]约翰·L. 亨尼斯
- 《计算机算术运算 原理、结构与设计》 黄铠著；李三立，林定基译；1980-12
- *Computer Arithmetic and Verilog HDL Fundamentals* Joseph Cavanagh CRC Press 2009

</font>