`timescale 1ns/1ps
//==============================================================
// Self-checking testbench for the parameterized ALU
//==============================================================
module tb_alu;

    parameter WIDTH = 8;                       // power of 2, up to 16 here

    // opcodes (same numbers as the design)
    localparam [3:0] OP_ADD=0, OP_SUB=1, OP_AND=2, OP_OR=3, OP_XOR=4,
                     OP_NOT=5, OP_SLL=6, OP_SRL=7, OP_SRA=8,
                     OP_SLT=9, OP_SLTU=10;

    // DUT connections
    reg  [WIDTH-1:0] a, b;
    reg  [3:0]       op;
    wire [WIDTH-1:0] result;
    wire             zero, negative, carry, overflow;

    // expected values from the reference model
    reg [WIDTH-1:0] exp_result;
    reg             exp_carry, exp_overflow, exp_zero, exp_neg;

    // bookkeeping
    integer pass_count, fail_count;
    integer o, i, j, k;
    reg [WIDTH-1:0] corner [0:4];

    // ---------- device under test ----------
    alu #(.WIDTH(WIDTH)) dut (
        .a(a), .b(b), .op(op),
        .result(result), .zero(zero), .negative(negative),
        .carry(carry), .overflow(overflow)
    );

    // ---------- reference model (written with integer maths, NOT copied from the RTL) ----------
    task compute_expected;
        integer ua, ub, sa, sb, full, sh, modulus;
        begin
            modulus = 1 << WIDTH;
            ua = a;  ub = b;                       // zero-extended unsigned values
            sa = ua; if (a[WIDTH-1]) sa = ua - modulus;   // signed values
            sb = ub; if (b[WIDTH-1]) sb = ub - modulus;
            sh = ub % WIDTH;

            exp_result = 0; exp_carry = 0; exp_overflow = 0;

            case (op)
                OP_ADD: begin
                    full = ua + ub;
                    exp_result   = full % modulus;
                    exp_carry    = (full >= modulus);
                    full = sa + sb;
                    exp_overflow = (full > modulus/2 - 1) || (full < -(modulus/2));
                end
                OP_SUB: begin
                    full = ua - ub;
                    if (full < 0) full = full + modulus;
                    exp_result   = full;
                    exp_carry    = (ua < ub);
                    full = sa - sb;
                    exp_overflow = (full > modulus/2 - 1) || (full < -(modulus/2));
                end
                OP_AND:  exp_result = a & b;
                OP_OR:   exp_result = a | b;
                OP_XOR:  exp_result = a ^ b;
                OP_NOT:  exp_result = ~a;
                OP_SLL:  exp_result = ua << sh;
                OP_SRL:  exp_result = ua >> sh;
                OP_SRA:  exp_result = sa >>> sh;
                OP_SLT:  exp_result = (sa < sb);
                OP_SLTU: exp_result = (ua < ub);
                default: exp_result = 0;
            endcase

            exp_zero = (exp_result == 0);
            exp_neg  = exp_result[WIDTH-1];
        end
    endtask

    // ---------- apply one test and compare ----------
    task check;
        input [WIDTH-1:0] ta;
        input [WIDTH-1:0] tb_val;
        input [3:0]       top;
        begin
            a = ta; b = tb_val; op = top;
            #5;                                    // let combinational logic settle
            compute_expected;
            if (result   !== exp_result   || carry !== exp_carry ||
                overflow !== exp_overflow || zero  !== exp_zero  ||
                negative !== exp_neg) begin
                fail_count = fail_count + 1;
                $display("FAIL op=%0d a=%0d b=%0d | got r=%0d c=%b v=%b z=%b n=%b | exp r=%0d c=%b v=%b z=%b n=%b",
                          op, a, b, result, carry, overflow, zero, negative,
                          exp_result, exp_carry, exp_overflow, exp_zero, exp_neg);
            end else begin
                pass_count = pass_count + 1;
            end
            #5;
        end
    endtask

    // ---------- test sequence ----------
    initial begin
        pass_count = 0;  fail_count = 0;

        corner[0] = 0;                                   // zero
        corner[1] = 1;                                   // one
        corner[2] = {WIDTH{1'b1}};                       // all ones (-1)
        corner[3] = {1'b1, {(WIDTH-1){1'b0}}};           // most negative
        corner[4] = {1'b0, {(WIDTH-1){1'b1}}};           // most positive

        $display("---- Directed corner-case tests ----");
        for (o = 0; o < 16; o = o + 1)
            for (i = 0; i < 5; i = i + 1)
                for (j = 0; j < 5; j = j + 1)
                    check(corner[i], corner[j], o);

        $display("---- Random tests ----");
        for (k = 0; k < 2000; k = k + 1)
            check($random, $random, {$random} % 16);

        $display("=====================================");
        $display("WIDTH=%0d  PASS=%0d  FAIL=%0d", WIDTH, pass_count, fail_count);
        if (fail_count == 0) $display("RESULT: ALL TESTS PASSED");
        else                 $display("RESULT: TESTS FAILED");
        $display("=====================================");
        $finish;
    end

endmodule
