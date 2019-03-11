LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fsm_tl IS
	PORT (L, R, H, CLK, Reset	: IN STD_LOGIC;
			LC, LB, LA, RA, RB, RC : OUT STD_LOGIC); --in order of how the tail lights would look like.
	END fsm_tl;

ARCHITECTURE behavior OF fsm_tl IS

Type statet IS (idle, s1, s2, s3, s4, s5, s6, s7);
SIGNAL currentState, nextState : statet;
SIGNAL input : std_logic_vector(2 downto 0);

BEGIN
	PROCESS(currentState, L, R, H, CLK, Reset)
	BEGIN
		input <= L & R & H;
		IF Reset = '1' THEN
				nextState <= idle;
		ELSIF (CLK'event AND CLK = '1') THEN
			CASE currentState IS
			
			WHEN idle =>
				IF (input = "000") THEN
					nextState <= idle;
				ELSIF (input = "100") THEN
					nextState <= s1;
				ELSIF (input = "010") THEN
					nextState <= s4;
				ELSE
					nextState <= s7;
				END IF;
			
			WHEN s1 =>
				IF (input(0) = '1') THEN
					nextState <= s7;	--Input(2) = L. Input(1) = R. Input(0) = H.
				ELSIF (input = "100") THEN
					nextState <= s2;
				ELSE
					nextState <= IDLE;
				END IF;
				
			WHEN s2 =>
				IF (INPUT(0) = '1') THEN
					nextState <= s7;
				ELSIF (input = "100") THEN
					nextState <= s3;
				ELSE
					nextState <= idle;
				END IF;
				
			WHEN s4 =>
				IF (INPUT(0) = '1') THEN
					nextState <= s7;
				ELSIF (input = "010") THEN
					nextState <= s5;
				ELSE
					nextState <= idle;
				END IF;
				
			WHEN s5 =>
				IF (INPUT(0) = '1') THEN
					nextState <= s7;
				ELSIF (input = "010") THEN
					nextState <= s6;
				ELSE
					nextState <= idle;
				END IF;	
			
			WHEN s3|s6 =>					-- since both the next states that come after s3 or s6 are the same. The | represents a delimiter, seperates choices.
				IF (INPUT(0) = '1') THEN
					nextState <= s7;
				ELSE
					nextState <= idle;
				END IF;
			
			WHEN s7 =>
				nextState <= idle;
			END CASE;
			currentState <= nextState;
		END IF;
	END PROCESS;
	
	PROCESS (currentState)
	BEGIN
		LC <= '0';
		LB <= '0';
		LA <= '0';
		RA <= '0';
		RB <= '0';
		RC <= '0';
		
	CASE currentState IS
		WHEN idle => null;
		--for left
		WHEN s1 => LA <= '1';
		WHEN s2 => LB <= '1'; LA <= '1';
		WHEN s3 => LC <= '1'; LA <= '1'; LB <= '1';
		--for right
		WHEN s4 => RA <= '1';
		WHEN s5 => RB <= '1'; RA <= '1';
		WHEN s6 => RC <= '1'; RA <= '1'; RB <= '1';
		--Hazard light
		WHEN s7 => LC <= '1'; LA <= '1'; LB <= '1'; RC <= '1'; RA <= '1'; RB <= '1';
	END CASE;
	END PROCESS;
	
END behavior;
	
	
	
	
		
		
		
		
		





