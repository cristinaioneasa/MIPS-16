----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 04:20:44 PM
-- Design Name: 
-- Module Name: EU - Behavioral
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

entity EU is
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
end EU;

architecture Behavioral of EU is

  signal AluCtrl : STD_LOGIC_VECTOR (2 DOWNTO 0):= (others => '0');
  signal mux : Std_logic_vector (15 downto 0):= (others => '0');
  signal res: Std_logic_vector (15 downto 0):= (others => '0');
  
begin 
    
    mux <= RD2 when AluSrc = '0' else Ext_Imm; --mux
    
    AluRes <= res;
    zero <= '1' when res = X"0000" else '0'; 
    BranchAddress <= PcPlus + Ext_Imm; 
    
    AluControl: process(AluOp, func)
    begin
        case AluOp is
            when "00" => AluCtrl <= func;
            when "01" => AluCtrl <= "000";
            when "10" => AluCtrl <= "001";
            when "11" => AluCtrl <= "101";
        end case;
    end process;

     
    Alu: process(AluCtrl, sa, mux, RD1, res)
    begin
    case AluCtrl is
        when "000" => res <= RD1 + mux;
        when "001" => res <= RD1 - mux;
        when "010" => case sa is
                            when '1' => res <= mux(14 downto 0) & '0';
                            when '0' => res <= mux;
                      end case;
       when "011" => case sa is
                            when '1' => res <= '0' & mux(15 downto 1);
                            when '0' => res <= mux;
                     end case;
       when "101" => res <= RD1 or mux;
       when "100" => res <= RD1 and mux;
       when "110" => res <= RD1 xor mux;
       when others => res <= x"0000";
    end case;
    end process;

end Behavioral;
