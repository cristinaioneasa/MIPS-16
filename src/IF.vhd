----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2022 04:31:51 PM
-- Design Name: 
-- Module Name: IF - Behavioral
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

entity Fetch is
    Port ( clk : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           jmp : in STD_LOGIC;
           jmpAddr : in STD_LOGIC_VECTOR (15 downto 0);
           branchAddr : in STD_LOGIC_VECTOR (15 downto 0);
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           Instr : out STD_LOGIC_VECTOR (15 downto 0);
           PC_out : out STD_LOGIC_VECTOR (15 downto 0));
end Fetch;

architecture Behavioral of Fetch is

type memorie is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
signal ROM: memorie :=(
--fibonacci din video
--B"001_000_001_0000000",
--B"001_000_010_0000001",
--B"001_000_011_0000000",
--B"001_000_100_0000001",
--B"011_011_001_0000000",
--B"011_100_010_0000000",
--B"010_011_001_0000000",
--B"010_100_010_0000000",
--B"000_001_010_101_0_000",
--B"000_000_010_001_0_000",
--B"000_000_101_101_0_000",
--B"111_0000000001000",

-- cel cu lw
B"000_000_000_001_0000", --0010
B"001_000_010_000_1000", --2104
B"000_000_000_011_0000", --0030
B"000_000_000_100_0000",--0040
B"100_001_010_0000101", --8505
B"010_011_101_0000000", --4A81
B"000_100_101_100_0000", --12C0
B"001_011_011_0000010", --2D88
B"001_001_001_0000010", --2482
B"111_0000000000101", --E005
B"011_000_101_0000101", --6285

--cel usor (suma nr imapare)
--B"000_000_000_001_0000", --0010
--B"001_000_010_0000101", --2105
--B"001_000_011_0000001", --2181
--B"001_000_100_0000001", --2201
--B"100_001_010_0000011", --8503
--B"001_000_100_0000010", --2202
--B"000_100_000_011_0000",--1030
--B"001_001_001_0000001", --2481
--B"111_0000000000101", --E005
others => x"0000");

signal PC: STD_LOGIC_VECTOR (15 downto 0):= (others => '0'); --iesire mux 2
signal PC1: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');  --iesire din pc
signal br: STD_LOGIC_VECTOR(15 downto 0):= (others => '0'); --iesire mux 1
signal sum: STD_LOGIC_VECTOR(15 downto 0):= (others => '0'); --pc+1

begin
    comp_PC: process(clk, enable, reset)
    begin
            if rising_edge(clk) then
                if reset = '1' then
                    PC1<=x"0000";
                else if enable = '1' then 
                        PC1 <= PC;
                    end if;
                end if;
            end if;
     end process;
  
  sum <= PC1 + 1;
  PC_out <= sum;
  br <= sum when PCSrc='0' else branchAddr; -- primul mux
  PC <= jmpAddr when jmp='1' else br; --al doilea mux
  
  Instr <= ROM(conv_integer(PC1)); 
    
end Behavioral;
