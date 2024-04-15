module neuron (input[31:0] w_0 ,w_1, w_2, w_3, w_4, w_5, w_6, bias, v_th,
   input clk,
   input reset,
   input sp_0,
   input sp_1,
   input sp_2,
   input sp_3,
   input sp_4,
   input sp_5,
   input sp_6,
   input neuron_reset,
   output reg spike_out);

reg [31:0] tmp_sum_0;
reg [31:0] tmp_sum_1;
reg [31:0] tmp_sum_2;
reg [31:0] tmp_sum_3;
reg [31:0] tmp_sum_4;
reg [31:0] tmp_sum_5;
reg [31:0] tmp_sum_6;
reg [31:0] tmp_sum_b_0;
reg [31:0] tmp_sum_1_2;
reg [31:0] tmp_sum_3_4;
reg [31:0] tmp_sum_5_6;
reg [31:0] tmp_sum_b_0_1_2;
reg [31:0] tmp_sum_3_4_5_6;
reg [31:0] sum;
reg [31:0] voltage;

always @(posedge clk) begin
  if (reset) begin
    voltage <= 0;
  end else begin
    tmp_sum_0 <= (sp_0) ? w_0 : 0;
    tmp_sum_1 <= (sp_1) ? w_1 : 0;
    tmp_sum_2 <= (sp_2) ? w_2 : 0;
    tmp_sum_3 <= (sp_3) ? w_3 : 0;
    tmp_sum_4 <= (sp_4) ? w_4 : 0;
    tmp_sum_5 <= (sp_5) ? w_5 : 0;
    tmp_sum_6 <= (sp_6) ? w_6 : 0;

    tmp_sum_b_0 <= bias + tmp_sum_0;
    tmp_sum_1_2 <= tmp_sum_1 + tmp_sum_2;
    tmp_sum_3_4 <= tmp_sum_3 + tmp_sum_4;
    tmp_sum_5_6 <= tmp_sum_5 + tmp_sum_6;
  
    tmp_sum_b_0_1_2 <= tmp_sum_b_0 + tmp_sum_1_2;
    tmp_sum_3_4_5_6 <= tmp_sum_3_4 + tmp_sum_5_6;
  
    sum <= tmp_sum_b_0_1_2 + tmp_sum_3_4_5_6;

 //   sum <= bias + tmp_sum_0 + tmp_sum_1 + tmp_sum_2 + tmp_sum_3 + tmp_sum_4 + tmp_sum_5 + tmp_sum_6;

    voltage <= voltage + sum; 
  
    if (voltage > v_th) begin
      voltage <= voltage - v_th;
      spike_out <= 1'b1;
    end else begin
      spike_out <= 1'b0;
    end
  
    if (neuron_reset) begin
      voltage <= 0;
    end
  end
end

endmodule

