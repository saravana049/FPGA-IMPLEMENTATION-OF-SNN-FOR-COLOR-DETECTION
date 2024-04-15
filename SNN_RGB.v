module snn_rgb (
    input clk,                      
    input reset_n,                   // reset (invoked during configuration)
    input [2:0] enable_in,           // three slide switches
    input [7:0] r_in,                // red component of pixel
    input [7:0] g_in,                // green component of pixel
    input [7:0] b_in,                // blue component of pixel
    output reg [7:0] r_out,
    output reg [7:0] g_out,
    output reg [7:0] b_out
);

// Input FFs
reg reset;                            

reg [7:0] r_0, g_0, b_0;              

//Output of signal processing

reg r_out_1, g_out_1, b_out_1;  // output signal for rgb channels


// Spike signals
wire h_0, h_1, h_2, h_3, h_4, h_5, h_6, out_0, out_1;  // Spike signals of the neurons
wire r_sp, g_sp, b_sp;                                 // Input spike signals

//Reset of neurons
reg neuron_reset = 1'b1;  // Initial reset signal

wire res_ly_1;             // Reset layer 1
wire res_ly_2;             // Reset layer 2

// Counting signals for steps and spikes
reg [7:0] step;             // Counter for evaluation steps
reg [7:0] num_out0_sp;  // Number of output spikes for output neurons
reg [7:0] num_out1_sp;

// Constants to be determined
parameter v_th = 25;         // Voltage threshold
parameter n_sp_to_activate = 5;  // Necessary number of output spikes to classify

/*
parameter w_0_n0 = 8;
parameter w_1_n0 = 37;
parameter w_2_n0 = 141;
parameter bias_n0 = 69;

parameter w_0_n1 = 44;
parameter w_1_n1 = 25;
parameter w_2_n1 = -73;
parameter bias_n1 = 124;

parameter w_0_n2 = 20;
parameter w_1_n2 = -39;
parameter w_2_n2 = -23;
parameter bias_n2 = 8;

parameter w_0_n3 = 137;
parameter w_1_n3 = 72;
parameter w_2_n3 = -113;
parameter bias_n3 = 20;

parameter w_0_n4 = 7;
parameter w_1_n4 = 45;
parameter w_2_n4 = -37;
parameter bias_n4 = -25;

parameter w_0_n5 = 81;
parameter w_1_n5 = 33;
parameter w_2_n5 = 55;
parameter bias_n5 = -57;

parameter w_0_n6 = -89;
parameter w_1_n6 = 0;
parameter w_2_n6 = 132;
parameter bias_n6 = 33;

parameter w_0_n7 = 196;
parameter w_1_n7 = 295;
parameter w_2_n7 = 74;
parameter w_3_n7 = -275;
parameter w_4_n7 =110;
parameter w_5_n7 = -178;
parameter w_6_n7 = 349;
parameter bias_n7 = 57;

parameter w_0_n8 = -255;
parameter w_1_n8 = 57;
parameter w_2_n8 = -171;
parameter w_3_n8 = 497;
parameter w_4_n8 = -108;
parameter w_5_n8 = 9;
parameter w_6_n8 = -386;
parameter bias_n8 = 92;
*/

// Generate input spikes based on rgb values
gen_input pseudo_random_inst (
    .clk(clk),
    .reset(reset),
    .r_st(r_in),
    .g_st(g_in),
    .b_st(b_in),
    .r_sp(r_sp),
    .g_sp(g_sp),
    .b_sp(b_sp)
);
// Neurons
neuron hidden0_inst (
    .w_0(w_0_n0),
    .w_1(w_1_n0),
    .w_2(w_2_n0),
    .bias(bias_n0),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_0)
);

neuron hidden1_inst (
    .w_0(w_0_n1),
    .w_1(w_1_n1),
    .w_2(w_2_n1),
    .bias(bias_n1),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_1)
);

neuron hidden2_inst (
    .w_0(w_0_n2),
    .w_1(w_1_n2),
    .w_2(w_2_n2),
    .bias(bias_n2),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_2)
);

neuron hidden3_inst (
    .w_0(w_0_n3),
    .w_1(w_1_n3),
    .w_2(w_2_n3),
    .bias(bias_n3),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_3)
);

neuron hidden4_inst (
    .w_0(w_0_n4),
    .w_1(w_1_n4),
    .w_2(w_2_n4),
    .bias(bias_n4),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_4)
);
neuron hidden5_inst (
    .w_0(w_0_n5),
    .w_1(w_1_n5),
    .w_2(w_2_n5),
    .bias(bias_n5),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_5)
);

neuron hidden6_inst (
    .w_0(w_0_n6),
    .w_1(w_1_n6),
    .w_2(w_2_n6),
    .bias(bias_n6),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(r_sp),
    .sp_1(g_sp),
    .sp_2(b_sp),
    .neuron_reset(res_ly_1),
    .spike_out(h_6)
);

neuron output0 (
    .w_0(w_0_n7),
    .w_1(w_0_n7),
    .w_2(w_0_n7),
    .w_3(w_0_n7),
    .w_4(w_0_n7),
    .w_5(w_0_n7),
    .w_6(w_0_n7),
    .bias(bias_n7),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(h_0),
    .sp_1(h_1),
    .sp_2(h_2),
    .sp_3(h_3),
    .sp_4(h_4),
    .sp_5(h_5),
    .sp_6(h_6),
    .neuron_reset(res_ly_2),
    .spike_out(out_0)
);

neuron output1 (
    .w_0(w_0_n8),
    .w_1(w_0_n8),
    .w_2(w_0_n8),
    .w_3(w_0_n8),
    .w_4(w_0_n8),
    .w_5(w_0_n8),
    .w_6(w_0_n8),
    .bias(bias_n8),
    .v_th(v_th),
    .clk(clk),
    .reset(reset),
    .sp_0(h_0),
    .sp_1(h_1),
    .sp_2(h_2),
    .sp_3(h_3),
    .sp_4(h_4),
    .sp_5(h_5),
    .sp_6(h_6),
    .neuron_reset(res_ly_2),
    .spike_out(out_1)
);


always @(posedge clk) begin

    // Count spikes of output neurons
    if (out_0) begin
        num_out0_sp <= num_out0_sp + 1'b1;
    end
    if (out_1) begin
        num_out1_sp <= num_out1_sp + 1'b1;
    end

    // Create output
    if (res_ly_2) begin
        if (num_out0_sp >= n_sp_to_activate) begin
            r_out_1 <= 1'b0;
            g_out_1 <= 1'b0;
            b_out_1 <= 1'b1;
        end else if (num_out1_sp >= n_sp_to_activate) begin
            r_out_1 <= 1'b1;
            g_out_1 <= 1'b1;
            b_out_1 <= 1'b0;
        end else begin
            r_out_1 <= 1'b0;
            g_out_1 <= 1'b0;
            b_out_1 <= 1'b0;
        end
        num_out0_sp <= 1'b0;
        num_out1_sp <= 1'b0;
    end

r_out = {r_out_1, r_out_1, r_out_1, r_out_1, r_out_1, r_out_1, r_out_1, r_out_1};
g_out = {g_out_1, g_out_1, g_out_1, g_out_1, g_out_1, g_out_1, g_out_1, g_out_1};
b_out = {b_out_1, b_out_1, b_out_1, b_out_1, b_out_1, b_out_1, b_out_1, b_out_1};

end

endmodule
