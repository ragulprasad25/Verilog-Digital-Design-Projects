`timescale 1ns/1ps
module uart_tx #(parameter integer CLKS_PER_BIT = 5208)(
    input wire clk, input wire rst, input wire tx_start,
    input wire [7:0] tx_data, output reg tx, output reg tx_busy
);
    localparam IDLE=2'd0, START=2'd1, DATA=2'd2, STOP=2'd3;
    reg [1:0] state;
    reg [15:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] data_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state<=IDLE; tx<=1'b1; tx_busy<=1'b0;
            clk_count<=0; bit_index<=0; data_reg<=0;
        end else begin
            case (state)
                IDLE: begin
                    tx<=1'b1; tx_busy<=1'b0; clk_count<=0; bit_index<=0;
                    if (tx_start) begin
                        data_reg<=tx_data; tx<=1'b0;
                        tx_busy<=1'b1; state<=START;
                    end
                end
                START: begin
                    if (clk_count < CLKS_PER_BIT-1) clk_count<=clk_count+1'b1;
                    else begin
                        clk_count<=0; tx<=data_reg[0]; bit_index<=0; state<=DATA;
                    end
                end
                DATA: begin
                    if (clk_count < CLKS_PER_BIT-1) clk_count<=clk_count+1'b1;
                    else begin
                        clk_count<=0;
                        if (bit_index<7) begin
                            bit_index<=bit_index+1'b1;
                            tx<=data_reg[bit_index+1'b1];
                        end else begin tx<=1'b1; state<=STOP; end
                    end
                end
                STOP: begin
                    if (clk_count < CLKS_PER_BIT-1) clk_count<=clk_count+1'b1;
                    else begin
                        clk_count<=0; tx<=1'b1; tx_busy<=1'b0; state<=IDLE;
                    end
                end
                default: begin state<=IDLE; tx<=1'b1; end
            endcase
        end
    end
endmodule
