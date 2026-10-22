//==============================================================
// Day 1 : Parameterized ALU (combinational)
//==============================================================
module alu #(
    parameter WIDTH = 8                 // use a power of 2: 4, 8, 16, 32
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire [3:0]       op,
    output reg  [WIDTH-1:0] result,
    output wire             zero,
    output wire             negative,
    output reg              carry,
    output reg              overflow
);

    // ---------- constants ----------
    localparam SHW = $clog2(WIDTH);     // bits needed for shift amount

    localparam [3:0] OP_ADD  = 4'b0000,
                     OP_SUB  = 4'b0001,
                     OP_AND  = 4'b0010,
                     OP_OR   = 4'b0011,
                     OP_XOR  = 4'b0100,
                     OP_NOT  = 4'b0101,
                     OP_SLL  = 4'b0110,
                     OP_SRL  = 4'b0111,
                     OP_SRA  = 4'b1000,
                     OP_SLT  = 4'b1001,
                     OP_SLTU = 4'b1010;

    // ---------- helper signals ----------
    wire signed [WIDTH-1:0] a_s   = a;          // signed view of a
    wire signed [WIDTH-1:0] b_s   = b;          // signed view of b
    wire        [SHW-1:0]   shamt = b[SHW-1:0]; // shift amount
    reg         [WIDTH:0]   ext;                // 1 bit wider: holds the carry

    // ---------- main logic ----------
    always @(*) begin
        // default values: avoids unintended latches
        result   = {WIDTH{1'b0}};
        carry    = 1'b0;
        overflow = 1'b0;
        ext      = {(WIDTH+1){1'b0}};

        case (op)
            OP_ADD: begin
                ext      = {1'b0, a} + {1'b0, b};
                result   = ext[WIDTH-1:0];
                carry    = ext[WIDTH];
                overflow = (a[WIDTH-1] == b[WIDTH-1]) &&
                           (ext[WIDTH-1] != a[WIDTH-1]);
            end
            OP_SUB: begin
                ext      = {1'b0, a} - {1'b0, b};
                result   = ext[WIDTH-1:0];
                carry    = ext[WIDTH];                 // 1 means borrow (a < b unsigned)
                overflow = (a[WIDTH-1] != b[WIDTH-1]) &&
                           (ext[WIDTH-1] != a[WIDTH-1]);
            end
            OP_AND:  result = a & b;
            OP_OR:   result = a | b;
            OP_XOR:  result = a ^ b;
            OP_NOT:  result = ~a;
            OP_SLL:  result = a << shamt;
            OP_SRL:  result = a >> shamt;
            OP_SRA:  result = a_s >>> shamt;
            OP_SLT:  result = (a_s < b_s);
            OP_SLTU: result = (a < b);
            default: result = {WIDTH{1'b0}};
        endcase
    end

    // ---------- flags derived from result ----------
    assign zero     = (result == {WIDTH{1'b0}});
    assign negative = result[WIDTH-1];

endmodule
