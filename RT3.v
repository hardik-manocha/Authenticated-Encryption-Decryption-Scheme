module RT3(input clk,rst,
            input [0:383]T3,
            input [0:127]M0,
            input [0:127]Z0,
            output reg [0:383]RT3_out);
            
//reg [0:127]Z0;
reg b;
reg [0:3]rt3_state;
reg keyless_aes;
reg rst_aes;
reg [0:127]ip_aes;
wire [0:127]op_aes;
reg [0:127]RT3_out_reg;

aes_128 l3 (clk,rst_aes,keyless_aes,ip_aes,Z0,op_aes);

always @ (clk,rst,rt3_state,T3,b,op_aes,M0,RT3_out_reg) begin

if(rst)begin
  //Z0=128'h428a2f98d728ae227137449123ef65cd;
  rt3_state=0;
  b=1'b1;
  keyless_aes=0;
  rst_aes=0;
  ip_aes=0;
  RT3_out=0;
  RT3_out_reg=0;
end

else begin
  case (rt3_state)
    
    0: begin
      rst_aes=1'b1;
      keyless_aes=1'b1;
      ip_aes=T3[256:383];
		
		rt3_state=5'b00000;
		RT3_out=0;
		RT3_out_reg=0;
      
      if(b)begin
        rt3_state=5'b00001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
      else begin
        rt3_state=5'b00000;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end 
    end
    
    1: begin
      rst_aes=1'b0;  
      
		rt3_state=5'b00001;
		keyless_aes=keyless_aes;
      ip_aes=ip_aes;
		RT3_out=0;
		RT3_out_reg=0;
		
      if(b)begin
        rt3_state=5'b00010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
      else begin
        rt3_state=5'b00001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end 
    end
    
    2: begin  //empty 1
      
		rt3_state=5'b00010;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out=0;
		RT3_out_reg=0;
		
      if(b)begin
        rt3_state=5'b00011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
      else begin
        rt3_state=5'b00010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end 
    end
    
    3: begin  //empty 2
      
		rt3_state=5'b00011;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out=0;
		RT3_out_reg=0;
		
      if(b)begin
        rt3_state=5'b00100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
      else begin
        rt3_state=5'b00011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end   
    end
    
    4: begin  //empty 3
      
		rt3_state=5'b00100;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out=0;
		RT3_out_reg=0;
		
      if(b)begin
        rt3_state=5'b00101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
      else begin
        rt3_state=5'b00100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end      
    end
    
    5: begin  //empty 4
		
		rt3_state=5'b00101;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out=0;
		RT3_out_reg=0;
		
      if(b)begin
        rt3_state=5'b00110;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
      else begin
        rt3_state=5'b00101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out=0;
		  RT3_out_reg=0;
      end
    end
      
    6: begin  //empty 5
      RT3_out_reg=(op_aes ^ T3[0:127]) ^ M0;
      
		rt3_state=5'b00110;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out=0;
		
		
      if(b)begin
        rt3_state=5'b00111;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b00110;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
    end   
    
    7: begin  
      rst_aes=1'b1;
      keyless_aes=1'b0;
      ip_aes=T3[0:127];
      
		rt3_state=5'b00111;
		RT3_out_reg=RT3_out_reg;
		RT3_out=0;
		
      if(b)begin
        rt3_state=5'b01000;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b00111;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end  
    end
    
    8: begin  //empty 7
      rst_aes=1'b0;
		
		rt3_state=5'b01000;
		keyless_aes=keyless_aes;
      ip_aes=ip_aes;
		RT3_out_reg=RT3_out_reg;
		RT3_out=0;
		
      if(b)begin
        rt3_state=5'b01001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b01000;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
    end
    
    9: begin  //empty 8
      
		rt3_state=5'b01001;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out_reg=RT3_out_reg;
		RT3_out=0;
		
      if(b)begin
        rt3_state=5'b01010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b01001;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end  
    end
    
    10: begin //empty 9
      
		rt3_state=5'b01010;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out_reg=RT3_out_reg;
		RT3_out=0;
		
      if(b)begin
        rt3_state=5'b01011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b01010;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end  
    end
    
    11: begin //empty 10
      
		rt3_state=5'b01011;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out_reg=RT3_out_reg;
		RT3_out=0;
		
      if(b)begin
        rt3_state=5'b01100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b01011;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end  
    end
    
    12: begin
      
		rt3_state=5'b01100;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out_reg=RT3_out_reg;
		RT3_out=0;
      
      if(b)begin
        rt3_state=5'b01101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end
      else begin
        rt3_state=5'b01100;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
		  RT3_out=0;
      end  
    end
    
    13: begin
      
      RT3_out[128:255]=op_aes;
      RT3_out[256:383]=T3[128:255];
		RT3_out[0:127]=RT3_out_reg;
      
		rt3_state=5'b01101;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		
      if(b)begin
        rt3_state=5'b01101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
      end
      else begin
        rt3_state=5'b01101;
		  keyless_aes=keyless_aes;
        rst_aes=rst_aes;
        ip_aes=ip_aes;
		  RT3_out_reg=RT3_out_reg;
      end  
    end
    
    
    default: begin
		
		rt3_state=5'b01101;
		keyless_aes=keyless_aes;
      rst_aes=rst_aes;
      ip_aes=ip_aes;
		RT3_out_reg=RT3_out_reg;
		
    end
  endcase
  rt3_state=rt3_state;
  keyless_aes=keyless_aes;
  rst_aes=rst_aes;
  ip_aes=ip_aes;
  RT3_out_reg=RT3_out_reg;

end


end            
            
            
endmodule            
