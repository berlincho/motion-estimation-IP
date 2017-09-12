
`timescale 1 ns / 1 ps

	module me_match_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here
		output wire irq,
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 4;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 17
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	        end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID)
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	      slv_reg10 <= 0;
	      slv_reg11 <= 0;
	      slv_reg12 <= 0;
	      slv_reg13 <= 0;
	      slv_reg14 <= 0;
	      slv_reg15 <= 0;
	      slv_reg16 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          5'h00:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

					// sa_bank[slv_reg12][0 ] <= slv_reg0[7:0];
					// sa_bank[slv_reg12][1 ] <= slv_reg0[15:8];
					// sa_bank[slv_reg12][2 ] <= slv_reg0[23:16];
					// sa_bank[slv_reg12][3 ] <= slv_reg0[31:24];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
                    //else if(slv_reg12 < 64)begin
                    //    cb_bank[slv_reg12-48][(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                    //end
	              end  
	          5'h01:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

					// sa_bank[slv_reg12][4 ] <= slv_reg1[7:0];
					// sa_bank[slv_reg12][5 ] <= slv_reg1[15:8];
					// sa_bank[slv_reg12][6 ] <= slv_reg1[23:16];
					// sa_bank[slv_reg12][7 ] <= slv_reg1[31:24];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][32+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
                    //else if(slv_reg12 < 64)begin
                    //    cb_bank[slv_reg12-48][32+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                    //end
	              end  
	          5'h02:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][64+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
                    //else if(slv_reg12 < 64)begin
                    //    cb_bank[slv_reg12-48][64+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                    //end
	              end  
	          5'h03:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][96+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
                    //else if(slv_reg12 < 64)begin
                    //    cb_bank[slv_reg12-48][96+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                    //end

	              end  
	          5'h04:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][128+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 

	              end  
	          5'h05:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][160+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h06:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][192+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h07:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][224+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h08:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][256+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h09:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][288+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h0A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 10
	                slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][320+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h0B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 11
	                slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];

	                //if(slv_reg12<=47) begin
	                //	sa_bank[slv_reg12][352+(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	                //end 
	              end  
	          5'h0C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 12
	                slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 13
	                slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 14
	                slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 15
	                slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h10:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 16
	                slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                      slv_reg10 <= slv_reg10;
	                      slv_reg11 <= slv_reg11;
	                      slv_reg12 <= slv_reg12;
	                      slv_reg13 <= slv_reg13;
	                      slv_reg14 <= slv_reg14;
	                      slv_reg15 <= slv_reg15;
	                      slv_reg16 <= slv_reg16;
	                    end
	        endcase
	      end
		  else begin
			if(finish == 1) begin
				slv_reg13 <= 0;
				slv_reg14 <= ip_mvx - 32'd16;//ip_mvx
				slv_reg15 <= ip_mvy - 32'd16;//ip_mvy
				slv_reg16 <= min_sad;//min_sad
			end
			else begin
				slv_reg13 <= slv_reg13;
				slv_reg14 <= slv_reg14;
				slv_reg15 <= slv_reg15;
				slv_reg16 <= slv_reg16;
			end
		  end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        5'h00   : reg_data_out <= slv_reg0;
	        5'h01   : reg_data_out <= slv_reg1;
	        5'h02   : reg_data_out <= slv_reg2;
	        5'h03   : reg_data_out <= slv_reg3;
	        5'h04   : reg_data_out <= slv_reg4;
	        5'h05   : reg_data_out <= slv_reg5;
	        5'h06   : reg_data_out <= slv_reg6;
	        5'h07   : reg_data_out <= slv_reg7;
	        5'h08   : reg_data_out <= slv_reg8;
	        5'h09   : reg_data_out <= slv_reg9;
	        5'h0A   : reg_data_out <= slv_reg10;
	        5'h0B   : reg_data_out <= slv_reg11;
	        5'h0C   : reg_data_out <= slv_reg12;
	        5'h0D   : reg_data_out <= slv_reg13;
	        5'h0E   : reg_data_out <= slv_reg14;
	        5'h0F   : reg_data_out <= slv_reg15;
	        5'h10   : reg_data_out <= slv_reg16;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
	
	assign irq = (mvx == 32'd32 || finish)? 1 : 0;
	
	wire we;
	wire [383:0] data_in, data_out;
	wire [31:0] sram_addr;
	reg  [31:0] data_out_addr;

	assign we = slv_reg_wren && slv_reg12>=0 && slv_reg12 <= 47;
	assign data_in = {slv_reg11, slv_reg10, slv_reg9, slv_reg8, slv_reg7, slv_reg6, slv_reg5, slv_reg4, slv_reg3, slv_reg2, slv_reg1, slv_reg0};
	assign sram_addr = (we)? slv_reg12 : data_out_addr;

	sram #(.DATA_WIDTH(48*8), .ADDR_WIDTH(32), .RAM_SIZE(48))
    sa_bank(
        .clk(S_AXI_ACLK),
        .we(we),
        .en(1), 
        .data_in(data_in),
        .sram_addr(sram_addr),
        .data_out(data_out)
    );

	//reg [383 : 0] 	sa_bank[0:47]; //[383:0]
	reg [127 : 0] 	cb_bank	    [0:15]; //[127:0]
	reg [127 : 0] 	prev_pixel  [0:15];
	reg [127 : 0] 	prev_pixel1 [0:15];
	integer i, j, l;
	
	always @( posedge S_AXI_ACLK ) begin
		if (slv_reg_wren) begin 
			//if(slv_reg12>=0 && slv_reg12<=47)
			//	sa_bank[slv_reg12] <= {slv_reg11, slv_reg10, slv_reg9, slv_reg8, slv_reg7, slv_reg6, slv_reg5, slv_reg4, slv_reg3, slv_reg2, slv_reg1, slv_reg0};
			if(slv_reg12 >=48 && slv_reg12 <= 63)
				cb_bank[slv_reg12-48] <= {slv_reg3, slv_reg2, slv_reg1, slv_reg0};
		end
	end
	
	// User logic ends
	localparam [2:0] S_IDLE = 3'b000, S_SHIFT_ABS = 3'b001, S_LOAD = 3'b010, 
	S_SAD = 3'b011, S_MIN_SAD = 3'b100, S_CHECK_END = 3'b101;

	reg [2:0] Q, Q_next;
	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0 )
			Q <= S_IDLE;
		else
			Q <= Q_next;
	end

	always @(*) begin
		case(Q)
			S_IDLE: begin
				if(slv_reg13 == 1 && slv_reg12 >= 64)
					Q_next = S_LOAD;
				else
					Q_next = S_IDLE;
			end
			S_LOAD:
				if(counter == 16)
					Q_next = S_SHIFT_ABS;
				else
					Q_next = S_LOAD;
			S_SHIFT_ABS: begin
				Q_next = S_SAD;
			end
			S_SAD: begin
				if(waitt == 3'd4)
					Q_next = S_MIN_SAD;
				else
					Q_next = S_SAD;
			end
			S_MIN_SAD: begin
				Q_next = S_CHECK_END;
			end
			S_CHECK_END: begin
				if(mvy == 32'd32 && mvx == 32'd15 && mvx1 == 32'd16)
					Q_next = S_IDLE;
				else begin
					if(mvy == 32'd32)
						Q_next = S_LOAD;
					else
						Q_next = S_SHIFT_ABS;
						
				end	
			end
			default: 
				Q_next = S_IDLE;
		endcase
	end
	
	//reg [31:0] counter0, counter1, counter2;
	reg [31:0] mvx, mvy, ip_mvx, ip_mvy, min_sad, sad, mvx1, tmpx;
	reg [7:0] abs_diff[0:255];
	reg [7:0] abs_diff1[0:255];
	reg finish;
	reg [2:0] waitt;
	//reg [31:0] ttm;
	reg [31:0] counter;
	
	always @(posedge S_AXI_ACLK) begin
		if(S_AXI_ARESETN == 1'b0 )
			data_out_addr <= 0;
		else begin
			case(Q)
				S_IDLE: begin
					mvx <= 0;
					mvx1 <= 32'd31;
					mvy <= 0;
					ip_mvx <= 0;
					ip_mvy <= 0;
					sad <= 0;
					finish <= 0;
					min_sad <= 32'b11111111111111111111111111111111;
					waitt <= 0;
					//ttm <= 16;
					counter <= 0;
					if(slv_reg13 == 1 && slv_reg12 >= 64)
						data_out_addr <= 1;
					else
						data_out_addr <= 0;
				end
				S_LOAD: begin
					if(counter == 16) begin
						counter <= 0;
						data_out_addr <= data_out_addr;
					end
					else begin
						if(counter < 15)
							data_out_addr <= data_out_addr + 1;
						counter <= counter + 1;
						prev_pixel [counter] <= data_out[8*mvx +: 128];
						prev_pixel1[counter] <= data_out[8*mvx1 +: 128];
					end
				end
				S_SHIFT_ABS: begin
					for( i = 0 ; i < 15 ; i = i + 1 ) begin
						prev_pixel [i] <= prev_pixel [i+1];
						prev_pixel1[i] <= prev_pixel1[i+1];
					end
					//prev_pixel[15] <= sa_bank[ttm][8*mvx +: 128];
					prev_pixel [15] <= data_out[8*mvx +: 128];
					prev_pixel1[15] <= data_out[8*mvx1 +: 128];
					
					for( i = 0 ; i < 16 ; i = i + 1 )
						for( j = 0 ; j < 16 ; j = j + 1 ) begin
							if(prev_pixel[i][8*j +: 8] > cb_bank[i][8*j +: 8])
								abs_diff[i*16 + j] <= prev_pixel[i][8*j +: 8] - cb_bank[i][8*j +: 8];
							else
								abs_diff[i*16 + j] <= cb_bank[i][8*j +: 8] - prev_pixel[i][8*j +: 8];
								
							if(prev_pixel1[i][8*j +: 8] > cb_bank[i][8*j +: 8])
								abs_diff1[i*16 + j] <= prev_pixel1[i][8*j +: 8] - cb_bank[i][8*j +: 8];
							else
								abs_diff1[i*16 + j] <= cb_bank[i][8*j +: 8] - prev_pixel1[i][8*j +: 8];
						end
				end
				S_SAD: begin
					if(waitt == 3'd4) begin
						waitt <= 0;
						if(partial_sum_7[0] + partial_sum_7[1] >= partial_sum_7_1[0] + partial_sum_7_1[1]) begin
							tmpx <= mvx1;
							sad <= partial_sum_7_1[0] + partial_sum_7_1[1]; 
						end
						else begin
							tmpx <= mvx;
							sad <= partial_sum_7[0] + partial_sum_7[1];
						end
					end
					else 
						waitt <= waitt + 1;
				end
				S_MIN_SAD: begin
					mvy <= mvy + 1;
					if(sad < min_sad) begin
						min_sad <= sad;
						ip_mvx <= tmpx;
						ip_mvy <= mvy;
					end
					else if(sad == min_sad) begin
						if(mvy > ip_mvy) begin
							ip_mvy <= mvy;
							ip_mvx <= tmpx;
						end
						else if(mvy == ip_mvy) begin
							if(mvx > ip_mvx) begin
								ip_mvy <= mvy;
								ip_mvx <= tmpx;
							end
						end
					end
					
					if(mvy == 32'd32 && mvx == 32'd15 && mvx1 == 32'd16)
						data_out_addr <= 0;
					else begin
						if(mvy == 32'd31)
							data_out_addr <= 0;
						else
							data_out_addr <= (mvy+1) + 16;
					end
				end
				S_CHECK_END: begin
					if(mvy == 32'd32 && mvx == 32'd15 && mvx1 == 32'd16)
						finish <= 1;
					else begin
						if(mvy == 32'd32) begin
							mvy <= 0;
							mvx <= mvx + 1;
							mvx1 <= mvx1 - 1;
							data_out_addr <= 1;
							//ttm <= 16;
						end
						else begin
							mvy <= mvy;
							//ttm <= mvy + 16;
						end
					end
				end

				default: begin
					mvx <= 0;
					mvy <= 0;
					ip_mvx <= 0;
					ip_mvy <= 0;
					sad <= 0;
					finish <= 0;
					min_sad <= 32'b11111111111111111111111111111111;
					waitt <= 0;
					data_out_addr <= 0;
					counter <= 0;
				end
			endcase
		end
	end
	

	////////////////////////////////////////////////////////////
	//ADDER TREE1
	////////////////////////////////////////////////////////////
	
	wire [8:0]   partial_sum_1		[0:127];
	reg  [12:0]  reg_partial_sum_2	[0:63];
	wire [14:0]  partial_sum_3		[0:31];
	wire [18:0]  partial_sum_4		[0:15];
    reg  [20:0]  reg_partial_sum_5	[0:7];
    wire [20:0]  partial_sum_6		[0:3];
    wire [31:0]  partial_sum_7	[0:1];
	
    genvar idx;
    generate
    for (idx = 0; idx < 128; idx = idx + 1)
    begin: level_0
      assign partial_sum_1[idx] = abs_diff[idx*2] + abs_diff[idx*2+1];
    end
    endgenerate

	always @(posedge S_AXI_ACLK) begin 
		if (Q == S_SAD)begin
			for(l=0;l<64;l = l + 1)
				reg_partial_sum_2[l] <= partial_sum_1[l*2] + partial_sum_1[l*2+1];
        end
    end
    
    generate
    for (idx = 0; idx < 32; idx = idx + 1)
    begin: level_2
      assign partial_sum_3[idx] = reg_partial_sum_2[idx*2] + reg_partial_sum_2[idx*2+1];
    end
    endgenerate	

    generate
    for (idx = 0; idx < 16; idx = idx + 1)
    begin: level_3
      assign partial_sum_4[idx] = partial_sum_3[idx*2] + partial_sum_3[idx*2+1];
    end
    endgenerate
    
	always @(posedge S_AXI_ACLK) begin 
	if (Q == S_SAD)begin
		for(l=0;l<8;l = l + 1)
			reg_partial_sum_5[l] <= partial_sum_4[l*2] + partial_sum_4[l*2+1];
	end
    end
	
    generate
    for (idx = 0; idx < 4; idx = idx + 1)
    begin: level_5
      assign partial_sum_6[idx] = reg_partial_sum_5[idx*2] + reg_partial_sum_5[idx*2+1];
    end
    endgenerate
	
	generate
    for (idx = 0; idx < 2; idx = idx + 1)
    begin: level_6
      assign partial_sum_7[idx] = partial_sum_6[idx*2] + partial_sum_6[idx*2+1];
    end
    endgenerate
    

	////////////////////////////////////////////////////////////
	//ADDER TREE2
	////////////////////////////////////////////////////////////
	
	wire [8:0]   partial_sum_1_1		[0:127];
	reg  [12:0]  reg_partial_sum_2_1	[0:63];
	wire [14:0]  partial_sum_3_1		[0:31];
	wire [18:0]  partial_sum_4_1		[0:15];
    reg  [20:0]  reg_partial_sum_5_1	[0:7];
    wire [20:0]  partial_sum_6_1		[0:3];
    wire [31:0]   partial_sum_7_1		[0:1];
	
	generate
    for (idx = 0; idx < 128; idx = idx + 1)
    begin: level_0_1
      assign partial_sum_1_1[idx] = abs_diff1[idx*2] + abs_diff1[idx*2+1];
    end
    endgenerate

	always @(posedge S_AXI_ACLK) begin 
		if (Q == S_SAD)begin
			for(l=0;l<64;l = l + 1)
				reg_partial_sum_2_1[l] <= partial_sum_1_1[l*2] + partial_sum_1_1[l*2+1];
        end
    end
    
    generate
    for (idx = 0; idx < 32; idx = idx + 1)
    begin: level_2_1
      assign partial_sum_3_1[idx] = reg_partial_sum_2_1[idx*2] + reg_partial_sum_2_1[idx*2+1];
    end
    endgenerate	

    generate
    for (idx = 0; idx < 16; idx = idx + 1)
    begin: level_3_1
      assign partial_sum_4_1[idx] = partial_sum_3_1[idx*2] + partial_sum_3_1[idx*2+1];
    end
    endgenerate
    
	always @(posedge S_AXI_ACLK) begin 
	if (Q == S_SAD)begin
		for(l=0;l<8;l = l + 1)
			reg_partial_sum_5_1[l] <= partial_sum_4_1[l*2] + partial_sum_4_1[l*2+1];
	end
    end
	
    generate
    for (idx = 0; idx < 4; idx = idx + 1)
    begin: level_5_1
      assign partial_sum_6_1[idx] = reg_partial_sum_5_1[idx*2] + reg_partial_sum_5_1[idx*2+1];
    end
    endgenerate
    
	generate
    for (idx = 0; idx < 2; idx = idx + 1)
    begin: level_6_1
      assign partial_sum_7_1[idx] = partial_sum_6_1[idx*2] + partial_sum_6_1[idx*2+1];
    end
    endgenerate
	
	endmodule

	module sram
	#(parameter DATA_WIDTH = 32, ADDR_WIDTH = 10, RAM_SIZE = 1024)
	 (clk, we, en, sram_addr, data_in, data_out);
	input  clk, we, en;
	input  [ADDR_WIDTH-1 : 0] sram_addr;
	input  [DATA_WIDTH-1 : 0] data_in;
	output reg [DATA_WIDTH-1 : 0] data_out;
	reg    [DATA_WIDTH-1 : 0] RAM [RAM_SIZE - 1:0];

	// ------------------------------------
	// BRAM read operation
	// ------------------------------------
	always@(posedge clk)
	begin
	  if (en & we)
		data_out <= data_in;
	  else
		data_out <= RAM[sram_addr];
	end

	// ------------------------------------
	// BRAM write operation
	// ------------------------------------
	always@(posedge clk)
	begin
	  if (en & we)
		RAM[sram_addr] <= data_in;
	end
	endmodule