roundness      = 150;
cube_allowance = 0.5;
rad_allowance  = 0.25;

arduino_mega_w = 54;
arduino_mega_l = 102;
arduino_mega_h = 6;//Verify
arduino_mega_t = 2;

link_w         = 105;
link_l         = 105;
link_h         = 12.5;
link_b         = arduino_mega_h + arduino_mega_t;
link_t         = 2;
link_diagonal  = sqrt(pow((link_w + link_t * 2.0), 2.0) + pow((link_l + link_t * 2.0), 2.0));

connection_w   = 25;
peg_r          = 2.5;
peg_h          = 8;

chassis_r      = (link_diagonal/2) + (peg_h);
chassis_h      = peg_h * 5;

deck_radius = link_diagonal/2 + link_t/2 + rad_allowance;


parallax_servo_w = 20;
parallax_servo_l = 40.5;
parallax_servo_h = 26;

parallax_wing_w  = parallax_servo_w;
parallax_wing_l  = 8;
parallax_wing_h  = 3;

parallax_hole_r   = 2.2;
parallax_hole_off = 10;

standoff_h = (parallax_wing_w/2 + peg_h/2 + peg_h- link_t * 2) + peg_h * 2;
standoff_w = peg_h * 2;

battery_l    = 107;
battery_w    = 38;
battery_h    = 20;
battery_buff = 10;
battery_d    = sqrt(pow(battery_w, 2) + pow(battery_h, 2));

servo_wing_r = parallax_servo_w + parallax_wing_h + link_t * 4 + battery_w/2;
bsp_r = (sqrt(pow(battery_l/2, 2) + pow(servo_wing_r, 2))) - 5;//link_diagonal/2;
wheel_base_cutout = (32.5 + rad_allowance) * 2.5 - 1;

bumper_h = 22;
//Cutout for bumper strip....
bump_ring_c = PI * bsp_r * 2;
bump_c_ratio = 230/bump_ring_c;
bump_cutout_w = parallax_servo_l + parallax_wing_l + link_t * 2 + 4;//8;

bumper_r = (165)/2;//(140 + link_t*2)/2;
bump_buffer = 6;
bump_sphere_r = bumper_r + rad_allowance + link_t * 2 + bump_buffer;

caster_h = 12;
caster_w = 23;

motor_base_r = link_diagonal * 0.45 + parallax_wing_h;
wheel_offset = 10;

//4 * 24mm bars*36PCS  8mm balls *27PCS
bar_r = 2 + rad_allowance;
bar_l = 24 + cube_allowance;
bearing_r = 4 + rad_allowance;

puzzle_dim = battery_w + link_t * 2;// + peg_h * 2;