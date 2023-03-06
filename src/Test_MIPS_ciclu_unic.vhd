----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2022 12:36:19 AM
-- Design Name: 
-- Module Name: Test_MIPS_ciclu_unic - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_MIPS_ciclu_unic is
 Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Test_MIPS_ciclu_unic;

architecture Behavioral of Test_MIPS_ciclu_unic is

component Monoimpuls is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;

component SSD is
    Port ( digit : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component Fetch is
    Port ( clk : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           jmp : in STD_LOGIC;
           jmpAddr : in STD_LOGIC_VECTOR (15 downto 0);
           branchAddr : in STD_LOGIC_VECTOR (15 downto 0);
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           Instr : out STD_LOGIC_VECTOR (15 downto 0);
           PC_out : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component EU is
    Port(RD1: in STD_LOGIC_VECTOR (15 DOWNTO 0);
         RD2: in STD_LOGIC_VECTOR (15 DOWNTO 0);
         Ext_Imm: in STD_LOGIC_VECTOR (15 DOWNTO 0);
         AluOp: in STD_LOGIC_VECTOR (1 DOWNTO 0);
         AluSrc: in STD_LOGIC;
         func: in STD_LOGIC_VECTOR (2 DOWNTO 0);
         sa: in STD_LOGIC;
         AluRes: out STD_LOGIC_VECTOR (15 DOWNTO 0);
         zero: out STD_LOGIC;
         PcPlus: in STD_LOGIC_VECTOR(15 downto 0);
         BranchAddress: out STD_LOGIC_VECTOR(15 downto 0));
end component;

component ID is
    Port ( RegWrite : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Enable : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC);
end component;

component UC is
    Port ( opCode : in STD_LOGIC_VECTOR (2 downto 0);
           Jump : out STD_LOGIC ;
           Branch : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           AluSrc : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           AluOp : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component Unitate_Mem is
    Port ( AluRes : in STD_LOGIC_VECTOR (15 downto 0);
           RD : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           enable : in STD_LOGIC;
           clk : in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           AluResOut : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal en: STD_LOGIC := '0'; --enable pt IF, ID, UNITATEA DE MEMORIE
signal reset: STD_LOGIC:='0'; -- reset pt IF
signal jmp: STD_LOGIC :='0';
signal pcSrc: STD_LOGIC :='0';
signal jmpAddr: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal branchAddr: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal instruction: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal pcPlus1: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal code: STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
signal branch : STD_LOGIC :='0';
signal RegWrite : STD_LOGIC:='0';
signal RegDst : STD_LOGIC :='0';
signal ExtOp : STD_LOGIC :='0';
signal AluSrc : STD_LOGIC :='0';
signal MemWrite : STD_LOGIC :='0';
signal MemToReg : STD_LOGIC :='0';
signal AluOp : STD_LOGIC_VECTOR (1 downto 0):= (others => '0');
signal rd1: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal rd2: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal extImm: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal func: STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
signal sa: STD_LOGIC :='0';
signal wd: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal AluRes: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal zero: STD_LOGIC :='0';
signal AluResOut: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal MemData: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal digits: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

begin
    
    MPG_enable: Monoimpuls port map(clk => clk, btn => btn(0), enable => en);
    MPG_reset_IF: Monoimpuls port map(clk => clk, btn => btn(1), enable => reset);
    
    IF_component: Fetch port map(clk => clk, PCSrc => pcSrc, jmp => jmp, jmpAddr => jmpAddr, branchAddr => branchAddr, reset => reset, enable => en, Instr => instruction, PC_out => pcPlus1);
    jmpAddr<= pcPlus1(15 downto 13) & instruction(12 downto 0);
    code <= instruction(15 downto 13);
    UC_component: UC port map(opCode => code, RegDst => RegDst, ExtOp=>ExtOp, AluSrc=>AluSrc, Branch=>branch, Jump=>jmp, AluOp=>AluOp, MemWrite=>MemWrite, MemToReg=>MemToReg, RegWrite=> RegWrite);
    ID_component: ID port map(clk => clk, enable => en, RegWrite => RegWrite, ExtOp => ExtOp, Instr => instruction, WD => wd, RegDst => RegDst, RD1 => rd1, RD2 => rd2, func => func, sa => sa); 
    EU_component: EU port map(RD1=>rd1, RD2=>rd2, Ext_Imm=>extImm, AluOp=>AluOp, AluSrc=>AluSrc, func=>func, sa=>sa, PcPlus=>pcPlus1, AluRes=>AluRes, zero=>zero, BranchAddress=>branchAddr);
    MEM_component: Unitate_Mem port map(RD=>rd2, MemWrite=>MemWrite, AluRes=>AluRes, clk=>clk, MemData=>MemData, AluResOut=>AluResOut, enable=>en);
    
    wd<=MemData when MemToReg='1' else AluResOut;
    pcSrc <= branch and zero;

    mux_afisare: process(sw(7 downto 5))
    begin
        case sw(7 downto 5) is
            when "000" => digits <= instruction;
            when "001" => digits <= pcPlus1;
            when "010" => digits <= rd1;
            when "011" => digits <= rd2;
            when "100" => digits <= extImm;
            when "101" => digits <= AluRes;
            when "110" => digits <= MemData;
            when "111" => digits <= wd;
        end case;
    end process;
    
    led(15) <= jmp;
    led(14) <= branch;
    led(13) <= RegWrite;
    led(12) <= RegDst;
    led(11) <= ExtOp;
    led(10) <= AluSrc;
    led(9) <= MemWrite;
    led(8) <= MemToReg;
    led(7 downto 6) <= AluOp;
    
    DISPLAY: SSD port map(digit=>digits, clk=>clk, an=>an, cat=>cat);
    
end Behavioral;
