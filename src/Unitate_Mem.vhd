----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 05:30:20 PM
-- Design Name: 
-- Module Name: Unitate_Mem - Behavioral
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

entity Unitate_Mem is
    Port ( AluRes : in STD_LOGIC_VECTOR (15 downto 0);
           RD : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           enable : in STD_LOGIC;
           clk : in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           AluResOut : out STD_LOGIC_VECTOR (15 downto 0));
end Unitate_Mem;

architecture Behavioral of Unitate_Mem is
    type ram_type is array (0 to 31) of std_logic_vector (15 downto 0);
    signal RAM: ram_type :=(
    x"0001",
    x"0002",
    x"0003",
    x"0004",
    x"0005",
    x"0006",
    x"0007",
    x"0008",
    others => x"0000");
    
begin
    
    process (clk)
    begin
        if rising_edge(clk) then
            if enable='1' and MemWrite='1' then 
                RAM(conv_integer(ALURes(4 downto 0))) <= RD;
            end if;
        end if;
     end process;
     
    ALUResOut <= ALURes;
    MemData <= RAM(conv_integer(ALURes(4 downto 0)));
          
end Behavioral;
