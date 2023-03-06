----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 05:14:52 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
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
end UC;

architecture Behavioral of UC is

begin
    process(opCode)
    begin
    Jump <= '0';
    Branch <= '0';
    RegWrite <= '0';
    RegDst <= '0';
    ExtOp <= '0';
    AluSrc <= '0';
    MemWrite <= '0';
    MemToReg <= '0';
    AluOp <= "00";
        case opCode is
            -- de tip R
            when "000" => RegWrite <= '1'; 
                          RegDst <= '1';
            --addi
            when "001" => AluOp <= "01";
                          ExtOp <= '1';
                          AluSrc <= '1';
                          RegWrite <= '1';
            --lw
            when "010" => AluOp <= "01";
                          ExtOp <= '1';
                          AluSrc <= '1';
                          MemToReg <= '1';
                          RegWrite <= '1';
            --sw
            when "011" => AluOp <= "01";
                          ExtOp <= '1';
                          AluSrc <= '1';
                          MemWrite <= '1';
            --beq
            when "100" => AluOp <= "10";
                          ExtOp <= '1';
                          Branch <= '1'; 
            --instr pe care nu am facut-o inca 
            when "101" => AluSrc <= '0';
            --ori
            when "110" => AluSrc <= '1';
                         RegWrite <='1';
                         AluOp <= "11";
            -- j
            when "111" => Jump <= '1';
          end case;
     end process;                           
                          
end Behavioral;
