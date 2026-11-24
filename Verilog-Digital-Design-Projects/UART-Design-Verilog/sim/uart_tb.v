`timescale 1ns/1ps
module uart_tb;
    localparam integer CLKS_PER_BIT=16; // Short simulation divider
    reg clk, rst, tx_start;
    reg [7:0] tx_data;
    wire tx, tx_busy;
    wire [7:0] rx_data;
    wire rx_done;
    integer pass_count, fail_count;

    uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) tx_unit(
        .clk(clk), .rst(rst), .tx_start(tx_start), .tx_data(tx_data),
        .tx(tx), .tx_busy(tx_busy)
    );
    uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) rx_unit(
        .clk(clk), .rst(rst), .rx(tx), .rx_data(rx_data), .rx_done(rx_done)
    );

    initial begin clk=0; forever #10 clk=~clk; end
    initial begin $dumpfile("uart.vcd"); $dumpvars(0, uart_tb); end

    task send_byte;
        input [7:0] value;
        begin
            @(negedge clk); tx_data=value; tx_start=1;
            @(negedge clk); tx_start=0;
            wait(rx_done==1'b1); #1;
            if (rx_data===value) begin
                $display("PASS: Sent=%02h Received=%02h", value, rx_data);
                pass_count=pass_count+1;
            end else begin
                $display("FAIL: Sent=%02h Received=%02h", value, rx_data);
                fail_count=fail_count+1;
            end
            wait(tx_busy==1'b0);
            repeat(3) @(negedge clk);
        end
    endtask

    initial begin
        rst=1; tx_start=0; tx_data=0; pass_count=0; fail_count=0;
        repeat(5) @(negedge clk); rst=0;
        repeat(3) @(negedge clk);
        send_byte(8'hA5);
        send_byte(8'h3C);
        send_byte(8'h00);
        send_byte(8'hFF);
        $display("-------------------------------");
        $display("UART TEST SUMMARY: %0d PASS, %0d FAIL", pass_count, fail_count);
        $display("-------------------------------");
        $finish;
    end
endmodule
