`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:08:47 08/25/2015 
// Design Name: 
// Module Name:    aes_128 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module aes_128(
    input clk,rst,keyless,
    input [0:127] ip,key,
    
    output reg [0:127] op
    );
   
reg [0:31]aes_matrix0;
reg [0:31]aes_matrix1;
reg [0:31]aes_matrix2;
reg [0:31]aes_matrix3;
//2d araay not supported in sensitivity list, error + warnings generated.

//reg [0:127]ip_reg;	//can be later removed if aes128 used as function inside tiaoxin-346
reg [0:127]op_reg;	//can be later removed if aes128 used as function inside tiaoxin-346
//registers having input

wire [0:127]subbyte0=128'h637c777bf26b6fc53001672bfed7ab76;
wire [0:127]subbyte1=128'hca82c97dfa5947f0add4a2af9ca472c0;
wire [0:127]subbyte2=128'hb7fd9326363ff7cc34a5e5f171d83115;
wire [0:127]subbyte3=128'h04c723c31896059a071280e2eb27b275;
wire [0:127]subbyte4=128'h09832c1a1b6e5aa0523bd6b329e32f84;
wire [0:127]subbyte5=128'h53d100ed20fcb15b6acbbe394a4c58cf;
wire [0:127]subbyte6=128'hd0efaafb434d338545f9027f503c9fa8;
wire [0:127]subbyte7=128'h51a3408f929d38f5bcb6da2110fff3d2;
wire [0:127]subbyte8=128'hcd0c13ec5f974417c4a77e3d645d1973;
wire [0:127]subbyte9=128'h60814fdc222a908846eeb814de5e0bdb;
wire [0:127]subbytea=128'he0323a0a4906245cc2d3ac629195e479;
wire [0:127]subbyteb=128'he7c8376d8dd54ea96c56f4ea657aae08;
wire [0:127]subbytec=128'hba78252e1ca6b4c6e8dd741f4bbd8b8a;
wire [0:127]subbyted=128'h703eb5664803f60e613557b986c11d9e;
wire [0:127]subbytee=128'he1f8981169d98e949b1e87e9ce5528df;
wire [0:127]subbytef=128'h8ca1890dbfe6426841992d0fb054bb16;

function [0:31]subbyte;
  input [0:31]aes_matrix;
  reg [0:7]a; reg [0:3]a1; reg [0:3]a2;
  reg [0:127]b1;
  integer i;
  begin
    for (i=0;i<4;i=i+1)begin
     case (i)
      0: begin
         a=aes_matrix[0:7];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[0:7]=b1[0:7];
           1: subbyte[0:7]=b1[8:15];
           2: subbyte[0:7]=b1[16:23];
           3: subbyte[0:7]=b1[24:31];
           4: subbyte[0:7]=b1[32:39];
           5: subbyte[0:7]=b1[40:47];
           6: subbyte[0:7]=b1[48:55];
           7: subbyte[0:7]=b1[56:63];
           8: subbyte[0:7]=b1[64:71];
           9: subbyte[0:7]=b1[72:79];
           4'ha: subbyte[0:7]=b1[80:87];
           4'hb: subbyte[0:7]=b1[88:95];
           4'hc: subbyte[0:7]=b1[96:103];
           4'hd: subbyte[0:7]=b1[104:111];
           4'he: subbyte[0:7]=b1[112:119];
           4'hf: subbyte[0:7]=b1[120:127];
          endcase
       end
       
       1: begin
         a=aes_matrix[8:15];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[8:15]=b1[0:7];
           1: subbyte[8:15]=b1[8:15];
           2: subbyte[8:15]=b1[16:23];
           3: subbyte[8:15]=b1[24:31];
           4: subbyte[8:15]=b1[32:39];
           5: subbyte[8:15]=b1[40:47];
           6: subbyte[8:15]=b1[48:55];
           7: subbyte[8:15]=b1[56:63];
           8: subbyte[8:15]=b1[64:71];
           9: subbyte[8:15]=b1[72:79];
           4'ha: subbyte[8:15]=b1[80:87];
           4'hb: subbyte[8:15]=b1[88:95];
           4'hc: subbyte[8:15]=b1[96:103];
           4'hd: subbyte[8:15]=b1[104:111];
           4'he: subbyte[8:15]=b1[112:119];
           4'hf: subbyte[8:15]=b1[120:127];
          endcase
        end
        
       2: begin
         a=aes_matrix[16:23];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[16:23]=b1[0:7];
           1: subbyte[16:23]=b1[8:15];
           2: subbyte[16:23]=b1[16:23];
           3: subbyte[16:23]=b1[24:31];
           4: subbyte[16:23]=b1[32:39];
           5: subbyte[16:23]=b1[40:47];
           6: subbyte[16:23]=b1[48:55];
           7: subbyte[16:23]=b1[56:63];
           8: subbyte[16:23]=b1[64:71];
           9: subbyte[16:23]=b1[72:79];
           4'ha: subbyte[16:23]=b1[80:87];
           4'hb: subbyte[16:23]=b1[88:95];
           4'hc: subbyte[16:23]=b1[96:103];
           4'hd: subbyte[16:23]=b1[104:111];
           4'he: subbyte[16:23]=b1[112:119];
           4'hf: subbyte[16:23]=b1[120:127];
          endcase
        end
        
       3: begin
         a=aes_matrix[24:31];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[24:31]=b1[0:7];
           1: subbyte[24:31]=b1[8:15];
           2: subbyte[24:31]=b1[16:23];
           3: subbyte[24:31]=b1[24:31];
           4: subbyte[24:31]=b1[32:39];
           5: subbyte[24:31]=b1[40:47];
           6: subbyte[24:31]=b1[48:55];
           7: subbyte[24:31]=b1[56:63];
           8: subbyte[24:31]=b1[64:71];
           9: subbyte[24:31]=b1[72:79];
           4'ha: subbyte[24:31]=b1[80:87];
           4'hb: subbyte[24:31]=b1[88:95];
           4'hc: subbyte[24:31]=b1[96:103];
           4'hd: subbyte[24:31]=b1[104:111];
           4'he: subbyte[24:31]=b1[112:119];
           4'hf: subbyte[24:31]=b1[120:127];
          endcase
        end
      endcase
      
    end
  end
endfunction

//step1 => subbyte operation of complete aes input matrix.
reg [0:31]aes_matrix0_step1;
reg [0:31]aes_matrix1_step1;
reg [0:31]aes_matrix2_step1;
reg [0:31]aes_matrix3_step1;

//set of signal, can be removed later.
//reg control;
reg [0:3]state;
wire b=1;

//function for mix column operation.
function [0:127]mix_col;
  input [0:7]one1,two1,three1,four1,one2,two2,three2,four2,one3,two3,three3,four3,one4,two4,three4,four4;
  reg [0:7]temp1,temp2;
  begin
    //first column of matrix
    temp1=mul_02(one1);
    temp2=mul_03(two1);
    mix_col[0:7]=((temp1 ^ temp2) ^ three1) ^ four1;
    
    temp1=mul_02(two1);
    temp2=mul_03(three1);
    mix_col[8:15]=((one1 ^ temp1) ^ temp2) ^ four1;
    
    temp1=mul_02(three1);
    temp2=mul_03(four1);
    mix_col[16:23]=((one1 ^ two1) ^ temp1) ^ temp2;
    
    temp1=mul_02(four1);
    temp2=mul_03(one1);
    mix_col[24:31]=((temp2 ^ two1) ^ three1) ^ temp1;
    //first 32 bits filled now.
    
    //second column of matrix
    temp1=mul_02(one2);
    temp2=mul_03(two2);
    mix_col[32:39]=((temp1 ^ temp2) ^ three2) ^ four2;
    
    temp1=mul_02(two2);
    temp2=mul_03(three2);
    mix_col[40:47]=((one2 ^ temp1) ^ temp2) ^ four2;
    
    temp1=mul_02(three2);
    temp2=mul_03(four2);
    mix_col[48:55]=((one2 ^ two2) ^ temp1) ^ temp2;
    
    temp1=mul_02(four2);
    temp2=mul_03(one2);
    mix_col[56:63]=((temp2 ^ two2) ^ three2) ^ temp1;
    //total 64 bits filled.
    
    //third column processing
    temp1=mul_02(one3);
    temp2=mul_03(two3);
    mix_col[64:71]=((temp1 ^ temp2) ^ three3) ^ four3;
    
    temp1=mul_02(two3);
    temp2=mul_03(three3);
    mix_col[72:79]=((one3 ^ temp1) ^ temp2) ^ four3;
    
    temp1=mul_02(three3);
    temp2=mul_03(four3);
    mix_col[80:87]=((one3 ^ two3) ^ temp1) ^ temp2;
    
    temp1=mul_02(four3);
    temp2=mul_03(one3);
    mix_col[88:95]=((temp2 ^ two3) ^ three3) ^ temp1;
    //total 96 bits filled.
    
    //fourth column processing
    temp1=mul_02(one4);
    temp2=mul_03(two4);
    mix_col[96:103]=((temp1 ^ temp2) ^ three4) ^ four4;
    
    temp1=mul_02(two4);
    temp2=mul_03(three4);
    mix_col[104:111]=((one4 ^ temp1) ^ temp2) ^ four4;
    
    temp1=mul_02(three4);
    temp2=mul_03(four4);
    mix_col[112:119]=((one4 ^ two4) ^ temp1) ^ temp2;
    
    temp1=mul_02(four4);
    temp2=mul_03(one4);
    mix_col[120:127]=((temp2 ^ two4) ^ three4) ^ temp1;
 
  end
endfunction

//function multiply by 02
function [0:7]mul_02;
  input [0:7]value_02;
  reg [0:7]temp_02;
  parameter r1=8'b00011011;//1B
  parameter r2=8'b00000010;//02
  begin
    if(value_02[0]==1'b0) begin
      mul_02=(value_02 * r2) ^ r1;
    end
    else begin
      temp_02=value_02;
      temp_02[0:6]=temp_02[1:7];
      temp_02[7]=1'b0;
      mul_02=temp_02 ^ r1;
    end
  end
endfunction

//function multiply by 03
function [0:7]mul_03;
  input [0:7]value_03;
  reg [0:7]temp_03;
  begin
    temp_03=mul_02(value_03);
    mul_03=temp_03 ^ value_03;
  end
endfunction


always @ (clk,rst,ip,key,keyless,op_reg,op,aes_matrix0,aes_matrix1,aes_matrix2,aes_matrix3,b,state,aes_matrix0_step1,aes_matrix1_step1,aes_matrix2_step1,aes_matrix3_step1) begin
  if (rst) begin
    //b=1'b1;
    state=0;
    op_reg=0;
    //ip_reg=0;
	 aes_matrix0=0;
	 aes_matrix1=0;
	 aes_matrix2=0;
	 aes_matrix3=0;
	 op_reg=0;
	 aes_matrix0_step1=0;
	 aes_matrix1_step1=0;
	 aes_matrix2_step1=0;
	 aes_matrix3_step1=0;
	 op=0;
  end
  else begin
    case (state)
     0: begin  
       aes_matrix0[0:7]=ip[0:7];
       aes_matrix0[8:15]=ip[8:15];
       aes_matrix0[16:23]=ip[16:23];
       aes_matrix0[24:31]=ip[24:31];
  
       aes_matrix1[0:7]=ip[32:39];
       aes_matrix1[8:15]=ip[40:47];
       aes_matrix1[16:23]=ip[48:55];
       aes_matrix1[24:31]=ip[56:63];
  
       aes_matrix2[0:7]=ip[64:71];
       aes_matrix2[8:15]=ip[72:79];
       aes_matrix2[16:23]=ip[80:87];
       aes_matrix2[24:31]=ip[88:95];
  
       aes_matrix3[0:7]=ip[96:103];
       aes_matrix3[8:15]=ip[104:111];
       aes_matrix3[16:23]=ip[112:119];
       aes_matrix3[24:31]=ip[120:127];
		 
		 state=4'b0000;
		 op_reg=0;
	    aes_matrix0_step1=0;
	    aes_matrix1_step1=0;
	    aes_matrix2_step1=0;
	    aes_matrix3_step1=0;
		 op=0;
       
       if (b==1'b1)begin
         state=4'b0001;
			op_reg=0;
	      aes_matrix0_step1=0;
	      aes_matrix1_step1=0;
	      aes_matrix2_step1=0;
	      aes_matrix3_step1=0;
		   op=0;
       end
       else begin
         state=4'b0000;
			op_reg=0;
	      aes_matrix0_step1=0;
	      aes_matrix1_step1=0;
	      aes_matrix2_step1=0;
	      aes_matrix3_step1=0;
		   op=0;
       end
     end
     
     1: begin
       aes_matrix0_step1=subbyte(aes_matrix0);
       aes_matrix1_step1=subbyte(aes_matrix1);
       aes_matrix2_step1=subbyte(aes_matrix2);
       aes_matrix3_step1=subbyte(aes_matrix3);
       
       
       state=4'b0001;
       op_reg=0;
	    aes_matrix0=aes_matrix0;
	    aes_matrix1=aes_matrix1;
	    aes_matrix2=aes_matrix2;
	    aes_matrix3=aes_matrix3;
		 op=0;
       
       if (b==1'b1)begin
         state=4'b0010;
			op_reg=0;
	      aes_matrix0=aes_matrix0;
	      aes_matrix1=aes_matrix1;
	      aes_matrix2=aes_matrix2;
	      aes_matrix3=aes_matrix3;
		   op=0;
			aes_matrix0_step1=aes_matrix0_step1;
			aes_matrix1_step1=aes_matrix1_step1;
			aes_matrix2_step1=aes_matrix2_step1;
			aes_matrix3_step1=aes_matrix3_step1;
       end
       else begin
         state=4'b0001;
			op_reg=0;
	      aes_matrix0=aes_matrix0;
	      aes_matrix1=aes_matrix1;
	      aes_matrix2=aes_matrix2;
	      aes_matrix3=aes_matrix3;
		   op=0;
			aes_matrix0_step1=aes_matrix0_step1;
			aes_matrix1_step1=aes_matrix1_step1;
			aes_matrix2_step1=aes_matrix2_step1;
			aes_matrix3_step1=aes_matrix3_step1;
       end
     end	
     
     2: begin
        //control=1'b1;
        //shift row operation not applied on first row.
        
         //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];
        
		  state=4'b0010;
	     aes_matrix0=aes_matrix0;
	     aes_matrix1=aes_matrix1;
	     aes_matrix2=aes_matrix2;
	     aes_matrix3=aes_matrix3;
		  op=0;
		  
      
        if (b==1'b1)begin
         state=4'b0011;
			op_reg=op_reg;
	      aes_matrix0=aes_matrix0;
	      aes_matrix1=aes_matrix1;
	      aes_matrix2=aes_matrix2;
	      aes_matrix3=aes_matrix3;
		   op=0;
			aes_matrix0_step1=aes_matrix0_step1;
			aes_matrix1_step1=aes_matrix1_step1;
			aes_matrix2_step1=aes_matrix2_step1;
			aes_matrix3_step1=aes_matrix3_step1;
       end
       else begin
         state=4'b0010;
			op_reg=op_reg;
	      aes_matrix0=aes_matrix0;
	      aes_matrix1=aes_matrix1;
	      aes_matrix2=aes_matrix2;
	      aes_matrix3=aes_matrix3;
		   op=0;
			aes_matrix0_step1=aes_matrix0_step1;
			aes_matrix1_step1=aes_matrix1_step1;
			aes_matrix2_step1=aes_matrix2_step1;
			aes_matrix3_step1=aes_matrix3_step1;
       end  
     end
     
     3: begin
        //aes_matrix0_step1=subbyte(aes_matrix0);
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
		  state=4'b0011;
		  //op_reg=op_reg;
	     aes_matrix0=aes_matrix0;
	     aes_matrix1=aes_matrix1;
	     aes_matrix2=aes_matrix2;
	     aes_matrix3=aes_matrix3;
		  op=0;
		  aes_matrix0_step1=aes_matrix0_step1;
		  aes_matrix1_step1=aes_matrix1_step1;
		  aes_matrix2_step1=aes_matrix2_step1;
		  aes_matrix3_step1=aes_matrix3_step1;
		  
        if (b==1'b1)begin
         state=4'b0100;
	      aes_matrix0=aes_matrix0;
	      aes_matrix1=aes_matrix1;
	      aes_matrix2=aes_matrix2;
	      aes_matrix3=aes_matrix3;
		   op=0;
			//op_reg=op_reg;
			aes_matrix0_step1=aes_matrix0_step1;
			aes_matrix1_step1=aes_matrix1_step1;
			aes_matrix2_step1=aes_matrix2_step1;
			aes_matrix3_step1=aes_matrix3_step1;
       end
       else begin
         state=4'b0011;
	      aes_matrix0=aes_matrix0;
	      aes_matrix1=aes_matrix1;
	      aes_matrix2=aes_matrix2;
	      aes_matrix3=aes_matrix3;
		   op=0;
			//op_reg=op_reg;
			aes_matrix0_step1=aes_matrix0_step1;
			aes_matrix1_step1=aes_matrix1_step1;
			aes_matrix2_step1=aes_matrix2_step1;
			aes_matrix3_step1=aes_matrix3_step1;
       end
     end
     
     4: begin
       if(keyless)begin
              op[0:7]=op_reg[0:7];
              op[8:15]=op_reg[32:39];
              op[16:23]=op_reg[64:71];
              op[24:31]=op_reg[96:103];
              op[32:39]=op_reg[8:15];
              op[40:47]=op_reg[40:47];
              op[48:55]=op_reg[72:79];
              op[56:63]=op_reg[104:111];
              op[64:71]=op_reg[16:23];
              op[72:79]=op_reg[48:55];
              op[80:87]=op_reg[80:87];
              op[88:95]=op_reg[112:119];
              op[96:103]=op_reg[24:31];
              op[104:111]=op_reg[56:63];
              op[112:119]=op_reg[88:95];
              op[120:127]=op_reg[120:127];
				  
				  state=4'b0100;
	           aes_matrix0=aes_matrix0;
	           aes_matrix1=aes_matrix1;
	           aes_matrix2=aes_matrix2;
	           aes_matrix3=aes_matrix3;
			     aes_matrix0_step1=aes_matrix0_step1;
			     aes_matrix1_step1=aes_matrix1_step1;
			     aes_matrix2_step1=aes_matrix2_step1;
			     aes_matrix3_step1=aes_matrix3_step1;
				  //op_reg=op_reg;
           end
           else begin
              op[0:7]=op_reg[0:7] ^ key[0:7];//1
              op[8:15]=op_reg[32:39] ^ key[8:15];//2
              op[16:23]=op_reg[64:71] ^ key[16:23];//3
              op[24:31]=op_reg[96:103] ^ key[24:31];//4
              op[32:39]=op_reg[8:15] ^ key[32:39];//5
              op[40:47]=op_reg[40:47] ^ key[40:47];//6
              op[48:55]=op_reg[72:79] ^ key[48:55];//7
              op[56:63]=op_reg[104:111] ^ key[56:63];//8
              op[64:71]=op_reg[16:23] ^ key[64:71];//9
              op[72:79]=op_reg[48:55] ^ key[72:79];//10
              op[80:87]=op_reg[80:87] ^ key[80:87];//11
              op[88:95]=op_reg[112:119] ^ key[88:95];//12
              op[96:103]=op_reg[24:31] ^ key[96:103];//13
              op[104:111]=op_reg[56:63] ^ key[104:111];//14
              op[112:119]=op_reg[88:95] ^ key[112:119];//15
              op[120:127]=op_reg[120:127] ^ key[120:127];//16
				  
				  state=4'b0100;
			     //op_reg=op_reg;
	           aes_matrix0=aes_matrix0;
	           aes_matrix1=aes_matrix1;
	           aes_matrix2=aes_matrix2;
	           aes_matrix3=aes_matrix3;
			     aes_matrix0_step1=aes_matrix0_step1;
			     aes_matrix1_step1=aes_matrix1_step1;
			     aes_matrix2_step1=aes_matrix2_step1;
			     aes_matrix3_step1=aes_matrix3_step1;

       
        if (b==1'b1)begin
          state=4'b0100;
			 //op_reg=op_reg;
	       aes_matrix0=aes_matrix0;
	       aes_matrix1=aes_matrix1;
	       aes_matrix2=aes_matrix2;
	       aes_matrix3=aes_matrix3;
			 aes_matrix0_step1=aes_matrix0_step1;
			 aes_matrix1_step1=aes_matrix1_step1;
			 aes_matrix2_step1=aes_matrix2_step1;
			 aes_matrix3_step1=aes_matrix3_step1;

        end
        else begin
          state=4'b0100;
			 //op_reg=op_reg;
	       aes_matrix0=aes_matrix0;
	       aes_matrix1=aes_matrix1;
	       aes_matrix2=aes_matrix2;
	       aes_matrix3=aes_matrix3;
			 aes_matrix0_step1=aes_matrix0_step1;
			 aes_matrix1_step1=aes_matrix1_step1;
			 aes_matrix2_step1=aes_matrix2_step1;
			 aes_matrix3_step1=aes_matrix3_step1;

        end
		  
      end
		//state=4'b0100;
		
		//op_reg=op_reg;
	   aes_matrix0=aes_matrix0;
	   aes_matrix1=aes_matrix1;
	   aes_matrix2=aes_matrix2;
	   aes_matrix3=aes_matrix3;
	   aes_matrix0_step1=aes_matrix0_step1;
	   aes_matrix1_step1=aes_matrix1_step1;
		aes_matrix2_step1=aes_matrix2_step1;
		aes_matrix3_step1=aes_matrix3_step1;
    end
     
      default: begin
		
		//op_reg=op_reg;
	   aes_matrix0=aes_matrix0;
	   aes_matrix1=aes_matrix1;
	   aes_matrix2=aes_matrix2;
	   aes_matrix3=aes_matrix3;
	   aes_matrix0_step1=aes_matrix0_step1;
	   aes_matrix1_step1=aes_matrix1_step1;
		aes_matrix2_step1=aes_matrix2_step1;
		aes_matrix3_step1=aes_matrix3_step1;
      end
      
     endcase
	   op_reg=op_reg;
	   aes_matrix0=aes_matrix0;
	   aes_matrix1=aes_matrix1;
	   aes_matrix2=aes_matrix2;
	   aes_matrix3=aes_matrix3;
	   aes_matrix0_step1=aes_matrix0_step1;
	   aes_matrix1_step1=aes_matrix1_step1;
		aes_matrix2_step1=aes_matrix2_step1;
		aes_matrix3_step1=aes_matrix3_step1;
  end
end

endmodule
