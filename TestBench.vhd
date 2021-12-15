-- ALU TestBench
-- Tylon Guan ID: 112759081
-- Joseph Zappala ID: 112771339
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity testbench is -- test bench entity has no ports
end testbench;


architecture alu_tb of testbench is
-- inputs
signal rs1_tb, rs2_tb, rs3_tb : STD_LOGIC_VECTOR(127 downto 0); 
signal opcode_tb : STD_LOGIC_VECTOR(9 downto 0);

-- outputs
signal rd_tb : std_logic_vector(127 downto 0); 

 

begin
uut : entity alu
port map (rs1 => rs1_tb, 
		rs2 => rs2_tb, 
        rs3 => rs3_tb, 
        opcode => opcode_tb,
        rd => rd_tb);
        
tb: process 
constant optime : time := 40 ns; 
begin 
	--its gonna be normal, ovf, and underflow
	opcode_tb <= "1000000000"; --Signed Integer Multiply-Add Low with Saturation
    rs3_tb <= x"FFFF0010FFFFABCD0000638112345678";
    rs2_tb <= x"FFFF0002FFFF3DFFFA2F749287654321";
    rs1_tb <= x"00000020A37481920A935B6900040000";
    -- output= "000000408F107BC537E28EFB16B08D78"
    wait for optime;
    assert (rd_tb = x"000000408F107BC537E28EFB16B08D78")
    	report "Fail " severity failure;
    
    rs3_tb <= x"0000638112345678FFFF5864FFFF8432";
    rs2_tb <= x"FA2F749287654321FFFF4200FFFF69AA";
    rs1_tb <= x"0A935B69000400007FFFFEF280000040";
    -- output= "37E28EFB16B08D787FFFFFFF80000000"
    wait for optime;
     assert (rd_tb = x"37E28EFB16B08D787FFFFFFF80000000")
    	report "Fail " severity failure;
    
	opcode_tb <= "1000100000"; --igned Ineger Multiply-Add High with Saturation
    rs3_tb <= x"0010FFFFABCDFFFF6381000056781234";
    rs2_tb <= x"0002FFFF3DFFFFFF7492FA2F43218765";
    rs1_tb <= x"00000020A37481920A935B6900040000";
    -- output= "000000408F107BC537E28EFB16B08D78"
    wait for optime;
     assert (rd_tb = x"000000408F107BC537E28EFB16B08D78")
    	report "Fail " severity failure;
    
    rs3_tb <= x"63810000567812345864FFFF8432FFFF";
    rs2_tb <= x"7492FA2F432187654200FFFF69AAFFFF";
    rs1_tb <= x"0A935B69000400007FFFFEF280000040";
    -- output= "37E28EFB16B08D787FFFFFFF80000000"
    wait for optime;
		 assert (rd_tb = x"37E28EFB16B08D787FFFFFFF80000000")
    	report "Fail " severity failure;

	opcode_tb <= "1001000000"; --Signed Iteger Multiply-Subtract Low with Saturation
    rs3_tb <= x"FFFF0010FFFFABCD0000638112345678";
    rs2_tb <= x"FFFF0002FFFF3DFFFA2F749287654321";
    rs1_tb <= x"00000020A37481920A935B6900040000";
    -- output= "00000000B7D8875FDD4427D7E9577288"
    wait for optime;
     assert (rd_tb = x"00000000B7D8875FDD4427D7E9577288")
    	report "Fail " severity failure;
    
    rs3_tb <= x"0000638112345678FFFF5864FFFF8432";
    rs2_tb <= x"FA2F749287654321FFFF4200FFFF69AA";
    rs1_tb <= x"0A935B6900040000800000407FFFFEF2";
    -- output= "DD4427D7E9577288800000007FFFFFFF"
    wait for optime;
     assert (rd_tb = x"DD4427D7E9577288800000007FFFFFFF")
    	report "Fail " severity failure;
        
	opcode_tb <= "1001100000"; --Signed Iteger Multiply-Subtract High with Saturation
    rs3_tb <= x"0010FFFFABCDFFFF6381000056781234";
    rs2_tb <= x"0002FFFF3DFFFFFF7492FA2F43218765";
    rs1_tb <= x"00000020A37481920A935B6900040000";
    -- output= "00000000B7D8875FDD4427D7E9577288"
    wait for optime;
     assert (rd_tb = x"00000000B7D8875FDD4427D7E9577288")
    	report "Fail " severity failure;
        
    rs3_tb <= x"63810000567812345864FFFF8432FFFF";
    rs2_tb <= x"7492FA2F432187659200FFFF89AAFFFF";
    rs1_tb <= x"0A935B69000400007FFFFEF280000040";
    -- output= "DD4427D7E95772887FFFFFFF80000000"
    wait for optime;
     assert (rd_tb = x"DD4427D7E95772887FFFFFFF80000000")
    	report "Fail " severity failure;
    
	opcode_tb <= "1010000000"; -- Signed Long Integer Multiply-Add Low with Saturation
	rs3_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs1_tb <= x"0232432112349FB300100E0230200B20";
    -- output= 	"034CA10EAFC6701304D6336FC2B59444"	
    wait for optime;
     assert (rd_tb = x"034CA10EAFC6701304D6336FC2B59444")	
    	report "Fail " severity failure;
        
    rs3_tb <= x"05DE0A3B1000D4004321604CF3411234";
    rs2_tb <= x"30200B2000100E0212349FB392324321";
    rs1_tb <= x"8232432112349FB300100E0230200B20";
    -- output= "8233440E7DCE47B30587978DC96EFFD4"
    wait for optime;            
     assert (rd_tb = x"8233440E7DCE47B30587978DC96EFFD4")  
    	report "Fail " severity failure;
    
    rs3_tb <= x"05DE0A3B1000D4004321604CF3411234";
    rs2_tb <= x"30200B2000100E0212349FB302324321";
    rs1_tb <= x"7FFFFFFFFFFFFFFE8000000000000001";
    -- output= "7FFFFFFFFFFFFFFF8000000000000000"
    wait for optime;
     assert (rd_tb = x"7FFFFFFFFFFFFFFF8000000000000000")
    	report "Fail " severity failure;
        
	opcode_tb <= "1010100000"; -- Signed Long Integer Multiply-Add High with Saturation
	rs3_tb <= x"05DE0A3B1000D4004321604CF3411234";
    rs2_tb <= x"30200B2000100E0212349FB302324321";
    rs1_tb <= x"0232432112349FB300100E0230200B20";
	--recieved="034CA10EAFC6701304D6336FC2B59444"
    wait for optime;
     assert (rd_tb = x"034CA10EAFC6701304D6336FC2B59444") 
    	report "Fail " severity failure;
        
    rs3_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B209232432112349FB3";
    rs1_tb <= x"8232432112349FB300100E0230200B20";
    -- output= "8233440E7DCE47B30587978DC96EFFD4"
    wait for optime; 
     assert (rd_tb = x"8233440E7DCE47B30587978DC96EFFD4") 
    	report "Fail " severity failure;
        
    rs3_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs1_tb <= x"7FFFFFFFFFFFFFFE8000000000000001";
    -- output= "7FFFFFFFFFFFFFFF8000000000000000"
    wait for optime;
     assert (rd_tb = x"7FFFFFFFFFFFFFFF8000000000000000")
    	report "Fail " severity failure;
        
    opcode_tb <= "1011000000"; --Signed Long Integer Multiply-Subtract Low with Saturation
    rs3_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs1_tb <= x"0232432112349FB300100E0230200B20";
    -- output= "0117E53374A2CF53FB49E8949D8A81FC"
	
    wait for optime;
    assert (rd_tb = x"0117E53374A2CF53FB49E8949D8A81FC")
    	report "Fail " severity failure;
        
    rs3_tb <= x"05DE0A3B1000D4004321604CF3411234";
    rs2_tb <= x"30200B2000100E0212349FB392324321";
    rs1_tb <= x"8232432112349FB300100E0230200B20";
    -- output= "82314233A69AF7B3FA98847696D1166C"
    wait for optime;    
    assert (rd_tb = x"82314233A69AF7B3FA98847696D1166C")
    	report "Fail " severity failure;
        
    rs3_tb <= x"05DE0A3B1000D4004321604CF3411234";
    rs2_tb <= x"30200B2000100E0212349FB302324321";
    rs1_tb <= x"80000000000000017FFFFFFFFFFFFFFE";
    -- output= "80000000000000007FFFFFFFFFFFFFFF"
    wait for optime;
    assert (rd_tb = x"80000000000000007FFFFFFFFFFFFFFF")
    	report "Fail " severity failure;
        
	opcode_tb <= "1011100000"; -- Signed Long Integer Multiply-Subtract High with Saturation
	rs3_tb <= x"05DE0A3B1000D4004321604CF3411234";
    rs2_tb <= x"30200B2000100E0212349FB302324321";
    rs1_tb <= x"0232432112349FB300100E0230200B20";
    -- output= "0117E53374A2CF53FB49E8949D8A81FC"
    wait for optime;
    assert (rd_tb = x"0117E53374A2CF53FB49E8949D8A81FC")
    	report "Fail " severity failure;
        
    rs3_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B209232432112349FB3";
    rs1_tb <= x"8232432112349FB300100E0230200B20";
    -- output= "82314233A69AF7B3FA98847696D1166C"
    wait for optime; 
    assert (rd_tb = x"82314233A69AF7B3FA98847696D1166C")
    	report "Fail " severity failure;
        
    rs3_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
	rs1_tb <= x"80000000000000017FFFFFFFFFFFFFFE";    
    -- output= "80000000000000007FFFFFFFFFFFFFFF" 
    wait for optime;
    assert (rd_tb = x"80000000000000007FFFFFFFFFFFFFFF") 
    	report "Fail " severity failure;
        
    
    -- R3-Instruction Format
	opcode_tb <= "1100000000"; -- nop
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    wait for optime;
    assert (rd_tb = x"80000000000000007FFFFFFFFFFFFFFF")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00104E023020FB201232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    wait for optime;
    assert (rd_tb = x"80000000000000007FFFFFFFFFFFFFFF")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    wait for optime;
    assert (rd_tb = x"80000000000000007FFFFFFFFFFFFFFF")
    	report "Fail " severity failure;
        
    -- output for all should be  everything
    
	opcode_tb <= "1100000001"; -- AH
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="1010E20235FE155BF57355555555FFFF"
    wait for optime;
    assert (rd_tb = x"1010E20235FE155BF57355555555FFFF")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00104E023020FB201232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="1010220235FE055B057355555555FFFF"
    --C = "01011000"
    wait for optime;
    assert (rd_tb = x"1010220235FE055B057355555555FFFF")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="1010E20235FE155BF57355555555FFFF"
    wait for optime;
    assert (rd_tb = x"1010E20235FE155BF57355555555FFFF")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100000010"; -- AHS
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="1010e20235fe155bf57355555555ffff"
    wait for optime;
    assert (rd_tb = x"1010e20235fe155bf57355555555ffff")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40080000A3BF3417fff4321604C";
    rs2_tb <= x"00108E02FFFFFB201232000154319FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="101080008000055b05737fff7fffffff"
    wait for optime;
    assert (rd_tb = x"101080008000055b05737fff7fffffff")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100000011"; -- BCW
    rs1_tb <= x"000000000000000000000000FFFFFFFF";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    wait for optime;
    assert (rd_tb = x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="4321604C4321604C4321604C4321604C"
    wait for optime;
    assert (rd_tb = x"4321604C4321604C4321604C4321604C")
    	report "Fail " severity failure;
        
    rs1_tb <= x"00100E0230200B200232432112349FB3";
    rs2_tb <= x"00000000000000000000000000000000";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="12349FB312349FB312349FB312349FB3"
    wait for optime;
    assert (rd_tb = x"12349FB312349FB312349FB312349FB3")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100000100"; -- CGH
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="00000000000000000000000000000000"
    wait for optime;
    assert (rd_tb = x"00000000000000000000000000000000")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00104E023020FB201232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="00000001000000010001000000000000"
    wait for optime;
    assert (rd_tb = x"00000001000000010001000000000000")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="00010001000100010001000100010001"
    wait for optime;
    assert (rd_tb = x"00010001000100010001000100010001")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100000101"; -- CLZ
    rs1_tb <= x"1000D40005DE0A3B000112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="00000003000000050000000F00000001"
    wait for optime;
	assert (rd_tb = x"00000003000000050000000F00000001")
    	report "Fail " severity failure;
        
    rs1_tb <= x"00100E0230200B20023243211F349FB3";
    rs2_tb <= x"00104E023020FB201232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="0000000B000000020000000600000003"
    wait for optime;
	assert (rd_tb = x"0000000B000000020000000600000003")
    	report "Fail " severity failure;
        
    rs1_tb <= x"00000000000000018000000070000000";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="000000200000001F0000000000000001"
    wait for optime;					  
	assert (rd_tb = x"000000200000001F0000000000000001")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100000110"; -- max
    rs1_tb <= x"1000D40005DE0A3B000112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="1000D40030200B20023243214321604C"
    wait for optime;
    assert (rd_tb = x"1000D40030200B20023243214321604C")
    	report "Fail " severity failure;
        
    rs1_tb <= x"10104E0230200B20023243218F349FB3";
    rs2_tb <= x"10104E023020FB209232432182349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="10104E023020FB20023243218F349FB3"
    wait for optime;
    assert (rd_tb = x"10104E023020FB20023243218F349FB3")
    	report "Fail " severity failure;
        
    rs1_tb <= x"000000007FFFFFFFFFFFFFFF00000000";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFF00000000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="000000007FFFFFFFFFFFFFFF00000000"
    wait for optime;
    assert (rd_tb = x"000000007FFFFFFFFFFFFFFF00000000")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100000111"; -- min
    rs1_tb <= x"1000D40005DE0A3B000112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="00100E0205DE0A3B0001123412349FB3"
    wait for optime;
    assert (rd_tb = x"00100E0205DE0A3B0001123412349FB3")
    	report "Fail " severity failure;
        
    rs1_tb <= x"10104E0230200B20023243218F349FB3";
    rs2_tb <= x"10104E023020FB209232432182349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="10104E0230200B209232432182349FB3"
    wait for optime;
    assert (rd_tb = x"10104E0230200B209232432182349FB3")
    	report "Fail " severity failure;
        
    rs1_tb <= x"000000007FFFFFFFFFFFFFFF00000000";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFF00000000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="FFFFFFFFFFFFFFFFFFFFFFFF00000000"
    wait for optime;
    assert (rd_tb = x"FFFFFFFFFFFFFFFFFFFFFFFF00000000")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100001000"; -- MSGN
    rs1_tb <= x"1000D40005DE0A3B000112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="1000D40005DE0A3B000112344321604C"
    wait for optime;
    assert (rd_tb = x"1000D40005DE0A3B000112344321604C")
    	report "Fail " severity failure;
        
    rs1_tb <= x"10104E0230200B20023243218F349FB3";
    rs2_tb <= x"10104E028020FB209232432182349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="10104E02cfdff4e0fdcdbcdf70cb604d"
    wait for optime;
    assert (rd_tb = x"10104E02cfdff4e0fdcdbcdf70cb604d")
    	report "Fail " severity failure;
        
    rs1_tb <= x"000000007FFFFFFFFFFFFFFF80000000";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFE0007000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="00000000800000010000000180000000"
    wait for optime;
    assert (rd_tb = x"00000000800000010000000180000000")
    	report "Fail " severity failure;
    rs1_tb <= x"10104E0230200B20023243218F349FB3";
    rs2_tb <= x"00000000000000000000000000000000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="00000000000000000000000000000000"
    wait for optime;
    assert (rd_tb = x"00000000000000000000000000000000")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100001001"; -- popcnth
    rs1_tb <= x"1000D40005DE0A3B000112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="00010004000800070001000500050005"
    wait for optime;
    assert (rd_tb = x"00010004000800070001000500050005")
    	report "Fail " severity failure;
        
    rs1_tb <= x"10104E0230200B20023243218F349FB3";
    rs2_tb <= x"10104E028020FB209232432182349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="0002000500030004000400050008000B"
    wait for optime;
    assert (rd_tb = x"0002000500030004000400050008000B")
    	report "Fail " severity failure;
        
    rs1_tb <= x"000000007FFFFFFFFFFFFFFF88888888";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFE0007000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="00000000000F00100010001000040004"
    wait for optime;
    assert (rd_tb = x"00000000000F00100010001000040004")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100001010"; --rot
    rs1_tb <= x"10104E0230200B20023243218F349FB3"; -- shift 33
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF21";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="C79A4FD9880827011810059001192190"
    wait for optime;
    assert (rd_tb = x"C79A4FD9880827011810059001192190")
    	report "Fail " severity failure;
        
    rs1_tb <= x"FFFFFFFFFFFFFFFF0000000000000000"; -- shift 8
    rs2_tb <= x"00000000000000000000000000000008";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    --output = "00FFFFFFFFFFFFFFFF00000000000000"
    wait for optime;
    assert (rd_tb = x"00FFFFFFFFFFFFFFFF00000000000000")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3B000112344321604C"; -- shift 113
    rs2_tb <= x"F0F0F0F0F0F0F0F0F0F0F0F0F0F0F072";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    --output = "35000177828EC000448D10C858130400"
    wait for optime;
    assert (rd_tb = x"35000177828EC000448D10C858130400")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100001011";-- ROTW
    rs1_tb <= x"10104E0230200B20023243218F349FB3"; -- shift 4, 20, 31, 0
    rs2_tb <= x"00000004000000140000001F00000000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="210104E000B20302046486428F349FB3"
    wait for optime;
    assert (rd_tb = x"210104E000B20302046486428F349FB3")
    	report "Fail " severity failure;
    rs1_tb <= x"FFFFFFF2FFFFFFFF00000000F0F0F0F0"; -- shift 8, 6, 26, 16
    rs2_tb <= x"00000008000000060000001A00000010";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    --output = "F2FFFFFFFFFFFFFF00000000F0F0F0F0"
    wait for optime;
    assert (rd_tb = x"F2FFFFFFFFFFFFFF00000000F0F0F0F0")
    	report "Fail " severity failure;
    
--	opcode_tb <= "1100001100"; -- SHLHI
--    rs1_tb <= x"10104E0230200B20023243218F349FB3"; 
--    rs2_tb <= x"00030004000B0006000800010003000F";
--    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
--    -- output ="8080E0200000C8003200864279A08000"
--    wait for optime;
--    assert (rd_tb = x"8080E0200000C8003200864279A08000")
--    	report "Fail " severity failure;
--    rs1_tb <= x"FFFFFFF2F0FFFFFF00000000F0F0F0F0"; 
--    rs2_tb <= x"00000008000000060002000A00000008";
--    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
--    --output = "FFFFF200F0FFFFC000000000F0F0F000"
--    wait for optime;
--    assert (rd_tb = x"FFFFF200F0FFFFC000000000F0F0F000")
--    	report "Fail " severity failure;

	opcode_tb <= "1100001101"; -- SFH
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="F0103A022A4200E50EF130EDCF133F67"
	----------="F0103A022A4200E50EF130EDCF133F67"
    wait for optime;
    assert (rd_tb = x"F0103A022A4200E50EF130EDCF133F67")
    	report "Fail " severity failure;
    
    
	opcode_tb <= "1100001110"; --SFHS
    rs1_tb <= x"1000D40005DE0A3B834112344321604C";
    rs2_tb <= x"00100E0230200B207232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="F0103A022A4200E57FFF30EDCF138000"
    wait for optime;
    assert (rd_tb = x"F0103A022A4200E57FFF30EDCF138000")
    	report "Fail " severity failure;
        
    
	opcode_tb <= "1100001111"; --XOR
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00100E0230200B200232432112349FB3";
    rs3_tb <= x"00000000000000000000000000000000";
    -- output ="1010DA0235FE011BF17351155115FFFF"
    wait for optime;
    assert (rd_tb = x"1010DA0235FE011BF17351155115FFFF")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF341123443789ABC";
    rs2_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="EFFF2BFFFA21F5C40CBEEDCBBC876543"
    wait for optime;
    assert (rd_tb = x"EFFF2BFFFA21F5C40CBEEDCBBC876543")
    	report "Fail " severity failure;
        
    rs1_tb <= x"1000D40005DE0A3BF34112344321604C";
    rs2_tb <= x"00000000000000000000000000000000";
    rs3_tb <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    -- output ="1000D40005DE0A3BF34112344321604C"
    wait for optime;
    assert (rd_tb = x"1000D40005DE0A3BF34112344321604C")
    	report "Fail " severity failure;
        
    
     report "END OF TB";
     std.env.stop;
     end process;
end alu_tb;-- Code your testbench here
