-------------------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity example_concatenation_operator is
end example_concatenation_operator;

architecture behave of example_concatenation_operator is

  signal r_VAL_1  : std_logic := '0';
  signal r_VAL_2  : std_logic := '0';
  signal r_RESULT : integer range 0 to 4;

begin


  -- Uses r_VAL_1 and r_VAL_2 together to drive a case statement
  -- This process is synthesizable
  p_CASE : process (r_VAL_1, r_VAL_2)
    variable v_CONCATENATE : std_logic_vector(1 downto 0);
  begin
    v_CONCATENATE := r_VAL_1 & r_VAL_2;

    case v_CONCATENATE is
      when "00" =>
        r_RESULT <= 0;
      when "01" =>
        r_RESULT <= 1;
      when "10" =>
        r_RESULT <= 2;
      when "11" =>
        r_RESULT <= 3;
      when others =>
        r_RESULT <= 0;
    end case;

  end process;


  -- This process is NOT synthesizable.  Test code only!
  -- Provides inputs to code and prints debug statements to console.
  p_TEST_BENCH : process is
  begin
    r_VAL_1 <= '0';
    r_VAL_2 <= '0';
    wait for 100 ns;
    report "Value of Result = " & integer'image(r_RESULT) severity note;
    r_VAL_1 <= '0';
    r_VAL_2 <= '1';
    wait for 100 ns;
    report "Value of Result = " & integer'image(r_RESULT) severity note;
    r_VAL_1 <= '1';
    r_VAL_2 <= '0';
    wait for 100 ns;
    report "Value of Result = " & integer'image(r_RESULT) severity note;
    r_VAL_1 <= '1';
    r_VAL_2 <= '1';
    wait for 100 ns;
    report "Value of Result = " & integer'image(r_RESULT) severity note;
    wait;
  end process;

end behave;
