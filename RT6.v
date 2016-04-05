module RT6(input clk,rst,
            input [0:767]T6,
            input [0:127]M2,
            input [0:127]Z0,
            output reg [0:767]RT6_out);
            
//reg [0:127]Z0;
reg b;
reg [0:3]rt3_state;
reg keyless_aes;
reg rst_aes;
reg [0:127]ip_aes;
wire [0:127]op_aes;
reg [0:127]RT6_out_reg;

aes_128 l6 (clk,rst_aes,keyless_aes,ip_aes,Z0,op_aes);

always @ (clk,rst,rt3_state,T6,b,op_aes,M2,RT6_out_reg) begin

if(rst)begin
  //Z0=128'h428a2f98d728ae227137449123ef65cd;
  rt3_state=0;
  b=1'b1;
  keyless_aes=0;
  rst_aes=0;
  ip_aes=0;
  RT6_out_reg=0;
  RT6_out=0;
end

else begin
  case (rt3_state)
    
    0: begin
      rst_aes=1'b1;
      keyless_aes=1'b1;
      ip_aes=T6[640:767];
      
		rt3_state=5'b00000;
		RT6_out_reg=0;
      RT6_out=0;
		
      if(b)begin
        rt3_state=5'b00001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;

      end
      else begin
        rt3_state=5'b00000;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;

      end 
    end
    
    1: begin
      rst_aes=1'b0;  
      
		rt3_state=5'b00001;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out_reg=0;
        RT6_out=0;
		  
      if(b)begin
        rt3_state=5'b00010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end
      else begin
        rt3_state=5'b00001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end 
    end
    
    2: begin  //empty 1
      
		rt3_state=5'b00010;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out_reg=0;
        RT6_out=0;
		
      if(b)begin
        rt3_state=5'b00011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end
      else begin
        rt3_state=5'b00010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end 
    end
    
    3: begin  //empty 2
      
		rt3_state=5'b00011;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out_reg=0;
        RT6_out=0;
		
      if(b)begin
        rt3_state=5'b00100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end
      else begin
        rt3_state=5'b00011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end   
    end
    
    4: begin  //empty 3
      
		rt3_state=5'b00100;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out_reg=0;
        RT6_out=0;
		
      if(b)begin
        rt3_state=5'b00101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end
      else begin
        rt3_state=5'b00100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end      
    end
    
    5: begin  //empty 4
      //$display("state no 5 executed");
		
		rt3_state=5'b00101;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out_reg=0;
        RT6_out=0;
		  
      if(b)begin
        rt3_state=5'b00110;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end
      else begin
        rt3_state=5'b00101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=0;
        RT6_out=0;
      end
    end
      
    6: begin  //empty 5
      //$display("value of t6[0:127] = %h",T6[0:127]);
      //$display("value of M2 = %h",M2);
      //$display("value of op_aes = %h",op_aes);
      RT6_out_reg=(op_aes ^ T6[0:127]) ^ M2;
		
		rt3_state=5'b00110;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
        RT6_out=0;
		  
      if(b)begin
        rt3_state=5'b00111;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b00110;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
    end   
    
    7: begin  
      rst_aes=1'b1;
      keyless_aes=1'b0;
      ip_aes=T6[0:127];
      
		rt3_state=5'b00111;
		RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
		  
      if(b)begin
        rt3_state=5'b01000;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b00111;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end  
    end
    
    8: begin  //empty 7
      rst_aes=1'b0;
		
		rt3_state=5'b01000;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
		  
      if(b)begin
        rt3_state=5'b01001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b01000;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
    end
    
    9: begin  //empty 8
      
		rt3_state=5'b01001;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
		  
		
      if(b)begin
        rt3_state=5'b01010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b01001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end  
    end
    
    10: begin //empty 9
      
		rt3_state=5'b01010;
		keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
		
      if(b)begin
        rt3_state=5'b01011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b01010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end  
    end
    
    11: begin //empty 10
      
		rt3_state=5'b01011;
		keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
		
      if(b)begin
        rt3_state=5'b01100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b01011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end  
    end
    
    12: begin
      
		rt3_state=5'b01100;
		keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      
      if(b)begin
        rt3_state=5'b01101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b01100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out=0;
		  RT6_out_reg=RT6_out_reg;
      end  
    end
    
    13: begin
      
      RT6_out[128:255]=op_aes;
      RT6_out[256:767]=T6[128:639];
		RT6_out[0:127]=RT6_out_reg;
      //$display("value of RT6_out[128:255] = %h",RT6_out[128:255]);
      //$display("value of RT6_out[256:767] = %h",RT6_out[256:767]);
      
		rt3_state=5'b01101;
		keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=RT6_out_reg;
		  
      if(b)begin
        rt3_state=5'b01101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=RT6_out_reg;
      end
      else begin
        rt3_state=5'b01101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=RT6_out_reg;
      end  
    end
    
    
    default: begin
	 
		rt3_state=5'b01101;
		keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=RT6_out_reg;
		
    end
  endcase
  
  rt3_state=rt3_state;
  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT6_out_reg=RT6_out_reg;
  
end


end            
            
            
endmodule            

