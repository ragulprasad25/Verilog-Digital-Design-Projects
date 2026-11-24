`timescale 1ns/1ps

module tb_traffic_light;

    reg clk;
    reg reset;
    wire [1:0] NS_light;
    wire [1:0] EW_light;

    integer pass_count;
    integer fail_count;

    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .NS_light(NS_light),
        .EW_light(EW_light)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    task check_lights;
        input [1:0] expected_ns;
        input [1:0] expected_ew;
        input [8*40-1:0] state_name;
        begin
            #1;
            if ((NS_light === expected_ns) && (EW_light === expected_ew)) begin
                $display("PASS: %0s | NS=%b EW=%b", state_name, NS_light, EW_light);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: %0s | Expected NS=%b EW=%b | Got NS=%b EW=%b",
                         state_name, expected_ns, expected_ew, NS_light, EW_light);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, tb_traffic_light);
    end

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        pass_count = 0;
        fail_count = 0;

        // Reset selects State 0: NS Green, EW Red
        #2;
        check_lights(2'b10, 2'b00, "State 0: NS Green, EW Red");

        // Release reset away from the active clock edge
        #8 reset = 1'b0;

        // Each state advances on the next rising clock edge
        @(posedge clk);
        check_lights(2'b01, 2'b00, "State 1: NS Yellow, EW Red");

        @(posedge clk);
        check_lights(2'b00, 2'b10, "State 2: NS Red, EW Green");

        @(posedge clk);
        check_lights(2'b00, 2'b01, "State 3: NS Red, EW Yellow");

        @(posedge clk);
        check_lights(2'b10, 2'b00, "Return to State 0");

        @(posedge clk);
        check_lights(2'b01, 2'b00, "Repeat State 1");

        $display("----------------------------------------");
        $display("TEST SUMMARY: %0d PASS, %0d FAIL", pass_count, fail_count);
        $display("----------------------------------------");

        #4;
        $finish;
    end

endmodule
