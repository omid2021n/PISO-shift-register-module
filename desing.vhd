library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity piso_shift_register is
    port (
        clk        : in  std_logic;
        rst_n      : in  std_logic;                     -- active-low async reset
        load       : in  std_logic;                     -- load parallel data, resets counter
        en         : in  std_logic;                     -- shift enable
        din        : in  std_logic_vector(7 downto 0);   -- 8-bit parallel input
        dout       : out std_logic;                      -- serial output (LSB shifted out first)
        done       : out std_logic                       -- high when all 8 bits have been shifted out
    );
end entity piso_shift_register;

architecture rtl of piso_shift_register is
    signal shift_reg   : std_logic_vector(7 downto 0);
    signal shift_count : unsigned(3 downto 0);   -- counts 0 to 8
begin

    process(clk, rst_n)
    begin
        if (rst_n = '0') then
            shift_reg   <= (others => '0');
            shift_count <= (others => '0');
        elsif rising_edge(clk) then
            if (load = '1') then
                shift_reg   <= din;
                shift_count <= (others => '0');
            elsif (en = '1' and shift_count < 8) then
                shift_reg   <= '0' & shift_reg(7 downto 1);
                shift_count <= shift_count + 1;
            end if;
        end if;
    end process;

    dout <= shift_reg(0);
    done <= '1' when (shift_count = 8) else '0';

end architecture rtl;
