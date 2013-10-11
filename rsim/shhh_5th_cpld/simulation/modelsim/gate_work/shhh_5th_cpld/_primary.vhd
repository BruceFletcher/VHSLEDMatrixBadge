library verilog;
use verilog.vl_types.all;
entity shhh_5th_cpld is
    port(
        in_row_clk      : in     vl_logic;
        in_row_data     : in     vl_logic;
        in_column       : in     vl_logic_vector(3 downto 0);
        in_button       : in     vl_logic_vector(4 downto 0);
        out_row         : out    vl_logic_vector(15 downto 0);
        out_column      : out    vl_logic_vector(15 downto 0);
        out_button      : out    vl_logic_vector(2 downto 0)
    );
end shhh_5th_cpld;
