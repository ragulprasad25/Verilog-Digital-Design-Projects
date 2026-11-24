
`timescale 1ns/1ps

module tb_alu;

    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] Sel;

    wire [7:0] Result;
    wire CarryOut;
    wire Zero;

    integer failures;

    // ALU instance
    alu uut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .Result(Result),
        .CarryOut(CarryOut),
        .Zero(Zero)
    );

    // Waveform generation
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);
    end

    // Task to verify ALU output
    task check_result;
        input [7:0] expected_result;
        input expected_carry;
        input expected_zero;
        input [8*40-1:0] test_name;

        begin
            #1;

            if (Result === expected_result &&
                CarryOut === expected_carry &&
                Zero === expected_zero) begin

                $display("PASS: %0s | Result=%b CarryOut=%b Zero=%b",
                         test_name, Result, CarryOut, Zero);
            end
            else begin
                $display("FAIL: %0s | Expected=%b Actual=%b",
                         test_name, expected_result, Result);
                failures = failures + 1;
            end

            #9;
        end
    endtask

    // Main test sequence
    initial begin

        failures = 0;

        // TEST 1: Addition (25 + 15 = 40)
        A = 8'd25;
        B = 8'd15;
        Sel = 3'b000;
        check_result(8'd40, 0, 0, "Addition");

        // TEST 2: Subtraction (50 - 20 = 30)
        A = 8'd50;
        B = 8'd20;
        Sel = 3'b001;
        check_result(8'd30, 0, 0, "Subtraction");

        // TEST 3: AND
        A = 8'hAC;
        B = 8'h5A;
        Sel = 3'b010;
        check_result(8'h08, 0, 0, "AND");

        // TEST 4: OR
        A = 8'hAC;
        B = 8'h5A;
        Sel = 3'b011;
        check_result(8'hFE, 0, 0, "OR");

        // TEST 5: XOR
        A = 8'hAC;
        B = 8'h5A;
        Sel = 3'b100;
        check_result(8'hF6, 0, 0, "XOR");

        // TEST 6: Zero result
        A = 8'd20;
        B = 8'd20;
        Sel = 3'b001;
        check_result(8'd0, 0, 1, "Zero flag");

        // TEST 7: Addition carry
        A = 8'd255;
        B = 8'd1;
        Sel = 3'b000;
        check_result(8'd0, 1, 1, "Addition carry");

        // TEST 8: Invalid selector
        A = 8'd10;
        B = 8'd5;
        Sel = 3'b111;
        check_result(8'd0, 0, 1, "Invalid selector");

        // TEST 9: Small addition
        A = 8'd12;
        B = 8'd8;
        Sel = 3'b000;
        check_result(8'd20, 0, 0, "Small addition");

        // TEST 10: Large subtraction
        A = 8'd100;
        B = 8'd40;
        Sel = 3'b001;
        check_result(8'd60, 0, 0, "Large subtraction");

        // TEST 11: AND with zero
        A = 8'hFF;
        B = 8'h00;
        Sel = 3'b010;
        check_result(8'h00, 0, 1, "AND zero");

        // TEST 12: OR with zero
        A = 8'hA5;
        B = 8'h00;
        Sel = 3'b011;
        check_result(8'hA5, 0, 0, "OR zero");

        // TEST 13: XOR identical inputs
        A = 8'h55;
        B = 8'h55;
        Sel = 3'b100;
        check_result(8'h00, 0, 1, "XOR identical");

        // Final report
        $display("------------------------------------");

        if (failures == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d", failures);

        $display("------------------------------------");

        $finish;
    end

endmodule
