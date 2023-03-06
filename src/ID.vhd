----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 04:21:27 PM
-- Design Name: 
-- Module Name: ID - Behavioral
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

entity ID is
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
end ID;

architecture Behavioral of ID is

signal rs : STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
signal rt : STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
signal rd : STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
signal wa: STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
signal extBit: STD_LOGIC_VECTOR (8 downto 0):= (others => '0');

type reg_array is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal RF : reg_array := ( 
        others => X"0000");

begin
    
    rs <= Instr(12 downto 10);
    rt <= Instr(9 downto 7);
    rd <= Instr(6 downto 4);
    sa <= Instr(3);
    func <= Instr(2 downto 0);
    
    wa <= rt when RegDst ='0' else rd;  --mux
    
    extBit <= "000000000" when Instr(6) = '0' else "111111111";
    Ext_Imm <= "000000000" & Instr(6 downto 0) when ExtOp = '0' else extBit & Instr(6 downto 0);
        
    RD1 <= RF(conv_integer(rs));
    RD2 <= RF(conv_integer(rt));
    
    registrul: process(clk)			
    begin
        if rising_edge(clk) then
            if RegWrite = '1' and enable = '1' then
                RF(conv_integer(wa)) <= WD;		
            end if;
        end if;
    end process;		

end Behavioral;
