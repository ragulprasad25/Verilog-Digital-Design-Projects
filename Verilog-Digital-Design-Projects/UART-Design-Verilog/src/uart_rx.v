`timescale 1ns/1ps
module uart_rx #(parameter integer CLKS_PER_BIT = 5208)(
    input wire clk, input wire rst, input wire rx,
    output reg [7:0] rx_data, output reg rx_done
);
    localparam IDLE=2'd0, START=2'd1, DATA=2'd2, STOP=2'd3;
    reg [1:0] state;
    reg [15:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] data_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state<=IDLE; clk_count<=0; bit_index<=0;
            data_reg<=0; rx_data<=0; rx_done<=0;
        end else begin
            rx_done<=1'b0;
            case (state)
                IDLE: begin
                    clk_count<=0; bit_index<=0;
                    if (rx==1'b0) begin clk_count<=0; state<=START; end
                end
                START: begin
                    if (clk_count == (CLKS_PER_BIT/2)-1) begin
                        clk_count<=0;
                        if (rx==1'b0) state<=DATA;
                        else state<=IDLE;
                    end else clk_count<=clk_count+1'b1;
                end
                DATA: begin
                    if (clk_count < CLKS_PER_BIT-1) clk_count<=clk_count+1'b1;
                    else begin
                        clk_count<=0; data_reg[bit_index]<=rx;
                        if (bit_index<7) bit_index<=bit_index+1'b1;
                        else state<=STOP;
                    end
                end
                STOP: begin
                    if (clk_count < CLKS_PER_BIT-1) clk_count<=clk_count+1'b1;
                    else begin
                        clk_count<=0;
                        if (rx==1'b1) begin rx_data<=data_reg; rx_done<=1'b1; end
                        state<=IDLE;
                    end
                end
                default: state<=IDLE;
            endcase
        end
    end
endmodule
