module enc (input clk,rst,
            input [0:127]K,IV,
            input [0:255]M,AD,
            output reg [0:255]C,
            output reg [0:127]Tag
            );
  
reg [0:127]Z0;
reg [0:127]Z1;
reg [0:383]T3;
reg [0:511]T4;
reg [0:767]T6;

reg [0:9]enc_state;//for FSM.
reg b;

wire clk1;

reg [0:127]ADlength;//length of AD in 128 bits.
reg [0:127]Mlength;//length of M in 128 bits.

wire [0:1663]temp1;
reg rst_RT3;
reg rst_RT4;
reg rst_RT6;
reg [0:383]T3_RT3;
reg [0:127]M0_RT3;
reg [0:511]T4_RT4;
reg [0:127]M1_RT4;
reg [0:767]T6_RT6;
reg [0:127]M2_RT6;

assign clk1=clk;  //to remove clk warning "remain unconnected in the top module."

RT3 m1 (clk,rst_RT3,T3_RT3,M0_RT3,Z0,temp1[0:383]);
RT4 m2 (clk,rst_RT4,T4_RT4,M1_RT4,Z0,temp1[384:895]);
RT6 m3 (clk,rst_RT6,T6_RT6,M2_RT6,Z0,temp1[896:1663]);

always @ (posedge clk)begin
if(rst)begin
  Z0=128'h428a2f98d728ae227137449123ef65cd;
  Z1=128'hb5c0fbcfec4d3b2fe9b5dba58189dbbc;
  b=1'b1;
  enc_state=0;
end
else begin
  case (enc_state)
    0: begin
      //initialization step.
      T3[0:127]=K;
      T3[128:255]=K;
      T3[256:383]=IV;
      
      T4[0:127]=K;
      T4[128:255]=K;
      T4[256:383]=IV;
      T4[348:511]=Z0;
            
      T6[0:127]=K;
      T6[128:255]=K;
      T6[256:383]=IV;
      T6[348:511]=Z1;
      T6[512:639]=0;
      T6[640:767]=0;
      
      if(b)begin
        enc_state=10'b0000000001;
      end
      else begin
        enc_state=10'b0000000000;
      end 
    end
    
    1: begin  //update 1 of initialization
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
		
		
      
      if(b)begin
        enc_state=10'b0000000010;
      end
      else begin
        enc_state=10'b0000000001;
      end
    end
    
    2: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0000000011;
      end
      else begin
        enc_state=10'b0000000010;
      end
    end
    
    3: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0000000100;
      end
      else begin
        enc_state=10'b0000000011;
      end
    end
    
    4: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0000000101;
      end
      else begin
        enc_state=10'b0000000100;
      end
    end
    
    5: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0000000110;
      end
      else begin
        enc_state=10'b0000000101;
      end
    end
    
    6: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0000000111;
      end
      else begin
        enc_state=10'b0000000110;
      end
    end
    
    7: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0000001000;
      end
      else begin
        enc_state=10'b0000000111;
      end
    end
    
    8: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0000001001;
      end
      else begin
        enc_state=10'b0000001000;
      end
    end
    
    9: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0000001010;
      end
      else begin
        enc_state=10'b0000001001;
      end
    end
    
    10: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0000001011;
      end
      else begin
        enc_state=10'b0000001010;
      end
    end
    
    11: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0000001100;
      end
      else begin
        enc_state=10'b0000001011;
      end
    end
    
    12: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0000001101;
      end
      else begin
        enc_state=10'b0000001100;
      end
    end
    
    13: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0000001110;
      end
      else begin
        enc_state=10'b0000001101;
      end
    end
    
    14: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0000001111;
      end
      else begin
        enc_state=10'b0000001110;
      end
    end
    
    15: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0000010000;
      end
      else begin
        enc_state=10'b0000001111;
      end
    end
    
    16: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0000010001;
      end
      else begin
        enc_state=10'b0000010000;
      end
    end
    
    17: begin
     
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 1 over initialization
      
      if(b)begin
        enc_state=10'b0000010010;
      end
      else begin
        enc_state=10'b0000010001;
      end
    end
    
    18: begin //update 2 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0000010011;
      end
      else begin
        enc_state=10'b0000010010;
      end
    end
    
    19: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0000010100;
      end
      else begin
        enc_state=10'b0000010011;
      end
    end
    
    20: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0000010101;
      end
      else begin
        enc_state=10'b0000010100;
      end
    end
    
    21: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0000010110;
      end
      else begin
        enc_state=10'b0000010101;
      end
    end
    
    22: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0000010111;
      end
      else begin
        enc_state=10'b0000010110;
      end
    end
    
    23: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0000011000;
      end
      else begin
        enc_state=10'b0000010111;
      end
    end
    
    24: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0000011001;
      end
      else begin
        enc_state=10'b0000011000;
      end
    end
    
    25: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0000011010;
      end
      else begin
        enc_state=10'b0000011001;
      end
    end
    
    26: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0000011011;
      end
      else begin
        enc_state=10'b0000011010;
      end
    end
    
    27: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0000011100;
      end
      else begin
        enc_state=10'b0000011011;
      end
    end
    
    28: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0000011101;
      end
      else begin
        enc_state=10'b0000011100;
      end
    end
    
    29: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0000011110;
      end
      else begin
        enc_state=10'b0000011101;
      end
    end
    
    30: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0000011111;
      end
      else begin
        enc_state=10'b0000011110;
      end
    end
    
    31: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0000100000;
      end
      else begin
        enc_state=10'b0000011111;
      end
    end
    
    32: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0000100001;
      end
      else begin
        enc_state=10'b0000100000;
      end
    end
    
    33: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0000100010;
      end
      else begin
        enc_state=10'b0000100001;
      end
    end
    
    34: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 2 over initialization
      
      if(b)begin
        enc_state=10'b0000100011;
      end
      else begin
        enc_state=10'b0000100010;
      end
    end
    
    35: begin //update 3 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0000100100;
      end
      else begin
        enc_state=10'b0000100011;
      end
    end
    
    36: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0000100101;
      end
      else begin
        enc_state=10'b0000100100;
      end
    end
    
    37: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0000100110;
      end
      else begin
        enc_state=10'b0000100101;
      end
    end
    
    38: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0000100111;
      end
      else begin
        enc_state=10'b0000100110;
      end
    end
    
    39: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0000101001;
      end
      else begin
        enc_state=10'b0000100111;
      end
    end
    
    40: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0000101001;
      end
      else begin
        enc_state=10'b0000101001;
      end
    end
    
    41: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0000101010;
      end
      else begin
        enc_state=10'b0000101001;
      end
    end
    
    42: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0000101011;
      end
      else begin
        enc_state=10'b0000101010;
      end
    end
    
    43: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0000101100;
      end
      else begin
        enc_state=10'b0000101011;
      end
    end
    
    44: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0000101101;
      end
      else begin
        enc_state=10'b0000101100;
      end
    end
    
    45: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0000101110;
      end
      else begin
        enc_state=10'b0000101101;
      end
    end
    
    46: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0000101111;
      end
      else begin
        enc_state=10'b0000101110;
      end
    end
    
    47: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0000110000;
      end
      else begin
        enc_state=10'b0000101111;
      end
    end
    
    48: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0000110001;
      end
      else begin
        enc_state=10'b0000110000;
      end
    end
    
    49: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0000110010;
      end
      else begin
        enc_state=10'b0000110001;
      end
    end
    
    50: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0000110011;
      end
      else begin
        enc_state=10'b0000110010;
      end
    end
    
    51: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 3 over initialization
      
      if(b)begin
        enc_state=10'b0000110100;
      end
      else begin
        enc_state=10'b0000110011;
      end
    end
    
    52: begin //update 4 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0000110101;
      end
      else begin
        enc_state=10'b0000110100;
      end
    end
    
    53: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0000110110;
      end
      else begin
        enc_state=10'b0000110101;
      end
    end
    
    54: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0000110111;
      end
      else begin
        enc_state=10'b0000110110;
      end
    end
    
    55: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0000111000;
      end
      else begin
        enc_state=10'b0000110111;
      end
    end
    
    56: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0000111001;
      end
      else begin
        enc_state=10'b0000111000;
      end
    end
    
    57: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0000111010;
      end
      else begin
        enc_state=10'b0000111001;
      end
    end
    
    58: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0000111011;
      end
      else begin
        enc_state=10'b0000111010;
      end
    end
    
    59: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0000111100;
      end
      else begin
        enc_state=10'b0000111011;
      end
    end
    
    60: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0000111101;
      end
      else begin
        enc_state=10'b0000111100;
      end
    end
    
    61: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0000111110;
      end
      else begin
        enc_state=10'b0000111101;
      end
    end
    
    62: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0000111111;
      end
      else begin
        enc_state=10'b0000111110;
      end
    end
    
    63: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0001000000;
      end
      else begin
        enc_state=10'b0000111111;
      end
    end
    
    64: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0001000001;
      end
      else begin
        enc_state=10'b0001000000;
      end
    end
    
    65: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0001000010;
      end
      else begin
        enc_state=10'b0001000001;
      end
    end
    
    66: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0001000011;
      end
      else begin
        enc_state=10'b0001000010;
      end
    end
    
    67: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0001000100;
      end
      else begin
        enc_state=10'b0001000011;
      end
    end
    
    68: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 4 over initialization
      
      if(b)begin
        enc_state=10'b0001000101;
      end
      else begin
        enc_state=10'b0001000100;
      end
    end
    
    69: begin //update 5 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0001000110;
      end
      else begin
        enc_state=10'b0001000101;
      end
    end
    
    70: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0001000111;
      end
      else begin
        enc_state=10'b0001000110;
      end
    end
    
    71: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0001001000;
      end
      else begin
        enc_state=10'b0001000111;
      end
    end
    
    72: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0001001001;
      end
      else begin
        enc_state=10'b0001001000;
      end
    end
    
    73: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0001001010;
      end
      else begin
        enc_state=10'b0001001001;
      end
    end
    
    74: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0001001011;
      end
      else begin
        enc_state=10'b0001001010;
      end
    end
    
    75: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0001001100;
      end
      else begin
        enc_state=10'b0001001011;
      end
    end
    
    76: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0001001101;
      end
      else begin
        enc_state=10'b0001001100;
      end
    end
    
    77: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0001001110;
      end
      else begin
        enc_state=10'b0001001101;
      end
    end
    
    78: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0001001111;
      end
      else begin
        enc_state=10'b0001001110;
      end
    end
    
    79: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0001010000;
      end
      else begin
        enc_state=10'b0001001111;
      end
    end
    
    80: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0001010001;
      end
      else begin
        enc_state=10'b0001010000;
      end
    end
    
    81: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0001010010;
      end
      else begin
        enc_state=10'b0001010001;
      end
    end
    
    82: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0001010011;
      end
      else begin
        enc_state=10'b0001010010;
      end
    end
    
    83: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0001010100;
      end
      else begin
        enc_state=10'b0001010011;
      end
    end
    
    84: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0001010101;
      end
      else begin
        enc_state=10'b0001010100;
      end
    end
    
    85: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 5 over initialization
      
      if(b)begin
        enc_state=10'b0001010110;
      end
      else begin
        enc_state=10'b0001010101;
      end
    end
    
    86: begin //update 6 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0001010111;
      end
      else begin
        enc_state=10'b0001010110;
      end
    end
    
    87: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0001011000;
      end
      else begin
        enc_state=10'b0001010111;
      end
    end
    
    88: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0001011001;
      end
      else begin
        enc_state=10'b0001011000;
      end
    end
    
    89: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0001011010;
      end
      else begin
        enc_state=10'b0001011001;
      end
    end
    
    90: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0001011011;
      end
      else begin
        enc_state=10'b0001011010;
      end
    end
    
    91: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0001011100;
      end
      else begin
        enc_state=10'b0001011011;
      end
    end
    
    92: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0001011101;
      end
      else begin
        enc_state=10'b0001011100;
      end
    end
    
    93: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0001011110;
      end
      else begin
        enc_state=10'b0001011101;
      end
    end
    
    94: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0001011111;
      end
      else begin
        enc_state=10'b0001011110;
      end
    end
    
    95: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0001100000;
      end
      else begin
        enc_state=10'b0001011111;
      end
    end
    
    96: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0001100001;
      end
      else begin
        enc_state=10'b0001100000;
      end
    end
    
    97: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0001100010;
      end
      else begin
        enc_state=10'b0001100001;
      end
    end
    
    98: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0001100011;
      end
      else begin
        enc_state=10'b0001100010;
      end
    end
    
    99: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0001100100;
      end
      else begin
        enc_state=10'b0001100011;
      end
    end
    
    100: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0001100101;
      end
      else begin
        enc_state=10'b0001100100;
      end
    end
    
    101: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0001100110;
      end
      else begin
        enc_state=10'b0001100101;
      end
    end
    
    102: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 6 over initialization
      
      if(b)begin
        enc_state=10'b0001100111;
      end
      else begin
        enc_state=10'b0001100110;
      end
    end
    
    103: begin //update 7 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0001101000;
      end
      else begin
        enc_state=10'b0001100111;
      end
    end
    
    104: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0001101001;
      end
      else begin
        enc_state=10'b0001101000;
      end
    end
    
    105: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0001101010;
      end
      else begin
        enc_state=10'b0001101001;
      end
    end
    
    106: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0001101011;
      end
      else begin
        enc_state=10'b0001101010;
      end
    end
    
    107: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0001101100;
      end
      else begin
        enc_state=10'b0001101011;
      end
    end
    
    108: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0001101101;
      end
      else begin
        enc_state=10'b0001101100;
      end
    end
    
    109: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0001101110;
      end
      else begin
        enc_state=10'b0001101101;
      end
    end
    
    110: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0001101111;
      end
      else begin
        enc_state=10'b0001101110;
      end
    end
    
    111: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0001110000;
      end
      else begin
        enc_state=10'b0001101111;
      end
    end
    
    112: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0001110001;
      end
      else begin
        enc_state=10'b0001110000;
      end
    end
    
    113: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0001110010;
      end
      else begin
        enc_state=10'b0001110001;
      end
    end
    
    114: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0001110011;
      end
      else begin
        enc_state=10'b0001110010;
      end
    end
    
    115: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0001110100;
      end
      else begin
        enc_state=10'b0001110011;
      end
    end
    
    116: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0001110101;
      end
      else begin
        enc_state=10'b0001110100;
      end
    end
    
    117: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0001110110;
      end
      else begin
        enc_state=10'b0001110101;
      end
    end
    
    118: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0001110111;
      end
      else begin
        enc_state=10'b0001110110;
      end
    end
    
    119: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 7 over initialization
      
      if(b)begin
        enc_state=10'b0001111000;
      end
      else begin
        enc_state=10'b0001110111;
      end
    end
    
    120: begin //update 8 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0001111001;
      end
      else begin
        enc_state=10'b0001111000;
      end
    end
    
    121: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0001111010;
      end
      else begin
        enc_state=10'b0001111001;
      end
    end
    
    122: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0001111011;
      end
      else begin
        enc_state=10'b0001111010;
      end
    end
    
    123: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0001111100;
      end
      else begin
        enc_state=10'b0001111011;
      end
    end
    
    124: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0001111101;
      end
      else begin
        enc_state=10'b0001111100;
      end
    end
    
    125: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0001111110;
      end
      else begin
        enc_state=10'b0001111101;
      end
    end
    
    126: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0001111111;
      end
      else begin
        enc_state=10'b0001111110;
      end
    end
    
    127: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0010000000;
      end
      else begin
        enc_state=10'b0001111111;
      end
    end
    
    128: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0010000001;
      end
      else begin
        enc_state=10'b0010000000;
      end
    end
    
    129: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0010000010;
      end
      else begin
        enc_state=10'b0010000001;
      end
    end
    
    130: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0010000011;
      end
      else begin
        enc_state=10'b0010000010;
      end
    end
    
    131: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0010000100;
      end
      else begin
        enc_state=10'b0010000011;
      end
    end
    
    132: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0010000101;
      end
      else begin
        enc_state=10'b0010000100;
      end
    end
    
    133: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0010000110;
      end
      else begin
        enc_state=10'b0010000101;
      end
    end
    
    134: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0010000111;
      end
      else begin
        enc_state=10'b0010000110;
      end
    end
    
    135: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0010001000;
      end
      else begin
        enc_state=10'b0010000111;
      end
    end
    
    136: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 8 over initialization
      
      if(b)begin
        enc_state=10'b0010001001;
      end
      else begin
        enc_state=10'b0010001000;
      end
    end
    
     137: begin //update 9 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0010001010;
      end
      else begin
        enc_state=10'b0010001001;
      end
    end
    
    138: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0010001011;
      end
      else begin
        enc_state=10'b0010001010;
      end
    end
    
    139: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0010001100;
      end
      else begin
        enc_state=10'b0010001011;
      end
    end
    
    140: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0010001101;
      end
      else begin
        enc_state=10'b0010001100;
      end
    end
    
    141: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0010001110;
      end
      else begin
        enc_state=10'b0010001101;
      end
    end
    
    142: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0010001111;
      end
      else begin
        enc_state=10'b0010001110;
      end
    end
    
    143: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0010010000;
      end
      else begin
        enc_state=10'b0010001111;
      end
    end
    
    144: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0010010001;
      end
      else begin
        enc_state=10'b0010010000;
      end
    end
    
    145: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0010010010;
      end
      else begin
        enc_state=10'b0010010001;
      end
    end
    
    146: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0010010011;
      end
      else begin
        enc_state=10'b0010010010;
      end
    end
    
    147: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0010010100;
      end
      else begin
        enc_state=10'b0010010011;
      end
    end
    
    148: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0010010101;
      end
      else begin
        enc_state=10'b0010010100;
      end
    end
    
    149: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0010010110;
      end
      else begin
        enc_state=10'b0010010101;
      end
    end
    
    150: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0010010111;
      end
      else begin
        enc_state=10'b0010010110;
      end
    end
    
    151: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0010011000;
      end
      else begin
        enc_state=10'b0010010111;
      end
    end
    
    152: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0010011001;
      end
      else begin
        enc_state=10'b0010011000;
      end
    end
    
    153: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 9 over initialization
      
      if(b)begin
        enc_state=10'b0010011010;
      end
      else begin
        enc_state=10'b0010011001;
      end
    end
    
    154: begin //update 10 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0010011011;
      end
      else begin
        enc_state=10'b0010011010;
      end
    end
    
    155: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0010011100;
      end
      else begin
        enc_state=10'b0010011011;
      end
    end
    
    156: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0010011101;
      end
      else begin
        enc_state=10'b0010011100;
      end
    end
    
    157: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0010011110;
      end
      else begin
        enc_state=10'b0010011101;
      end
    end
    
    158: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0010011111;
      end
      else begin
        enc_state=10'b0010011110;
      end
    end
    
    159: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0010100000;
      end
      else begin
        enc_state=10'b0010011111;
      end
    end
    
    160: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0010100001;
      end
      else begin
        enc_state=10'b0010100000;
      end
    end
    
    161: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0010100010;
      end
      else begin
        enc_state=10'b0010100001;
      end
    end
    
    162: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0010100011;
      end
      else begin
        enc_state=10'b0010100010;
      end
    end
    
    163: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0010100100;
      end
      else begin
        enc_state=10'b0010100011;
      end
    end
    
    164: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0010100101;
      end
      else begin
        enc_state=10'b0010100100;
      end
    end
    
    165: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0010100110;
      end
      else begin
        enc_state=10'b0010100101;
      end
    end
    
    166: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0010100111;
      end
      else begin
        enc_state=10'b0010100110;
      end
    end
    
    167: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0010101000;
      end
      else begin
        enc_state=10'b0010100111;
      end
    end
    
    168: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0010101001;
      end
      else begin
        enc_state=10'b0010101000;
      end
    end
    
    169: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0010101010;
      end
      else begin
        enc_state=10'b0010101001;
      end
    end
    
    170: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 10 over initialization
      
      if(b)begin
        enc_state=10'b0010101011;
      end
      else begin
        enc_state=10'b0010101010;
      end
    end
    
    171: begin //update 11 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0010101100;
      end
      else begin
        enc_state=10'b0010101011;
      end
    end
    
    172: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0010101101;
      end
      else begin
        enc_state=10'b0010101100;
      end
    end
    
    173: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0010101110;
      end
      else begin
        enc_state=10'b0010101101;
      end
    end
    
    174: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0010101111;
      end
      else begin
        enc_state=10'b0010101110;
      end
    end
    
    175: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0010110000;
      end
      else begin
        enc_state=10'b0010101111;
      end
    end
    
    176: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0010110001;
      end
      else begin
        enc_state=10'b0010110000;
      end
    end
    
    177: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0010110010;
      end
      else begin
        enc_state=10'b0010110001;
      end
    end
    
    178: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0010110011;
      end
      else begin
        enc_state=10'b0010110010;
      end
    end
    
    179: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0010110100;
      end
      else begin
        enc_state=10'b0010110011;
      end
    end
    
    180: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0010110101;
      end
      else begin
        enc_state=10'b0010110100;
      end
    end
    
    181: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0010110110;
      end
      else begin
        enc_state=10'b0010110101;
      end
    end
    
    182: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0010110111;
      end
      else begin
        enc_state=10'b0010110110;
      end
    end
    
    183: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0010111000;
      end
      else begin
        enc_state=10'b0010110111;
      end
    end
    
    184: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0010111001;
      end
      else begin
        enc_state=10'b0010111000;
      end
    end
    
    185: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0010111010;
      end
      else begin
        enc_state=10'b0010111001;
      end
    end
    
    186: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0010111011;
      end
      else begin
        enc_state=10'b0010111010;
      end
    end
    
    187: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 11 over initialization
      
      if(b)begin
        enc_state=10'b0010111100;
      end
      else begin
        enc_state=10'b0010111011;
      end
    end
    
    188: begin //update 12 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0010111101;
      end
      else begin
        enc_state=10'b0010111100;
      end
    end
    
    189: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0010111110;
      end
      else begin
        enc_state=10'b0010111101;
      end
    end
    
    190: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0010111111;
      end
      else begin
        enc_state=10'b0010111110;
      end
    end
    
    191: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0011000000;
      end
      else begin
        enc_state=10'b0010111111;
      end
    end
    
    192: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0011000001;
      end
      else begin
        enc_state=10'b0011000000;
      end
    end
    
    193: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0011000010;
      end
      else begin
        enc_state=10'b0011000001;
      end
    end
    
    194: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0011000011;
      end
      else begin
        enc_state=10'b0011000010;
      end
    end
    
    195: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0011000100;
      end
      else begin
        enc_state=10'b0011000011;
      end
    end
    
    196: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0011000101;
      end
      else begin
        enc_state=10'b0011000100;
      end
    end
    
    197: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0011000110;
      end
      else begin
        enc_state=10'b0011000101;
      end
    end
    
    198: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0011000111;
      end
      else begin
        enc_state=10'b0011000110;
      end
    end
    
    199: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0011001000;
      end
      else begin
        enc_state=10'b0011000111;
      end
    end
    
    200: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0011001001;
      end
      else begin
        enc_state=10'b0011001000;
      end
    end
    
    201: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0011001010;
      end
      else begin
        enc_state=10'b0011001001;
      end
    end
    
    202: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0011001011;
      end
      else begin
        enc_state=10'b0011001010;
      end
    end
    
    203: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0011001100;
      end
      else begin
        enc_state=10'b0011001011;
      end
    end
    
    204: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 12 over initialization
      
      if(b)begin
        enc_state=10'b0011001101;
      end
      else begin
        enc_state=10'b0011001100;
      end
    end
    
    205: begin //update 13 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0011001110;
      end
      else begin
        enc_state=10'b0011001101;
      end
    end
    
    206: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0011001111;
      end
      else begin
        enc_state=10'b0011001110;
      end
    end
    
    207: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0011010000;
      end
      else begin
        enc_state=10'b0011001111;
      end
    end
    
    208: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0011010001;
      end
      else begin
        enc_state=10'b0011010000;
      end
    end
    
    209: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0011010010;
      end
      else begin
        enc_state=10'b0011010001;
      end
    end
    
    210: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0011010011;
      end
      else begin
        enc_state=10'b0011010010;
      end
    end
    
    211: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0011010100;
      end
      else begin
        enc_state=10'b0011010011;
      end
    end
    
    212: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0011010101;
      end
      else begin
        enc_state=10'b0011010100;
      end
    end
    
    213: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0011010110;
      end
      else begin
        enc_state=10'b0011010101;
      end
    end
    
    214: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0011010111;
      end
      else begin
        enc_state=10'b0011010110;
      end
    end
    
    215: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0011011000;
      end
      else begin
        enc_state=10'b0011010111;
      end
    end
    
    216: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0011011001;
      end
      else begin
        enc_state=10'b0011011000;
      end
    end
    
    217: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0011011010;
      end
      else begin
        enc_state=10'b0011011001;
      end
    end
    
    218: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0011011011;
      end
      else begin
        enc_state=10'b0011011010;
      end
    end
    
    219: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0011011100;
      end
      else begin
        enc_state=10'b0011011011;
      end
    end
    
    220: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0011011101;
      end
      else begin
        enc_state=10'b0011011100;
      end
    end
    
    221: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 13 over initialization
      
      if(b)begin
        enc_state=10'b0011011110;
      end
      else begin
        enc_state=10'b0011011101;
      end
    end
    
    222: begin //update 14 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0011011111;
      end
      else begin
        enc_state=10'b0011011110;
      end
    end
    
    223: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0011100000;
      end
      else begin
        enc_state=10'b0011011111;
      end
    end
    
    224: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0011100001;
      end
      else begin
        enc_state=10'b0011100000;
      end
    end
    
    225: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0011100010;
      end
      else begin
        enc_state=10'b0011100001;
      end
    end
    
    226: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0011100011;
      end
      else begin
        enc_state=10'b0011100010;
      end
    end
    
    227: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0011100100;
      end
      else begin
        enc_state=10'b0011100011;
      end
    end
    
    228: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0011100101;
      end
      else begin
        enc_state=10'b0011100100;
      end
    end
    
    229: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0011100110;
      end
      else begin
        enc_state=10'b0011100101;
      end
    end
    
    230: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0011100111;
      end
      else begin
        enc_state=10'b0011100110;
      end
    end
    
    231: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0011101000;
      end
      else begin
        enc_state=10'b0011100111;
      end
    end
    
    232: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0011101001;
      end
      else begin
        enc_state=10'b0011101000;
      end
    end
    
    233: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0011101010;
      end
      else begin
        enc_state=10'b0011101001;
      end
    end
    
    234: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0011101011;
      end
      else begin
        enc_state=10'b0011101010;
      end
    end
    
    235: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0011101100;
      end
      else begin
        enc_state=10'b0011101011;
      end
    end
    
    236: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0011101101;
      end
      else begin
        enc_state=10'b0011101100;
      end
    end
    
    237: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0011101110;
      end
      else begin
        enc_state=10'b0011101101;
      end
    end
    
    238: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 14 over initialization
      
      if(b)begin
        enc_state=10'b0011101111;
      end
      else begin
        enc_state=10'b0011101110;
      end
    end
    
    239: begin //update 15 of initialization
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z0;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z1;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z0;
      
      if(b)begin
        enc_state=10'b0011110000;
      end
      else begin
        enc_state=10'b0011101111;
      end
    end
    
    240: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0011110001;
      end
      else begin
        enc_state=10'b0011110000;
      end
    end
    
    241: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0011110010;
      end
      else begin
        enc_state=10'b0011110001;
      end
    end
    
    242: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0011110011;
      end
      else begin
        enc_state=10'b0011110010;
      end
    end
    
    243: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0011110100;
      end
      else begin
        enc_state=10'b0011110011;
      end
    end
    
    244: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0011110101;
      end
      else begin
        enc_state=10'b0011110100;
      end
    end
    
    245: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0011110110;
      end
      else begin
        enc_state=10'b0011110101;
      end
    end
    
    246: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0011110111;
      end
      else begin
        enc_state=10'b0011110110;
      end
    end
    
    247: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0011111000;
      end
      else begin
        enc_state=10'b0011110111;
      end
    end
    
    248: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0011111001;
      end
      else begin
        enc_state=10'b0011111000;
      end
    end
    
    249: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0011111010;
      end
      else begin
        enc_state=10'b0011111001;
      end
    end
    
    250: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0011111011;
      end
      else begin
        enc_state=10'b0011111010;
      end
    end
    
    251: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0011111100;
      end
      else begin
        enc_state=10'b0011111011;
      end
    end
    
    252: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0011111101;
      end
      else begin
        enc_state=10'b0011111100;
      end
    end
    
    253: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0011111110;
      end
      else begin
        enc_state=10'b0011111101;
      end
    end
    
    254: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0011111111;
      end
      else begin
        enc_state=10'b0011111110;
      end
    end
    
    255: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 15 over initialization
      
      if(b)begin
        enc_state=10'b0100000000;
      end
      else begin
        enc_state=10'b0011111111;
      end
    end
    //initialixzation stage over.
    
    256: begin
      //processing associated data step.
      ADlength=AD[0:127] ^ AD[128:255];
      
      if(b)begin
        enc_state=10'b0100000001;
      end
      else begin
        enc_state=10'b0100000000;
      end 
    end
    
    257: begin  //update 1 of initialization
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=AD[0:127];
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=AD[128:255];
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=ADlength;
      
      if(b)begin
        enc_state=10'b0100000010;
      end
      else begin
        enc_state=10'b0100000001;
      end
    end
    
    258: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0100000011;
      end
      else begin
        enc_state=10'b0100000010;
      end
    end
    
    259: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0100000100;
      end
      else begin
        enc_state=10'b0100000011;
      end
    end
    
    260: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0100000101;
      end
      else begin
        enc_state=10'b0100000100;
      end
    end
    
    261: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0100000110;
      end
      else begin
        enc_state=10'b0100000101;
      end
    end
    
    262: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0100000111;
      end
      else begin
        enc_state=10'b0100000110;
      end
    end
    
    263: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0100001000;
      end
      else begin
        enc_state=10'b0100000111;
      end
    end
    
    264: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0100001001;
      end
      else begin
        enc_state=10'b0100001000;
      end
    end
    
    265: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0100001010;
      end
      else begin
        enc_state=10'b0100001001;
      end
    end
    
    266: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0100001011;
      end
      else begin
        enc_state=10'b0100001010;
      end
    end
    
    267: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0100001100;
      end
      else begin
        enc_state=10'b0100001011;
      end
    end
    
    268: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0100001101;
      end
      else begin
        enc_state=10'b0100001100;
      end
    end
    
    269: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0100001110;
      end
      else begin
        enc_state=10'b0100001101;
      end
    end
    
    270: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0100001111;
      end
      else begin
        enc_state=10'b0100001110;
      end
    end
    
    271: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0100010000;
      end
      else begin
        enc_state=10'b0100001111;
      end
    end
    
    272: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0100010001;
      end
      else begin
        enc_state=10'b0100010000;
      end
    end
    
    273: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //processing associated data over
      
      Mlength=M[0:127] ^ M[128:255];//to be used in next stage of encryption
      
      if(b)begin
        enc_state=10'b0100010010;
      end
      else begin
        enc_state=10'b0100010001;
      end
    end
    
    274: begin //encryption stage.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=M[0:127];
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=M[128:255];
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Mlength;
      
      if(b)begin
        enc_state=10'b0100010011;
      end
      else begin
        enc_state=10'b0100010010;
      end
    end
    
    275: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0100010100;
      end
      else begin
        enc_state=10'b0100010011;
      end
    end
    
    276: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0100010101;
      end
      else begin
        enc_state=10'b0100010100;
      end
    end
    
    277: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0100010110;
      end
      else begin
        enc_state=10'b0100010101;
      end
    end
    
    278: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0100010111;
      end
      else begin
        enc_state=10'b0100010110;
      end
    end
    
    279: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0100011000;
      end
      else begin
        enc_state=10'b0100010111;
      end
    end
    
    280: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0100011001;
      end
      else begin
        enc_state=10'b0100011000;
      end
    end
    
    281: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0100011010;
      end
      else begin
        enc_state=10'b0100011001;
      end
    end
    
    282: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0100011011;
      end
      else begin
        enc_state=10'b0100011010;
      end
    end
    
    283: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0100011100;
      end
      else begin
        enc_state=10'b0100011011;
      end
    end
    
    284: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0100011101;
      end
      else begin
        enc_state=10'b0100011100;
      end
    end
    
    285: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0100011110;
      end
      else begin
        enc_state=10'b0100011101;
      end
    end
    
    286: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0100011111;
      end
      else begin
        enc_state=10'b0100011110;
      end
    end
    
    287: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0100100000;
      end
      else begin
        enc_state=10'b0100011111;
      end
    end
    
    288: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0100100001;
      end
      else begin
        enc_state=10'b0100100000;
      end
    end
    
    289: begin  //empty 14
      
      //for this stage, assigning temp1 to T3,T4 and T6.
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      
      if(b)begin
        enc_state=10'b0100100010;
      end
      else begin
        enc_state=10'b0100100001;
      end
    end
    
    290: begin
      
      
      C[0:127]=T3[0:127] ^ T3[256:383] ^ T4[128:255] ^ (T6[384:511] & T4[384:511]);
      C[128:255]=T6[0:127] ^ T4[256:383] ^ T3[128:255] ^ (T6[640:767] & T3[256:383]);
      
      
      //encryption stage over
      
      ADlength=128'h0000000000000000;
      Mlength=128'h0000000000000000;
      //used for tag production.
      
      if(b)begin
        enc_state=10'b0100100011;  
      end
      else begin
        enc_state=10'b0100100010;
      end
    end
    
    
    291: begin //tag production stage.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=ADlength;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Mlength;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=ADlength ^ Mlength;
      
      if(b)begin
        enc_state=10'b0100100100;
      end
      else begin
        enc_state=10'b0100100011;
      end
    end
    
    292: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0100100101;
      end
      else begin
        enc_state=10'b0100100100;
      end
    end
    
    293: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0100100110;
      end
      else begin
        enc_state=10'b0100100101;
      end
    end
    
    294: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0100100111;
      end
      else begin
        enc_state=10'b0100100110;
      end
    end
    
    295: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0100101001;
      end
      else begin
        enc_state=10'b0100100111;
      end
    end
    
    296: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0100101001;
      end
      else begin
        enc_state=10'b0100101001;
      end
    end
    
    297: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0100101010;
      end
      else begin
        enc_state=10'b0100101001;
      end
    end
    
    298: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0100101011;
      end
      else begin
        enc_state=10'b0100101010;
      end
    end
    
    299: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0100101100;
      end
      else begin
        enc_state=10'b0100101011;
      end
    end
    
    300: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0100101101;
      end
      else begin
        enc_state=10'b0100101100;
      end
    end
    
    301: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0100101110;
      end
      else begin
        enc_state=10'b0100101101;
      end
    end
    
    302: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0100101111;
      end
      else begin
        enc_state=10'b0100101110;
      end
    end
    
    303: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0100110000;
      end
      else begin
        enc_state=10'b0100101111;
      end
    end
    
    304: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0100110001;
      end
      else begin
        enc_state=10'b0100110000;
      end
    end
    
    305: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0100110010;
      end
      else begin
        enc_state=10'b0100110001;
      end
    end
    
    306: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0100110011;
      end
      else begin
        enc_state=10'b0100110010;
      end
    end
    
    307: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update before loop is over.
      
      if(b)begin
        enc_state=10'b0100110100;
      end
      else begin
        enc_state=10'b0100110011;
      end
    end
    
    
    308: begin //update 1 of loop in tag production stage.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0100110101;
      end
      else begin
        enc_state=10'b0100110100;
      end
    end
    
    309: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0100110110;
      end
      else begin
        enc_state=10'b0100110101;
      end
    end
    
    310: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0100110111;
      end
      else begin
        enc_state=10'b0100110110;
      end
    end
    
    311: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0100111000;
      end
      else begin
        enc_state=10'b0100110111;
      end
    end
    
    312: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0100111001;
      end
      else begin
        enc_state=10'b0100111000;
      end
    end
    
    313: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0100111010;
      end
      else begin
        enc_state=10'b0100111001;
      end
    end
    
    314: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0100111011;
      end
      else begin
        enc_state=10'b0100111010;
      end
    end
    
    315: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0100111100;
      end
      else begin
        enc_state=10'b0100111011;
      end
    end
    
    316: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0100111101;
      end
      else begin
        enc_state=10'b0100111100;
      end
    end
    
    317: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0100111110;
      end
      else begin
        enc_state=10'b0100111101;
      end
    end
    
    318: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0100111111;
      end
      else begin
        enc_state=10'b0100111110;
      end
    end
    
    319: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0101000000;
      end
      else begin
        enc_state=10'b0100111111;
      end
    end
    
    320: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0101000001;
      end
      else begin
        enc_state=10'b0101000000;
      end
    end
    
    321: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0101000010;
      end
      else begin
        enc_state=10'b0101000001;
      end
    end
    
    322: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0101000011;
      end
      else begin
        enc_state=10'b0101000010;
      end
    end
    
    323: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0101000100;
      end
      else begin
        enc_state=10'b0101000011;
      end
    end
    
    324: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 1 over.
      
      if(b)begin
        enc_state=10'b0101000101;
      end
      else begin
        enc_state=10'b0101000100;
      end
    end
    
    325: begin //update 2 of loop in tag production stage.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0101000110;
      end
      else begin
        enc_state=10'b0101000101;
      end
    end
    
    326: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0101000111;
      end
      else begin
        enc_state=10'b0101000110;
      end
    end
    
    327: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0101001000;
      end
      else begin
        enc_state=10'b0101000111;
      end
    end
    
    328: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0101001001;
      end
      else begin
        enc_state=10'b0101001000;
      end
    end
    
    329: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0101001010;
      end
      else begin
        enc_state=10'b0101001001;
      end
    end
    
    330: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0101001011;
      end
      else begin
        enc_state=10'b0101001010;
      end
    end
    
    331: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0101001100;
      end
      else begin
        enc_state=10'b0101001011;
      end
    end
    
    332: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0101001101;
      end
      else begin
        enc_state=10'b0101001100;
      end
    end
    
    333: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0101001110;
      end
      else begin
        enc_state=10'b0101001101;
      end
    end
    
    334: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0101001111;
      end
      else begin
        enc_state=10'b0101001110;
      end
    end
    
    335: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0101010000;
      end
      else begin
        enc_state=10'b0101001111;
      end
    end
    
    336: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0101010001;
      end
      else begin
        enc_state=10'b0101010000;
      end
    end
    
    337: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0101010010;
      end
      else begin
        enc_state=10'b0101010001;
      end
    end
    
    338: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0101010011;
      end
      else begin
        enc_state=10'b0101010010;
      end
    end
    
    339: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0101010100;
      end
      else begin
        enc_state=10'b0101010011;
      end
    end
    
    340: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0101010101;
      end
      else begin
        enc_state=10'b0101010100;
      end
    end
    
    341: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 2 over.
      
      if(b)begin
        enc_state=10'b0101010110;
      end
      else begin
        enc_state=10'b0101010101;
      end
    end
    
    342: begin //update 3 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0101010111;
      end
      else begin
        enc_state=10'b0101010110;
      end
    end
    
    343: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0101011000;
      end
      else begin
        enc_state=10'b0101010111;
      end
    end
    
    344: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0101011001;
      end
      else begin
        enc_state=10'b0101011000;
      end
    end
    
    345: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0101011010;
      end
      else begin
        enc_state=10'b0101011001;
      end
    end
    
    346: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0101011011;
      end
      else begin
        enc_state=10'b0101011010;
      end
    end
    
    347: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0101011100;
      end
      else begin
        enc_state=10'b0101011011;
      end
    end
    
    348: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0101011101;
      end
      else begin
        enc_state=10'b0101011100;
      end
    end
    
    349: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0101011110;
      end
      else begin
        enc_state=10'b0101011101;
      end
    end
    
    350: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0101011111;
      end
      else begin
        enc_state=10'b0101011110;
      end
    end
    
    351: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0101100000;
      end
      else begin
        enc_state=10'b0101011111;
      end
    end
    
    352: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0101100001;
      end
      else begin
        enc_state=10'b0101100000;
      end
    end
    
    353: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0101100010;
      end
      else begin
        enc_state=10'b0101100001;
      end
    end
    
    354: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0101100011;
      end
      else begin
        enc_state=10'b0101100010;
      end
    end
    
    355: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0101100100;
      end
      else begin
        enc_state=10'b0101100011;
      end
    end
    
    356: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0101100101;
      end
      else begin
        enc_state=10'b0101100100;
      end
    end
    
    357: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0101100110;
      end
      else begin
        enc_state=10'b0101100101;
      end
    end
    
    358: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 3 over.
      
      if(b)begin
        enc_state=10'b0101100111;
      end
      else begin
        enc_state=10'b0101100110;
      end
    end
    
    
    359: begin //update 4 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0101101000;
      end
      else begin
        enc_state=10'b0101100111;
      end
    end
    
    360: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0101101001;
      end
      else begin
        enc_state=10'b0101101000;
      end
    end
    
    361: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0101101010;
      end
      else begin
        enc_state=10'b0101101001;
      end
    end
    
    362: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0101101011;
      end
      else begin
        enc_state=10'b0101101010;
      end
    end
    
    363: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0101101100;
      end
      else begin
        enc_state=10'b0101101011;
      end
    end
    
    364: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0101101101;
      end
      else begin
        enc_state=10'b0101101100;
      end
    end
    
    365: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0101101110;
      end
      else begin
        enc_state=10'b0101101101;
      end
     end
    
    366: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0101101111;
      end
      else begin
        enc_state=10'b0101101110;
      end
    end
    
    367: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0101110000;
      end
      else begin
        enc_state=10'b0101101111;
      end
    end
    
    368: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0101110001;
      end
      else begin
        enc_state=10'b0101110000;
      end
    end
    
    369: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0101110010;
      end
      else begin
        enc_state=10'b0101110001;
      end
    end
    
    370: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0101110011;
      end
      else begin
        enc_state=10'b0101110010;
      end
    end
    
    371: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0101110100;
      end
      else begin
        enc_state=10'b0101110011;
      end
    end
    
    372: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0101110101;
      end
      else begin
        enc_state=10'b0101110100;
      end
    end
    
    373: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0101110110;
      end
      else begin
        enc_state=10'b0101110101;
      end
    end
    
    374: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0101110111;
      end
      else begin
        enc_state=10'b0101110110;
      end
    end
    
    375: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 4 over.
      
      if(b)begin
        enc_state=10'b0101111000;
      end
      else begin
        enc_state=10'b0101110111;
      end
    end
    
    376: begin //update 5 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0101111001;
      end
      else begin
        enc_state=10'b0101111000;
      end
    end
    
    377: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0101111010;
      end
      else begin
        enc_state=10'b0101111001;
      end
    end
    
    378: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0101111011;
      end
      else begin
        enc_state=10'b0101111010;
      end
    end
    
    379: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0101111100;
      end
      else begin
        enc_state=10'b0101111011;
      end
    end
    
    380: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0101111101;
      end
      else begin
        enc_state=10'b0101111100;
      end
    end
    
    381: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0101111110;
      end
      else begin
        enc_state=10'b0101111101;
      end
    end
    
    382: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0101111111;
      end
      else begin
        enc_state=10'b0101111110;
      end
    end
    
    383: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0110000000;
      end
      else begin
        enc_state=10'b0101111111;
      end
    end
    
    384: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0110000001;
      end
      else begin
        enc_state=10'b0110000000;
      end
    end
    
    385: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0110000010;
      end
      else begin
        enc_state=10'b0110000001;
      end
    end
    
    386: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0110000011;
      end
      else begin
        enc_state=10'b0110000010;
      end
    end
    
    387: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0110000100;
      end
      else begin
        enc_state=10'b0110000011;
      end
    end
    
    388: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0110000101;
      end
      else begin
        enc_state=10'b0110000100;
      end
    end
    
    389: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0110000110;
      end
      else begin
        enc_state=10'b0110000101;
      end
    end
    
    390: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0110000111;
      end
      else begin
        enc_state=10'b0110000110;
      end
    end
    
    391: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0110001000;
      end
      else begin
        enc_state=10'b0110000111;
      end
    end
    
    392: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 5 over.
      
      if(b)begin
        enc_state=10'b0110001001;
      end
      else begin
        enc_state=10'b0110001000;
      end
     end
    
     393: begin //update 6 of loop for tag production. 
           
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0110001010;
      end
      else begin
        enc_state=10'b0110001001;
      end
    end
    
    394: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0110001011;
      end
      else begin
        enc_state=10'b0110001010;
      end
    end
    
    395: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0110001100;
      end
      else begin
        enc_state=10'b0110001011;
      end
    end
    
    396: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0110001101;
      end
      else begin
        enc_state=10'b0110001100;
      end
    end
    
    397: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0110001110;
      end
      else begin
        enc_state=10'b0110001101;
      end
    end
    
    398: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0110001111;
      end
      else begin
        enc_state=10'b0110001110;
      end
    end
    
    399: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0110010000;
      end
      else begin
        enc_state=10'b0110001111;
      end
    end
    
    400: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0110010001;
      end
      else begin
        enc_state=10'b0110010000;
      end
    end
    
    401: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0110010010;
      end
      else begin
        enc_state=10'b0110010001;
      end
    end
    
    402: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0110010011;
      end
      else begin
        enc_state=10'b0110010010;
      end
    end
    
    403: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0110010100;
      end
      else begin
        enc_state=10'b0110010011;
      end
    end
    
    404: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0110010101;
      end
      else begin
        enc_state=10'b0110010100;
      end
    end
    
    405: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0110010110;
      end
      else begin
        enc_state=10'b0110010101;
      end
    end
    
    406: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0110010111;
      end
      else begin
        enc_state=10'b0110010110;
      end
    end
    
    407: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0110011000;
      end
      else begin
        enc_state=10'b0110010111;
      end
    end
    
    408: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0110011001;
      end
      else begin
        enc_state=10'b0110011000;
      end
    end
    
    409: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 6 over.
            
      if(b)begin
        enc_state=10'b0110011010;
      end
      else begin
        enc_state=10'b0110011001;
      end
    end
    
    410: begin //update 7 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0110011011;
      end
      else begin
        enc_state=10'b0110011010;
      end
    end
    
    411: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0110011100;
      end
      else begin
        enc_state=10'b0110011011;
      end
    end
    
    412: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0110011101;
      end
      else begin
        enc_state=10'b0110011100;
      end
    end
    
    413: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0110011110;
      end
      else begin
        enc_state=10'b0110011101;
      end
    end
    
    414: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0110011111;
      end
      else begin
        enc_state=10'b0110011110;
      end
    end
    
    415: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0110100000;
      end
      else begin
        enc_state=10'b0110011111;
      end
    end
    
    416: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0110100001;
      end
      else begin
        enc_state=10'b0110100000;
      end
    end
    
    417: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0110100010;
      end
      else begin
        enc_state=10'b0110100001;
      end
    end
    
    418: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0110100011;
      end
      else begin
        enc_state=10'b0110100010;
      end
    end
    
    419: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0110100100;
      end
      else begin
        enc_state=10'b0110100011;
      end
    end
    
    420: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0110100101;
      end
      else begin
        enc_state=10'b0110100100;
      end
    end
    
    421: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0110100110;
      end
      else begin
        enc_state=10'b0110100101;
      end
    end
    
    422: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0110100111;
      end
      else begin
        enc_state=10'b0110100110;
      end
    end
    
    423: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0110101000;
      end
      else begin
        enc_state=10'b0110100111;
      end
    end
    
    424: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0110101001;
      end
      else begin
        enc_state=10'b0110101000;
      end
    end
    
    425: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0110101010;
      end
      else begin
        enc_state=10'b0110101001;
      end
    end
    
    426: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 7 over.
      
      if(b)begin
        enc_state=10'b0110101011;
      end
      else begin
        enc_state=10'b0110101010;
      end
    end
    
    427: begin //update 8 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0110101100;
      end
      else begin
        enc_state=10'b0110101011;
      end
    end
    
    428: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0110101101;
      end
      else begin
        enc_state=10'b0110101100;
      end
    end
    
    429: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0110101110;
      end
      else begin
        enc_state=10'b0110101101;
      end
    end
    
    430: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0110101111;
      end
      else begin
        enc_state=10'b0110101110;
      end
    end
    
    431: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0110110000;
      end
      else begin
        enc_state=10'b0110101111;
      end
    end
    
    432: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0110110001;
      end
      else begin
        enc_state=10'b0110110000;
      end
    end
    
    433: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0110110010;
      end
      else begin
        enc_state=10'b0110110001;
      end
    end
    
    434: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0110110011;
      end
      else begin
        enc_state=10'b0110110010;
      end
    end
    
    435: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0110110100;
      end
      else begin
        enc_state=10'b0110110011;
      end
    end
    
    436: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0110110101;
      end
      else begin
        enc_state=10'b0110110100;
      end
    end
    
    437: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0110110110;
      end
      else begin
        enc_state=10'b0110110101;
      end
    end
    
    438: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0110110111;
      end
      else begin
        enc_state=10'b0110110110;
      end
    end
    
    439: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0110111000;
      end
      else begin
        enc_state=10'b0110110111;
      end
    end
    
    440: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0110111001;
      end
      else begin
        enc_state=10'b0110111000;
      end
    end
    
    441: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0110111010;
      end
      else begin
        enc_state=10'b0110111001;
      end
    end
    
    442: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0110111011;
      end
      else begin
        enc_state=10'b0110111010;
      end
    end
    
    443: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 8 over.
      
      if(b)begin
        enc_state=10'b0110111100;
      end
      else begin
        enc_state=10'b0110111011;
      end
    end
    
    444: begin //update 9 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0110111101;
      end
      else begin
        enc_state=10'b0110111100;
      end
    end
    
    445: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0110111110;
      end
      else begin
        enc_state=10'b0110111101;
      end
    end
    
    446: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0110111111;
      end
      else begin
        enc_state=10'b0110111110;
      end
    end
    
    447: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0111000000;
      end
      else begin
        enc_state=10'b0110111111;
      end
    end
    
    448: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0111000001;
      end
      else begin
        enc_state=10'b0111000000;
      end
    end
    
    449: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0111000010;
      end
      else begin
        enc_state=10'b0111000001;
      end
    end
    
    450: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0111000011;
      end
      else begin
        enc_state=10'b0111000010;
      end
    end
    
    451: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0111000100;
      end
      else begin
        enc_state=10'b0111000011;
      end
    end
    
    452: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0111000101;
      end
      else begin
        enc_state=10'b0111000100;
      end
    end
    
    453: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0111000110;
      end
      else begin
        enc_state=10'b0111000101;
      end
    end
    
    454: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0111000111;
      end
      else begin
        enc_state=10'b0111000110;
      end
    end
    
    455: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0111001000;
      end
      else begin
        enc_state=10'b0111000111;
      end
    end
    
    456: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0111001001;
      end
      else begin
        enc_state=10'b0111001000;
      end
    end
    
    457: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0111001010;
      end
      else begin
        enc_state=10'b0111001001;
      end
    end
    
    458: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0111001011;
      end
      else begin
        enc_state=10'b0111001010;
      end
    end
    
    459: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0111001100;
      end
      else begin
        enc_state=10'b0111001011;
      end
    end
    
    460: begin
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 9 over.
      
      if(b)begin
        enc_state=10'b0111001101;
      end
      else begin
        enc_state=10'b0111001100;
      end
    end
    
    461: begin //update 10 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0111001110;
      end
      else begin
        enc_state=10'b0111001101;
      end
    end
    
    462: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0111001111;
      end
      else begin
        enc_state=10'b0111001110;
      end
    end
    
    463: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0111010000;
      end
      else begin
        enc_state=10'b0111001111;
      end
    end
    
    464: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0111010001;
      end
      else begin
        enc_state=10'b0111010000;
      end
    end
    
    465: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0111010010;
      end
      else begin
        enc_state=10'b0111010001;
      end
    end
    
    466: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0111010011;
      end
      else begin
        enc_state=10'b0111010010;
      end
    end
    
    467: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0111010100;
      end
      else begin
        enc_state=10'b0111010011;
      end
    end
    
    468: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0111010101;
      end
      else begin
        enc_state=10'b0111010100;
      end
    end
    
    469: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0111010110;
      end
      else begin
        enc_state=10'b0111010101;
      end
    end
    
    470: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0111010111;
      end
      else begin
        enc_state=10'b0111010110;
      end
    end
    
    471: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0111011000;
      end
      else begin
        enc_state=10'b0111010111;
      end
    end
    
    472: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0111011001;
      end
      else begin
        enc_state=10'b0111011000;
      end
    end
    
    473: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0111011010;
      end
      else begin
        enc_state=10'b0111011001;
      end
    end
    
    474: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0111011011;
      end
      else begin
        enc_state=10'b0111011010;
      end
    end
    
    475: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0111011100;
      end
      else begin
        enc_state=10'b0111011011;
      end
    end
    
    476: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0111011101;
      end
      else begin
        enc_state=10'b0111011100;
      end
    end
    
    477: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 10 over.
      
      if(b)begin
        enc_state=10'b0111011110;
      end
      else begin
        enc_state=10'b0111011101;
      end
    end
    
    478: begin //update 11 of loop for tag production.
         
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0111011111;
      end
      else begin
        enc_state=10'b0111011110;
      end
    end
    
    479: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0111100000;
      end
      else begin
        enc_state=10'b0111011111;
      end
    end
    
    480: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0111100001;
      end
      else begin
        enc_state=10'b0111100000;
      end
    end
    
    481: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0111100010;
      end
      else begin
        enc_state=10'b0111100001;
      end
    end
    
    482: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0111100011;
      end
      else begin
        enc_state=10'b0111100010;
      end
    end
    
    483: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0111100100;
      end
      else begin
        enc_state=10'b0111100011;
      end
    end
    
    484: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0111100101;
      end
      else begin
        enc_state=10'b0111100100;
      end
    end
    
    485: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0111100110;
      end
      else begin
        enc_state=10'b0111100101;
      end
    end
    
    486: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0111100111;
      end
      else begin
        enc_state=10'b0111100110;
      end
    end
    
    487: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0111101000;
      end
      else begin
        enc_state=10'b0111100111;
      end
    end
    
    488: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0111101001;
      end
      else begin
        enc_state=10'b0111101000;
      end
    end
    
    489: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0111101010;
      end
      else begin
        enc_state=10'b0111101001;
      end
    end
    
    490: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0111101011;
      end
      else begin
        enc_state=10'b0111101010;
      end
    end
    
    491: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0111101100;
      end
      else begin
        enc_state=10'b0111101011;
      end
    end
    
    492: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0111101101;
      end
      else begin
        enc_state=10'b0111101100;
      end
    end
    
    493: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0111101110;
      end
      else begin
        enc_state=10'b0111101101;
      end
    end
    
    494: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 11 over.
      
      if(b)begin
        enc_state=10'b0111101111;
      end
      else begin
        enc_state=10'b0111101110;
      end
    end
    
    495: begin //update 12 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b0111110000;
      end
      else begin
        enc_state=10'b0111101111;
      end
    end
    
    496: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b0111110001;
      end
      else begin
        enc_state=10'b0111110000;
      end
    end
    
    497: begin  //empty 1
      
      if(b)begin
        enc_state=10'b0111110010;
      end
      else begin
        enc_state=10'b0111110001;
      end
    end
    
    498: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b0111110011;
      end
      else begin
        enc_state=10'b0111110010;
      end
    end
    
    499: begin  //empty 3
      
      if(b)begin
        enc_state=10'b0111110100;
      end
      else begin
        enc_state=10'b0111110011;
      end
    end
    
    500: begin  //empty 4
      
      if(b)begin
        enc_state=10'b0111110101;
      end
      else begin
        enc_state=10'b0111110100;
      end
    end
    
    501: begin  //empty 5
      
      if(b)begin
        enc_state=10'b0111110110;
      end
      else begin
        enc_state=10'b0111110101;
      end
    end
    
    502: begin  //empty 6
      
      if(b)begin
        enc_state=10'b0111110111;
      end
      else begin
        enc_state=10'b0111110110;
      end
    end
    
    503: begin  //empty 7
      
      if(b)begin
        enc_state=10'b0111111000;
      end
      else begin
        enc_state=10'b0111110111;
      end
    end
    
    504: begin  //empty 8
      
      if(b)begin
        enc_state=10'b0111111001;
      end
      else begin
        enc_state=10'b0111111000;
      end
    end
    
    505: begin  //empty 9
      
      if(b)begin
        enc_state=10'b0111111010;
      end
      else begin
        enc_state=10'b0111111001;
      end
    end
    
    506: begin  //empty 10
      
      if(b)begin
        enc_state=10'b0111111011;
      end
      else begin
        enc_state=10'b0111111010;
      end
    end
    
    507: begin  //empty 11
      
      if(b)begin
        enc_state=10'b0111111100;
      end
      else begin
        enc_state=10'b0111111011;
      end
    end
    
    508: begin  //empty 12
      
      if(b)begin
        enc_state=10'b0111111101;
      end
      else begin
        enc_state=10'b0111111100;
      end
    end
    
    509: begin  //empty 13
      
      if(b)begin
        enc_state=10'b0111111110;
      end
      else begin
        enc_state=10'b0111111101;
      end
    end
    
    510: begin  //empty 14
      
      if(b)begin
        enc_state=10'b0111111111;
      end
      else begin
        enc_state=10'b0111111110;
      end
    end
    
    511: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 12 over.
         
      if(b)begin
        enc_state=10'b1000000000;
      end
      else begin
        enc_state=10'b0111111111;
      end
    end
    
    
    512: begin
      
      if(b)begin
        enc_state=10'b1000000001;
      end
      else begin
        enc_state=10'b1000000000;
      end 
    end
    
    513: begin  //update 13 of loop for tag production.
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1000000010;
      end
      else begin
        enc_state=10'b1000000001;
      end
    end
    
    514: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1000000011;
      end
      else begin
        enc_state=10'b1000000010;
      end
    end
    
    515: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1000000100;
      end
      else begin
        enc_state=10'b1000000011;
      end
    end
    
    516: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1000000101;
      end
      else begin
        enc_state=10'b1000000100;
      end
    end
    
    517: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1000000110;
      end
      else begin
        enc_state=10'b1000000101;
      end
    end
    
    518: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1000000111;
      end
      else begin
        enc_state=10'b1000000110;
      end
    end
    
    519: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1000001000;
      end
      else begin
        enc_state=10'b1000000111;
      end
    end
    
    520: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1000001001;
      end
      else begin
        enc_state=10'b1000001000;
      end
    end
    
    521: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1000001010;
      end
      else begin
        enc_state=10'b1000001001;
      end
    end
    
    522: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1000001011;
      end
      else begin
        enc_state=10'b1000001010;
      end
    end
    
    523: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1000001100;
      end
      else begin
        enc_state=10'b1000001011;
      end
    end
    
    524: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1000001101;
      end
      else begin
        enc_state=10'b1000001100;
      end
    end
    
    525: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1000001110;
      end
      else begin
        enc_state=10'b1000001101;
      end
    end
    
    526: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1000001111;
      end
      else begin
        enc_state=10'b1000001110;
      end
    end
    
    527: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1000010000;
      end
      else begin
        enc_state=10'b1000001111;
      end
    end
    
    528: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1000010001;
      end
      else begin
        enc_state=10'b1000010000;
      end
    end
    
    529: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 13 over.
      
      if(b)begin
        enc_state=10'b1000010010;
      end
      else begin
        enc_state=10'b1000010001;
      end
    end
    
    530: begin //update 14 of loop for tag production.
          
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1000010011;
      end
      else begin
        enc_state=10'b1000010010;
      end
    end
    
    531: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1000010100;
      end
      else begin
        enc_state=10'b1000010011;
      end
    end
    
    532: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1000010101;
      end
      else begin
        enc_state=10'b1000010100;
      end
    end
    
    533: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1000010110;
      end
      else begin
        enc_state=10'b1000010101;
      end
    end
    
    534: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1000010111;
      end
      else begin
        enc_state=10'b1000010110;
      end
    end
    
    535: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1000011000;
      end
      else begin
        enc_state=10'b1000010111;
      end
    end
    
    536: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1000011001;
      end
      else begin
        enc_state=10'b1000011000;
      end
    end
    
    537: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1000011010;
      end
      else begin
        enc_state=10'b1000011001;
      end
    end
    
    538: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1000011011;
      end
      else begin
        enc_state=10'b1000011010;
      end
    end
    
    539: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1000011100;
      end
      else begin
        enc_state=10'b1000011011;
      end
    end
    
    540: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1000011101;
      end
      else begin
        enc_state=10'b1000011100;
      end
    end
    
    541: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1000011110;
      end
      else begin
        enc_state=10'b1000011101;
      end
    end
    
    542: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1000011111;
      end
      else begin
        enc_state=10'b1000011110;
      end
    end
    
    543: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1000100000;
      end
      else begin
        enc_state=10'b1000011111;
      end
    end
    
    544: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1000100001;
      end
      else begin
        enc_state=10'b1000100000;
      end
    end
    
    545: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1000100010;
      end
      else begin
        enc_state=10'b1000100001;
      end
    end
    
    546: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 14 over.
      
      if(b)begin
        enc_state=10'b1000100011;
      end
      else begin
        enc_state=10'b1000100010;
      end
    end
    
    547: begin //update 15 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1000100100;
      end
      else begin
        enc_state=10'b1000100011;
      end
    end
    
    548: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1000100101;
      end
      else begin
        enc_state=10'b1000100100;
      end
    end
    
    549: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1000100110;
      end
      else begin
        enc_state=10'b1000100101;
      end
    end
    
    550: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1000100111;
      end
      else begin
        enc_state=10'b1000100110;
      end
    end
    
    551: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1000101001;
      end
      else begin
        enc_state=10'b1000100111;
      end
    end
    
    552: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1000101001;
      end
      else begin
        enc_state=10'b1000101001;
      end
    end
    
    553: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1000101010;
      end
      else begin
        enc_state=10'b1000101001;
      end
    end
    
    554: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1000101011;
      end
      else begin
        enc_state=10'b1000101010;
      end
    end
    
    555: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1000101100;
      end
      else begin
        enc_state=10'b1000101011;
      end
    end
    
    556: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1000101101;
      end
      else begin
        enc_state=10'b1000101100;
      end
    end
    
    557: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1000101110;
      end
      else begin
        enc_state=10'b1000101101;
      end
    end
    
    558: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1000101111;
      end
      else begin
        enc_state=10'b1000101110;
      end
    end
    
    559: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1000110000;
      end
      else begin
        enc_state=10'b1000101111;
      end
    end
    
    560: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1000110001;
      end
      else begin
        enc_state=10'b1000110000;
      end
    end
    
    561: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1000110010;
      end
      else begin
        enc_state=10'b1000110001;
      end
    end
    
    562: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1000110011;
      end
      else begin
        enc_state=10'b1000110010;
      end
    end
    
    563: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 15 over.
      
      if(b)begin
        enc_state=10'b1000110100;
      end
      else begin
        enc_state=10'b1000110011;
      end
    end
    
    564: begin //update 16 of loop for tag production. 
        
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1000110101;
      end
      else begin
        enc_state=10'b1000110100;
      end
    end
    
    565: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1000110110;
      end
      else begin
        enc_state=10'b1000110101;
      end
    end
    
    566: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1000110111;
      end
      else begin
        enc_state=10'b1000110110;
      end
    end
    
    567: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1000111000;
      end
      else begin
        enc_state=10'b1000110111;
      end
    end
    
    568: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1000111001;
      end
      else begin
        enc_state=10'b1000111000;
      end
    end
    
    569: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1000111010;
      end
      else begin
        enc_state=10'b1000111001;
      end
    end
    
    570: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1000111011;
      end
      else begin
        enc_state=10'b1000111010;
      end
    end
    
    571: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1000111100;
      end
      else begin
        enc_state=10'b1000111011;
      end
    end
    
    572: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1000111101;
      end
      else begin
        enc_state=10'b1000111100;
      end
    end
    
    573: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1000111110;
      end
      else begin
        enc_state=10'b1000111101;
      end
    end
    
    574: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1000111111;
      end
      else begin
        enc_state=10'b1000111110;
      end
    end
    
    575: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1001000000;
      end
      else begin
        enc_state=10'b1000111111;
      end
    end
    
    576: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1001000001;
      end
      else begin
        enc_state=10'b1001000000;
      end
    end
    
    577: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1001000010;
      end
      else begin
        enc_state=10'b1001000001;
      end
    end
    
    578: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1001000011;
      end
      else begin
        enc_state=10'b1001000010;
      end
    end
    
    579: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1001000100;
      end
      else begin
        enc_state=10'b1001000011;
      end
    end
    
    580: begin
     
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 16 over.
            
      if(b)begin
        enc_state=10'b1001000101;
      end
      else begin
        enc_state=10'b1001000100;
      end
    end
    
    581: begin //update 17 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1001000110;
      end
      else begin
        enc_state=10'b1001000101;
      end
    end
    
    582: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1001000111;
      end
      else begin
        enc_state=10'b1001000110;
      end
    end
    
    583: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1001001000;
      end
      else begin
        enc_state=10'b1001000111;
      end
    end
    
    584: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1001001001;
      end
      else begin
        enc_state=10'b1001001000;
      end
    end
    
    585: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1001001010;
      end
      else begin
        enc_state=10'b1001001001;
      end
    end
    
    586: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1001001011;
      end
      else begin
        enc_state=10'b1001001010;
      end
    end
    
    587: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1001001100;
      end
      else begin
        enc_state=10'b1001001011;
      end
    end
    
    588: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1001001101;
      end
      else begin
        enc_state=10'b1001001100;
      end
    end
    
    589: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1001001110;
      end
      else begin
        enc_state=10'b1001001101;
      end
    end
    
    590: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1001001111;
      end
      else begin
        enc_state=10'b1001001110;
      end
    end
    
    591: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1001010000;
      end
      else begin
        enc_state=10'b1001001111;
      end
    end
    
    592: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1001010001;
      end
      else begin
        enc_state=10'b1001010000;
      end
    end
    
    593: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1001010010;
      end
      else begin
        enc_state=10'b1001010001;
      end
    end
    
    594: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1001010011;
      end
      else begin
        enc_state=10'b1001010010;
      end
    end
    
    595: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1001010100;
      end
      else begin
        enc_state=10'b1001010011;
      end
    end
    
    596: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1001010101;
      end
      else begin
        enc_state=10'b1001010100;
      end
    end
    
    597: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 17 over.
      
      if(b)begin
        enc_state=10'b1001010110;
      end
      else begin
        enc_state=10'b1001010101;
      end
    end
    
    598: begin //update 18 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1001010111;
      end
      else begin
        enc_state=10'b1001010110;
      end
    end
    
    599: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1001011000;
      end
      else begin
        enc_state=10'b1001010111;
      end
    end
    
    600: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1001011001;
      end
      else begin
        enc_state=10'b1001011000;
      end
    end
    
    601: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1001011010;
      end
      else begin
        enc_state=10'b1001011001;
      end
    end
    
    602: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1001011011;
      end
      else begin
        enc_state=10'b1001011010;
      end
    end
    
    603: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1001011100;
      end
      else begin
        enc_state=10'b1001011011;
      end
    end
    
    604: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1001011101;
      end
      else begin
        enc_state=10'b1001011100;
      end
    end
    
    605: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1001011110;
      end
      else begin
        enc_state=10'b1001011101;
      end
    end
    
    606: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1001011111;
      end
      else begin
        enc_state=10'b1001011110;
      end
    end
    
    607: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1001100000;
      end
      else begin
        enc_state=10'b1001011111;
      end
    end
    
    608: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1001100001;
      end
      else begin
        enc_state=10'b1001100000;
      end
    end
    
    609: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1001100010;
      end
      else begin
        enc_state=10'b1001100001;
      end
    end
    
    610: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1001100011;
      end
      else begin
        enc_state=10'b1001100010;
      end
    end
    
    611: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1001100100;
      end
      else begin
        enc_state=10'b1001100011;
      end
    end
    
    612: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1001100101;
      end
      else begin
        enc_state=10'b1001100100;
      end
    end
    
    613: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1001100110;
      end
      else begin
        enc_state=10'b1001100101;
      end
    end
    
    614: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 18 over.
      
      if(b)begin
        enc_state=10'b1001100111;
      end
      else begin
        enc_state=10'b1001100110;
      end
    end
    
    615: begin //update 19 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1001101000;
      end
      else begin
        enc_state=10'b1001100111;
      end
    end
    
    616: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1001101001;
      end
      else begin
        enc_state=10'b1001101000;
      end
    end
    
    617: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1001101010;
      end
      else begin
        enc_state=10'b1001101001;
      end
    end
    
    618: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1001101011;
      end
      else begin
        enc_state=10'b1001101010;
      end
    end
    
    619: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1001101100;
      end
      else begin
        enc_state=10'b1001101011;
      end
    end
    
    620: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1001101101;
      end
      else begin
        enc_state=10'b1001101100;
      end
    end
    
    621: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1001101110;
      end
      else begin
        enc_state=10'b1001101101;
      end
    end
    
    622: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1001101111;
      end
      else begin
        enc_state=10'b1001101110;
      end
    end
    
    623: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1001110000;
      end
      else begin
        enc_state=10'b1001101111;
      end
    end
    
    624: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1001110001;
      end
      else begin
        enc_state=10'b1001110000;
      end
    end
    
    625: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1001110010;
      end
      else begin
        enc_state=10'b1001110001;
      end
    end
    
    626: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1001110011;
      end
      else begin
        enc_state=10'b1001110010;
      end
    end
    
    627: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1001110100;
      end
      else begin
        enc_state=10'b1001110011;
      end
    end
    
    628: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1001110101;
      end
      else begin
        enc_state=10'b1001110100;
      end
    end
    
    629: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1001110110;
      end
      else begin
        enc_state=10'b1001110101;
      end
    end
    
    630: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1001110111;
      end
      else begin
        enc_state=10'b1001110110;
      end
    end
    
    631: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 19 over.
      
      if(b)begin
        enc_state=10'b1001111000;
      end
      else begin
        enc_state=10'b1001110111;
      end
    end
    
    632: begin //update 20 of loop for tag production.
      
      rst_RT3=1'b1;
      T3_RT3=T3;
      M0_RT3=Z1;
      
      rst_RT4=1'b1;
      T4_RT4=T4;
      M1_RT4=Z0;
      
      rst_RT6=1'b1;
      T6_RT6=T6;
      M2_RT6=Z1;
      
      if(b)begin
        enc_state=10'b1001111001;
      end
      else begin
        enc_state=10'b1001111000;
      end
    end
    
    633: begin
      rst_RT3=1'b0;
      
      rst_RT4=1'b0;
      
      rst_RT6=1'b0;
      
      if(b)begin
        enc_state=10'b1001111010;
      end
      else begin
        enc_state=10'b1001111001;
      end
    end
    
    634: begin  //empty 1
      
      if(b)begin
        enc_state=10'b1001111011;
      end
      else begin
        enc_state=10'b1001111010;
      end
    end
    
    635: begin  //empty 2 
      
      if(b)begin
        enc_state=10'b1001111100;
      end
      else begin
        enc_state=10'b1001111011;
      end
    end
    
    636: begin  //empty 3
      
      if(b)begin
        enc_state=10'b1001111101;
      end
      else begin
        enc_state=10'b1001111100;
      end
    end
    
    637: begin  //empty 4
      
      if(b)begin
        enc_state=10'b1001111110;
      end
      else begin
        enc_state=10'b1001111101;
      end
    end
    
    638: begin  //empty 5
      
      if(b)begin
        enc_state=10'b1001111111;
      end
      else begin
        enc_state=10'b1001111110;
      end
    end
    
    639: begin  //empty 6
      
      if(b)begin
        enc_state=10'b1010000000;
      end
      else begin
        enc_state=10'b1001111111;
      end
    end
    
    640: begin  //empty 7
      
      if(b)begin
        enc_state=10'b1010000001;
      end
      else begin
        enc_state=10'b1010000000;
      end
    end
    
    641: begin  //empty 8
      
      if(b)begin
        enc_state=10'b1010000010;
      end
      else begin
        enc_state=10'b1010000001;
      end
    end
    
    642: begin  //empty 9
      
      if(b)begin
        enc_state=10'b1010000011;
      end
      else begin
        enc_state=10'b1010000010;
      end
    end
    
    643: begin  //empty 10
      
      if(b)begin
        enc_state=10'b1010000100;
      end
      else begin
        enc_state=10'b1010000011;
      end
    end
    
    644: begin  //empty 11
      
      if(b)begin
        enc_state=10'b1010000101;
      end
      else begin
        enc_state=10'b1010000100;
      end
    end
    
    645: begin  //empty 12
      
      if(b)begin
        enc_state=10'b1010000110;
      end
      else begin
        enc_state=10'b1010000101;
      end
    end
    
    646: begin  //empty 13
      
      if(b)begin
        enc_state=10'b1010000111;
      end
      else begin
        enc_state=10'b1010000110;
      end
    end
    
    647: begin  //empty 14
      
      if(b)begin
        enc_state=10'b1010001000;
      end
      else begin
        enc_state=10'b1010000111;
      end
    end
    
    648: begin
      
      T3=temp1[0:383];
      T4=temp1[384:895];
      T6=temp1[896:1663];
      //update 20 over.
      
      if(b)begin
        enc_state=10'b1010001001;
      end
      else begin
        enc_state=10'b1010001000;
      end
    end
    
     649: begin //final step of tag production stage.
      
      Tag=T3[0:127] ^ T3[128:255] ^ T3[256:383] ^ T4[0:127] ^ T4[128:255] ^ T4[256:383] ^ T4[384:511] ^ T6[0:127] ^ T6[128:255] ^ T6[256:383] ^ T6[384:511] ^ T6[512:639] ^ T6[640:767];
      
		
		
      if(b)begin
        enc_state=10'b1010001010;
      end
      else begin
        enc_state=10'b1010001001;
      end
    end
    
    650: begin
      
      //last stste of Encryption.
      if(b)begin
        enc_state=10'b1010001010;
      end
      else begin
        enc_state=10'b1010001010;
      end
    end
  
  endcase  
  
end
end  
  
  
endmodule
