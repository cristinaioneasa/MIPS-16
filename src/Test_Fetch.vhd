----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2022 05:23:02 PM
-- Design Name: 
-- Module Name: Test_Fetch - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_Fetch is
     Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Test_Fetch;

architecture Behavioral of Test_Fetch is

signal enable: STD_LOGIC;
signal reset: STD_LOGIC;
signal instruction: STD_LOGIC_VECTOR(15 downto 0); --Instr
signal pc: STD_LOGIC_VECTOR(15 downto 0); --PC_out
signal digits: STD_LOGIC_VECTOR(15 downto 0);

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

begin
    
    MPG1: Monoimpuls port map (btn => btn(0), clk => clk, enable => enable);
    MPG2: Monoimpuls port map (btn => btn(1), clk => clk, enable => reset);
    InstrF: Fetch port map(clk => clk, PcSrc => sw(0), jmp => sw(1), branchAddr => x"0004", jmpAddr=> x"0000", reset => reset, enable => enable, Instr => instruction, PC_out => pc);

    digits <= instruction when sw(2) = '0' else pc;
    
    DISPLAY: SSD port map(digit => digits, clk => clk, an => an, cat => cat);
    
end Behavioral;
