----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2022 05:05:40 PM
-- Design Name: 
-- Module Name: Monoimpuls - Behavioral
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

entity Monoimpuls is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);
end Monoimpuls;

architecture Behavioral of Monoimpuls is

Signal cnt:STD_LOGIC_VECTOR(15 downto 0):=x"0000";
Signal Q1:STD_LOGIC;
Signal Q2:STD_LOGIC;
Signal Q3:STD_LOGIC;

begin
  
  process(clk)
    begin
        if rising_edge(clk) then
            cnt <=  cnt+1;
        end if;
  end process;
  
  process(clk)
     begin
        if rising_edge(clk) then
            if cnt=x"FFFF" then
                Q1  <=  btn;
            end if;
        end if;
  end process;
  
  process(clk)
    begin
        if rising_edge(clk) then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
  end process;
  
  enable <= not Q3 and Q2;
  
end Behavioral;
