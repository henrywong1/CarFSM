LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY top_lvl IS
	PORT (L, R, H, CLK, Reset	: IN STD_LOGIC;
			LC, LB, LA, RA, RB, RC : OUT STD_LOGIC); --in order of how the tail lights would look like.
	END top_lvl;

ARCHITECTURE behavior of top_lvl IS
SIGNAL oclk : std_logic;

COMPONENT fsm_tl IS
	PORT (L, R, H, CLK, Reset	: IN STD_LOGIC;
			LC, LB, LA, RA, RB, RC : OUT STD_LOGIC); --in order of how the tail lights would look like.
	END COMPONENT;
	
COMPONENT clockdiv IS
    PORT (iclk : IN STD_LOGIC;
          oclk : OUT STD_LOGIC);
END COMPONENT;

BEGIN
	stage0: clockdiv PORT MAP (CLK, oclk);
	stage1: fsm_tl PORT MAP (L, R, H, oclk, Reset, LC, LB, LA, RA, RB, RC);
	
END Behavior;