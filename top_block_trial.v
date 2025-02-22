
module testboard(
  input clk,
  input nrst,
  input enable, //sw0
  input measureBTN_d, //btn0
  input measureSW, //sw3
  output SCL0, //JA3
  inout SDA0, //JA4
  output LEDenable0, //JA2
 // output SCL1, //JD3
 // inout SDA1, //JD4
 // output LEDenable1, //JD2
  input [1:0] gain, //sw2&1
  output ready0, //led4
//  output ready1, //led5
/*  output led0_b,
  output led0_g,
  output led0_r,
  output led1_b,
  output led1_g,
  output led1_r,
  output led2_b,
  output led2_g,
  output led2_r,
  output led3_b,
  output led3_g,
  output led3_r*/
  output [15:0] red
  );
  wire rst, measureBTN, measure;
  wire [7:0] red0, green0,blue0;
  //wire [7:0] red1, green1, blue1;
  wire sync0;
  //wire  sync1;
  wire [2:0] brightness;
  wire [2:0] rgb0;
//  wire [2:0] rgb1;
  wire i2c_clk, i2c;
  //wire [15:0] red0full, green0full,  blue0full;
 // wire [15:0] red0full, red1full, green0full, green1full, blue0full, blue1full;
  clkgen_200kHz c1(clk,i2c_clk);
  colorlite color0(clk,rst,i2c,SCL0,SDA0,LEDenable0, measure, enable, gain,measureSW, red, ready0);
  //colorlite color1(clk,rst,SCL1,SDA1,LEDenable1, measure, enable, gain,measureSW, red1full, green1full, blue1full, ready1);
  assign i2c = i2c_clk;
  assign rst = ~nrst;
  assign measure = measureBTN;
  //assign {led3_r, led3_g, led3_b} = {led0_r, led0_g, led0_b};
 // assign {led2_r, led2_g, led2_b} = {led1_r, led1_g, led1_b};

  //assign red0 = red0full[15:8];
  //assign red1 = red1full[15:8];
  //assign green0 = green0full[15:8];
  //assign green1 = green1full[15:8];
  //assign blue0 = blue0full[15:8];
  //assign blue1 = blue1full[15:8];
 // assign brightness = 3'd1;


//rgb_led_controller8 rgbled0(clk, rst, red0, green0, blue0, sync0, , rgb0[2], rgb0[1], rgb0[0], 1'b0);
  //rgb_led_controller8 rgbled1(clk, rst, red1, green1, blue1, sync1, , rgb1[2], rgb1[1], rgb1[0], 1'b0);
  //dimmerRGB dimmer0(sync0, rst, rgb0, {led0_r, led0_g, led0_b}, brightness, 1'b0);
  //dimmerRGB dimmer1(sync1, rst, rgb1, {led1_r, led1_g, led1_b}, brightness, 1'b0);
  debouncer btnDebounce(clk, rst, measureBTN_d, measureBTN);
endmodule//testboard
