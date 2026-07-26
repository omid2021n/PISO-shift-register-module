module piso_shift_register (
    input  logic       clk,
    input  logic       rst_n,   // active-low async reset
    input  logic        load,    // load parallel data, resets counter
    input  logic        en,      // shift enable (only has effect while shifting is not done)
    input  logic [7:0]  din,     // 8-bit parallel input
    output logic        dout,    // serial output (LSB shifted out first)
    output logic        done     // high when all 8 bits have been shifted out
);

    logic [7:0] shift_reg;
    logic [3:0] shift_count;   // counts 0 to 8

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg   <= 8'd0;
            shift_count <= 4'd0;
        end else if (load) begin
            shift_reg   <= din;
            shift_count <= 4'd0;
        end else if (en && (shift_count < 4'd8)) begin
            shift_reg   <= {1'b0, shift_reg[7:1]};
            shift_count <= shift_count + 1'b1;
        end
    end

    assign dout = shift_reg[0];
    assign done = (shift_count == 4'd8);

endmodule
