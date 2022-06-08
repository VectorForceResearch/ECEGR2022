--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
  Port( DataIn1: in std_logic_vector(31 downto 0);
        DataIn2: in std_logic_vector(31 downto 0);
        ALUCtrl: in std_logic_vector(4 downto 0);
        Zero: out std_logic;
        ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
  -- ALU components
  component adder_subtracter
      port(	datain_a: in std_logic_vector(31 downto 0);
            datain_b: in std_logic_vector(31 downto 0);
            add_sub: in std_logic;
            dataout: out std_logic_vector(31 downto 0);
            co: out std_logic);
  end component adder_subtracter;

  component shift_register
      port( datain: in std_logic_vector(31 downto 0);
            dir: in std_logic;
            shamt: in std_logic_vector(4 downto 0);
            dataout: out std_logic_vector(31 downto 0));
  end component shift_register;

begin
  -- Add ALU VHDL implementation here
  ALU : process is
        procedure ALUCtrl is
            add : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            sub : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            addi : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            and : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            andi : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            or : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            ori : entity work.adder_subtracter(ALU-Arch) port map (datain_a(31 downto 0), datain_b(31 downto 0), add_sub, dataout(31 downto 0), co);
            sll : entity work.shift_register(ALU-Arch) port map (datain_a(31 downto 0), dir, shamt(4 downto 0), dataout(31 downto 0));
            slli : entity work.shift_register(ALU-Arch) port map (datain_a(31 downto 0), dir, shamt(4 downto 0), dataout(31 downto 0));
            srl : entity work.shift_register(ALU-Arch) port map (datain_a(31 downto 0), dir, shamt(4 downto 0), dataout(31 downto 0));
            srli : entity work.shift_register(ALU-Arch) port map (datain_a(31 downto 0), dir, shamt(4 downto 0), dataout(31 downto 0));

            begin
                if (ALUResult = "0") then
                    Zero <= "1";
                else
                    Zero <= "0";
                end if;
                
        begin
         case ALUCtrl is
           when "00010" =>   ALUResult <= (DataIn1(31 downto 0));  -- add
           when "00110" =>   ALUResult <= (DataIn1(31 downto 0));  -- sub
           when "00010" =>   ALUResult <= (DataIn2(31 downto 0));  -- addi
           when "00000" =>   ALUResult <= (DataIn1(31 downto 0));  -- and
           when "00000" =>   ALUResult <= (DataIn1(31 downto 0));  -- andi
           when "00001" =>   ALUResult <= (DataIn1(31 downto 0));  -- or
           when "00001" =>   ALUResult <= (DataIn2(31 downto 0));  -- ori
           when "00111" =>   ALUResult <= (DataIn1(31 downto 0));  -- sll
           when "00111" =>   ALUResult <= (DataIn2(31 downto 0));  -- slli
           when "00111" =>   ALUResult <= (DataIn1(31 downto 0));  -- srl
           when "00111" =>   ALUResult <= (DataIn2(31 downto 0))   -- srli
           when others  =>   ALUResult <= (Zero);
         end case;
    end process;

end architecture ALU_Arch;
