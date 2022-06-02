--------------------------------------------------------------------------------
--
-- LAB #3
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
  port(bitin: in std_logic;
 		 enout: in std_logic;
 		 writein: in std_logic;
 		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
 	signal q: std_logic := '0';
begin
  process(writein) is
  begin
    if (rising_edge(writein)) then
      q <= bitin;
    end if;
  end process;

-- Note that data is output only when enout = 0
  bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
 	port(datain: in std_logic_vector(7 downto 0);
 	     enout:  in std_logic;
 	     writein: in std_logic;
 	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
component bitstorage
port(bitin: in std_logic;
 	enout: in std_logic;
 	writein: in std_logic;
 	bitout: out std_logic);
end component;
begin
-- insert code here.
  bit0 : entity work.bitstorage(memlike) port map (datain(0), enout, writein, dataout(0));
  bit1 : entity work.bitstorage(memlike) port map (datain(1), enout, writein, dataout(1));
  bit2 : entity work.bitstorage(memlike) port map (datain(2), enout, writein, dataout(2));
  bit3 : entity work.bitstorage(memlike) port map (datain(3), enout, writein, dataout(3));
  bit4 : entity work.bitstorage(memlike) port map (datain(4), enout, writein, dataout(4));
  bit5 : entity work.bitstorage(memlike) port map (datain(5), enout, writein, dataout(5));
  bit6 : entity work.bitstorage(memlike) port map (datain(6), enout, writein, dataout(6));
  bit7 : entity work.bitstorage(memlike) port map (datain(7), enout, writein, dataout(7));

end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
  port(datain: in std_logic_vector(31 downto 0);
  	 enout32,enout16,enout8: in std_logic;
 		 writein32, writein16, writein8: in std_logic;
 		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
 	-- hint: you'll want to put register8 as a component here
  -- so you can use it below

  component register8
 	  port(datain: in std_logic_vector(7 downto 0);
 	     enout:  in std_logic;
 	     writein: in std_logic;
 	     dataout: out std_logic_vector(7 downto 0));
  end component;

signal enoutFromCat: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal enoutAll: std_logic_vector(3 DOWNTO 0);
signal writeInFromCat: std_logic_vector(2 DOWNTO 0);
signal writeInAll: std_logic_vector(3 DOWNTO 0);

begin
enoutFromCat <= (enout32 & enout16 & enout8);
writeInFromCat <= (writein32 & writein16 & writein8);

enoutAll <=
 "1110" when enoutFromCat = "110" else
 "1100" when enoutFromCat = "101" else
 "0000" when enoutFromCat = "011" else
 "1111" when enoutFromCat = "111";

writeInAll <=
 "0001" when writeInFromCat = "001" else
 "0011" when writeInFromCat = "010" else
 "1111" when writeInFromCat = "100" else
 "0000" when writeInFromCat = "000";

-- Create two seperate register8s, then make a reg16 from two 8's, then use two 8's and a 16 to make a 32
  rg8_a: entity work.register8(memmy) port map (datain(7 downto 0), enoutAll(0), writeInAll(0), dataout(7 downto 0));
  rg8_b: entity work.register8(memmy) port map (datain(15 downto 8), enoutAll(1), writeInAll(1), dataout(15 downto 8));
  rg8_c: entity work.register8(memmy) port map (datain(23 downto 16), enoutAll(2), writeInAll(2), dataout(23 downto 16));
  rg8_d: entity work.register8(memmy) port map (datain(31 downto 24), enoutAll(3), writeInAll(3), dataout(31 downto 24));

end architecture biggermem;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
          );
end fulladder;

architecture addlike of fulladder is
begin
  sum  <= a xor b xor cin;
  carry <= (a and b) or (a and cin) or (b and cin);
end architecture addlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
port( datain_a: in std_logic_vector(31 downto 0);
	datain_b: in std_logic_vector(31 downto 0);
	add_sub: in std_logic;
	dataout: out std_logic_vector(31 downto 0);
	co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
component fulladder
    port (a : in std_logic;
               b : in std_logic;
               cin : in std_logic;
               sum : out std_logic;
               carry : out std_logic
         );
end component;
SIGNAL b_num: std_logic_vector(31 DOWNTO 0);
SIGNAL carry: std_logic_vector (32 DOWNTO 0);

begin
carry(0) <= add_sub; -- Initial carry in; will be zero if adding and 1 if subtracting
co <= carry(32); -- final carry out value after specified operation is completed

process(add_sub, datain_b)
begin
if (add_sub = '0') then
b_num <= datain_b;
else
b_num <= NOT datain_b;
end if;
end process;


    -- Pass in add_sub to carry in and chain 32 1-bit fulladders together
    -- carry(n) passes carry-out from bit n to carry-in of adder n+1
    AS0: fulladder port map(datain_a(0), b_num(0), add_sub, dataout(0), carry(0));
    AS1: fulladder port map(datain_a(1), b_num(1), carry(0), dataout(1), carry(1));
    AS2: fulladder port map(datain_a(2), b_num(2), carry(1), dataout(2), carry(2));
    AS3: fulladder port map(datain_a(3), b_num(3), carry(2), dataout(3), carry(3));
    AS4: fulladder port map(datain_a(4), b_num(4), carry(3), dataout(4), carry(4));
    AS5: fulladder port map(datain_a(5), b_num(5), carry(4), dataout(5), carry(5));
    AS6: fulladder port map(datain_a(6), b_num(6), carry(5), dataout(6), carry(6));
    AS7: fulladder port map(datain_a(7), b_num(7), carry(6), dataout(7), carry(7));
    AS8: fulladder port map(datain_a(8), b_num(8), carry(7), dataout(8), carry(8));
    AS9: fulladder port map(datain_a(9), b_num(9), carry(8), dataout(9), carry(9));
    AS10: fulladder port map(datain_a(10), b_num(10), carry(9), dataout(10), carry(10));
    AS11: fulladder port map(datain_a(11), b_num(11), carry(10), dataout(11), carry(11));
    AS12: fulladder port map(datain_a(12), b_num(12), carry(11), dataout(12), carry(12));
    AS13: fulladder port map(datain_a(13), b_num(13), carry(12), dataout(13), carry(13));
    AS14: fulladder port map(datain_a(14), b_num(14), carry(13), dataout(14), carry(14));
    AS15: fulladder port map(datain_a(15), b_num(15), carry(14), dataout(15), carry(15));
    AS16: fulladder port map(datain_a(16), b_num(16), carry(15), dataout(16), carry(16));
    AS17: fulladder port map(datain_a(17), b_num(17), carry(16), dataout(17), carry(17));
    AS18: fulladder port map(datain_a(18), b_num(18), carry(17), dataout(18), carry(18));
    AS19: fulladder port map(datain_a(19), b_num(19), carry(18), dataout(19), carry(19));
    AS20: fulladder port map(datain_a(20), b_num(20), carry(19), dataout(20), carry(20));
    AS21: fulladder port map(datain_a(21), b_num(21), carry(20), dataout(21), carry(21));
    AS22: fulladder port map(datain_a(22), b_num(22), carry(21), dataout(22), carry(22));
    AS23: fulladder port map(datain_a(23), b_num(23), carry(22), dataout(23), carry(23));
    AS24: fulladder port map(datain_a(24), b_num(24), carry(23), dataout(24), carry(24));
    AS25: fulladder port map(datain_a(25), b_num(25), carry(24), dataout(25), carry(25));
    AS26: fulladder port map(datain_a(26), b_num(26), carry(25), dataout(26), carry(26));
    AS27: fulladder port map(datain_a(27), b_num(27), carry(26), dataout(27), carry(27));
    AS28: fulladder port map(datain_a(28), b_num(28), carry(27), dataout(28), carry(28));
    AS29: fulladder port map(datain_a(29), b_num(29), carry(28), dataout(29), carry(29));
    AS30: fulladder port map(datain_a(30), b_num(30), carry(29), dataout(30), carry(30));
    AS31: fulladder port map(datain_a(31), b_num(31), carry(30), dataout(31), carry(31));

end architecture calc;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
port( datain: in std_logic_vector(31 downto 0);
  dir: in std_logic; -- 0 is shit left 1 is shift right
shamt: in std_logic_vector(4 downto 0); -- shift amount. 5 bits since 2^5 is 32
dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
SIGNAL VEC: std_logic_vector (2 downto 0);

begin
VEC <= (dir & shamt(1 downto 0));

process(VEC, dir, shamt, datain)

begin

case VEC is
  when "001" =>   dataout <= (datain(30 downto 0) & "0");
  when "010" =>   dataout <= (datain(29 downto 0) & "00");
  when "011" =>   dataout <= (datain(28 downto 0) & "000");
  when "101" =>   dataout <= ("0" & datain(31 downto 1));
  when "110" =>   dataout <= ("00" & datain(31 downto 2));
  when "111" =>   dataout <= ("000" & datain(31 downto 3));
  when others =>  dataout <= (datain(31 downto 0));
end case;

end process;
end architecture shifter;
