------------------------------------------------
-- Circuito: ula 4 bits:(ula1_4bits.vhd)
-- oper Selecao da entrada
-- a Entrada a(3:0)
-- b Entrada b(3:0)
-- s Saida s(3:0)
-- cin Entrada carry
-- cout Saida carry
-- Utilizacao mux1_4x1, soma_nb, AND/OR
------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------
ENTITY ula4bits IS
PORT (oper: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
b : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
s : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
cin : IN STD_LOGIC;
cout:OUT STD_LOGIC);
END ula4bits;
architecture structural of ula4bits is
-----------------------------------
component mux4x1
PORT ( sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
a, b, c, d : IN STD_LOGIC;
y : OUT STD_LOGIC);
end component;
-----------------------------------
-- Declaracao do componente soma_nb
-----------------------------------
component soma_nb
generic(N : integer);
port (an : in std_logic_vector(N downto 1);
bn : in std_logic_vector(N downto 1);
cin : in std_logic;
sn : out std_logic_vector(N downto 1);
cout : out std_logic);
end component;
constant Nbit : integer := 4;
signal t_and, t_or, t_out : std_logic_vector(Nbit-1 downto 0);
-- Declaracao do componente mux4x1
-----------------------------------
Begin
-- instanciando o mux4x1 Nbit vezes
mux: for I in 0 to Nbit-1 generate
mux: mux4x1 port map( sel => oper, a => t_and(I), b => t_or(I),
c => t_out(I), d => '0', y => s(I));
end generate;
-- instanciando o soma_1bit N vezes, onde N = Nbits
soman: soma_nb generic map(N=>Nbit)
PORT MAP ( an => a, bn => b, cin => cin,
sn => t_out, cout => cout);
-- bloco logico AND/OR
t_and <= a and b;
t_or <= a or b;
end structural.



