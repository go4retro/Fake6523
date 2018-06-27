`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:55:37 06/26/2018 
// Design Name: 
// Module Name:    Fake6523 
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
module Fake6523(
                input clock,
                input _reset,
                input _cs,
                input [2:0]rs,
                input _write,
                inout [7:0]data,
                inout [7:0]port_a,
                inout [7:0]port_b,
                inout [7:0]port_c
               );

reg [7:0]data_out;

ioport      ioport_a(clock, !_reset, data, (!_cs & !_write & (rs == 3)), data_ddr_a, (!_cs & !_write & (rs == 0)), data_port_a, port_a);
ioport      ioport_b(clock, !_reset, data, (!_cs & !_write & (rs == 4)), data_ddr_b, (!_cs & !_write & (rs == 1)), data_port_b, port_b);
ioport      ioport_c(clock, !_reset, data, (!_cs & !_write & (rs == 5)), data_ddr_c, (!_cs & !_write & (rs == 2)), data_port_c, port_c);

assign data =  (clock & !_cs & _write ? data_out : 8'bz);

always @(*)
begin
   case(rs)
      0: data_out = port_a;
      1: data_out = port_b;
      2: data_out = port_c;
      3: data_out = data_ddr_a;
      4: data_out = data_ddr_b;
      5: data_out = data_ddr_c;
      default: data_out = 8'bz;
   endcase
end

endmodule
