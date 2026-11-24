`timescale 1ns/1ps

module tb_four_bit_adder;
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    integer pass_count;
    integer fail_count;

    four_bit_adder uut (
        .A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout)
    );

    task check_result;
        input [3:0] expected_sum;
        input       expected_cout;
        input [8*40-1:0] test_name;
        begin
            #1;
            if ((Sum === expected_sum) && (Cout === expected_cout)) begin
                $display("PASS: %0s | A=%b B=%b Cin=%b | Sum=%b Cout=%b",
                         test_name, A, B, Cin, Sum, Cout);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: %0s | A=%b B=%b Cin=%b | Expected Sum=%b Cout=%b | Got Sum=%b Cout=%b",
                         test_name, A, B, Cin, expected_sum, expected_cout, Sum, Cout);
                fail_count = fail_count + 1;
            end
            #9;
        end
    endtask

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_four_bit_adder);
    end

    initial begin
        pass_count = 0;
        fail_count = 0;
        A = 0; B = 0; Cin = 0;
        #10;

        // Test 1: 1 + 3 = 4
        A = 4'b0001; B = 4'b0011; Cin = 1'b0;
        check_result(4'b0100, 1'b0, "Basic addition");

        // Test 2: 5 + 6 + 1 = 12 (1100), no carry out
        A = 4'b0101; B = 4'b0110; Cin = 1'b1;
        check_result(4'b1100, 1'b0, "Addition with carry input");

        // Test 3: 15 + 15 = 30 (11110)
        A = 4'b1111; B = 4'b1111; Cin = 1'b0;
        check_result(4'b1110, 1'b1, "Carry propagation");

        // Test 4: 0 + 0 = 0
        A = 4'b0000; B = 4'b0000; Cin = 1'b0;
        check_result(4'b0000, 1'b0, "Adding zero");

        // Test 5: 15 + 15 + 1 = 31 (11111)
        A = 4'b1111; B = 4'b1111; Cin = 1'b1;
        check_result(4'b1111, 1'b1, "Maximum values with carry input");

        $display("----------------------------------------");
        $display("TEST SUMMARY: %0d PASS, %0d FAIL", pass_count, fail_count);
        $display("----------------------------------------");
        $finish;
    end
endmodule
