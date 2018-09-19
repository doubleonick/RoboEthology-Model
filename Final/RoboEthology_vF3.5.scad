include <variables.scad>

module cube_base(width, length, height){
    cube(size = [width, length, height], center = true);
}

module cylinder_base(radius, height, resolution){
    cylinder(r = radius, h = height, $fn = resolution, center = true);
}

module cone_base(radius1, radius2, height, resolution){
    cylinder(r1 = radius1, r2 = radius2, h = height, $fn = resolution, center = true);
}

module sphere_base(radius, resolution){
    sphere(r = radius, $fn = resolution, center = true);
}

module controller_housing_lock(){
    //Pegs
    translate([-(link_w + link_t * 2.0)/2, -(link_l + link_t * 2.0)/2, 0])
    translate([0, 0, link_b + link_t * 0.5-peg_h/3-0.1])
    
    difference(){        
        for(x = [1]){
            for(y = [1]){
                translate([(link_w + link_t * 2.0)/2 * x, (link_l + link_t * 2.0)/2 * y, link_b/2 - peg_h * 0.75 - cube_allowance/2])
                difference(){
                    //cylinder_base(peg_r * 2 + link_t, link_h + link_b, roundness);
                    cylinder_base(peg_r * 2 + link_t, peg_h * 2, roundness);
                    /*
                    translate([(peg_r/2) * x, (peg_r/2) * y, -4 + peg_h])
                    cylinder_base(bar_r, bar_l, roundness);
                    translate([(peg_r/4 - bar_r/2) * x, (peg_r/4 - bar_r/2) * y, -4 + peg_h])
                    rotate([0, 0, 45])
                    cube_base(bar_r *2, bar_r *2, bar_l);
                    translate([(peg_r/4 - bar_r * 1.5) * x, (peg_r/4 - bar_r * 1.5) * y, -4 + peg_h])
                    rotate([0, 0, 45])
                    cube_base(bar_r *2, bar_r *2, bar_l);
                    //cylinder_base(peg_r, link_h + link_b, roundness);
                    */
                }
            }
        }
        cube_base(link_w, link_l, link_h + link_b + bar_l + 4);
    }
    //Connecting base
    difference(){
        translate([-bar_r * 2, -bar_r * 2, 1 - 0.025])
        rotate([0, 0, 45])
        cube_base(bar_r * 4, bar_r * 6, peg_h + 2);
        translate([-bar_r * 4.5, -bar_r * 4.5, 1 - 0.025])
        cylinder_base(peg_r * 2 + link_t, peg_h + 2, roundness);
    }
}

module controller_housing(){
    
    difference(){
        union(){
            cube_base(arduino_mega_w + arduino_mega_t * 2.0, arduino_mega_l + arduino_mega_t * 2.0, arduino_mega_h + arduino_mega_t);
            for(y = [-1,1]){
                translate([0, link_w * 0.3 * y, 0])
                difference(){
                    cube_base(link_l + link_t * 2, peg_h * 4, arduino_mega_h + arduino_mega_t);
                    for(x = [-6:6]){
                        for(y = [-1:1]){
                            translate([peg_h * x, peg_h * y, 0])
                            cylinder_base(peg_r, peg_h, roundness);
                        }
                    }
                }
            }
        }
        translate([0, 0, arduino_mega_t * 0.5 + arduino_mega_h * 0.25])
        cube_base(arduino_mega_w, arduino_mega_l, arduino_mega_h);
    }
    
    //Link Walls
    //translate([0, 0, link_b + link_t * 0.5 ])
    difference(){
        cube_base(link_w + link_t * 2.0, link_l + link_t * 2.0, link_b);
        cube_base(link_w, link_l, link_b);
        translate([0, 0, link_b * 0.5])
        cube_base(arduino_mega_w, link_l + link_t * 2.0, link_h);
        for(x = [-1, 1]){
            for(y = [-1, 1]){
               // translate([(link_w/2 - bar_r/4) * x, (link_l/2 - bar_r/4) * y, link_b/2 - 2])
                //cube_base(bar_r * 2, bar_r * 2, link_h + link_b);
                translate([(link_w)/2 * x, (link_l)/2 * y, link_b/2 - 2])
                cube_base(bar_r * 3, bar_r * 3, link_h + link_b);
                //translate([(peg_r/4 - bar_r/2) * x, (peg_r/4 - bar_r/2) * y, link_b/2])
                //    rotate([0, 0, 45])
                //    cube_base(bar_r *2, bar_r *2, link_h);
            }
        }

    }
    //Make sure SensorDeck aligns
    //Locks (currently with rod magnets) X4
    translate([(link_w/2) * 1 + link_t * 0.25, (link_l/2) * -1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 3) * 1, ((bearing_r)/2 + 3) * -1, 0])
    rotate([0, 0, -87.5]){
        controller_housing_lock();
        
    }
    
    translate([(link_w/2) * -1 + link_t * 0.25, (link_l/2) * 1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 3) * -1, ((bearing_r)/2 + 3) * 1, 0])
    rotate([0, 0, 87.5]){
        controller_housing_lock();
        
    }
    
    translate([(link_w/2) * -1 + link_t * 0.25, (link_l/2) * -1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 3.5) * -1, ((bearing_r)/2 + 3.5) * -1, 0])
    rotate([0, 0, 180]){
        controller_housing_lock();
        
    }
    
    rotate([0, 0, 180]);
    translate([(link_w/2) * 1 + link_t * 0.25, (link_l/2) * 1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 2.55) * 1, ((bearing_r)/2 + 2.55) * 1, 0]){
        controller_housing_lock();
        
    }
     
    //translate([0, 0, -link_t * 0.75])
    //cube_base(connection_w, link_w, link_t);

 }
 //controller_housing();
 module peg_holes_9x5(){
    for(x = [-4:4]){
         for(y = [-2:2]){
             translate([0, peg_h * x, peg_h * y])
             rotate([0, 90, 0])
             cylinder_base(peg_r, peg_h + cube_allowance, roundness);
         }
     }
 }
 
 module sensor_deck_lock(){
    /*difference(){
        cylinder_base(peg_r * 2 + link_t, bearing_r * 2, roundness);
        sphere_base(bearing_r, roundness);
        translate([0, 0, 3])
        cylinder_base(bearing_r, bearing_r * 2 - 2, roundness);
    }
    */
    difference(){
        cylinder_base(peg_r * 2 + link_t + cube_allowance * 2, peg_h, roundness);
        //sphere_base(bearing_r, roundness);
        
    }
}

 module sensor_mount_deck(){
     //ALTERNATE CONTROLER_HOUSING
    
     difference(){
         translate([0, 0, -peg_h * 2])
         difference(){
             cylinder_base(deck_radius, peg_h * 3, roundness);
             
             //For thinning out
             translate([0, 0, - peg_h/2])
             difference(){
                cylinder_base(deck_radius, peg_h * 2, roundness);
                cylinder_base(deck_radius - peg_h, peg_h * 2, roundness);
             }
             
             //To fit the Link controller
             translate([0, 0, -peg_h/2])
             cube_base(link_w + peg_h * 1.5, link_l + peg_h * 1.5, peg_h * 2);
             
             cube_base(link_w, link_l, peg_h * 3);
             
             //Shave off roundness of the sides
             translate([0, deck_radius - peg_h * .5, 0])
             cube_base(link_w, peg_h * 1.5, peg_h * 3);
             translate([0, -(deck_radius - peg_h * .5), 0])
             cube_base(link_w, peg_h * 1.5, peg_h * 3);
             translate([deck_radius - peg_h * .5, 0, 0])
             cube_base(peg_h * 1.5, link_w, peg_h * 3);
             translate([-(deck_radius - peg_h * .5), 0, 0])
             cube_base(peg_h * 1.5, link_w, peg_h * 3);
             
             //Fill horizontal sides with holes every 22.5 degrees
             for(x = [-1, 1]){
                 for(theta = [0:22.5:360]){
                    rotate([0, 0, theta])
                    translate([deck_radius + bearing_r - peg_h *2, 0, peg_h * x/2  - peg_h/2])
                    rotate([0, 90, 0])
                    cylinder_base(peg_r, peg_h * 4, roundness);
                }
            }
         }
         
         for(x = [-5:5]){
             for(y = [-8:-7]){
                 translate([peg_h * x, peg_h * y, -peg_h])
                 cylinder_base(peg_r, peg_h + cube_allowance, roundness);
             }
             for(y = [7:8]){
                 translate([peg_h * x, peg_h * y, -peg_h])
                 cylinder_base(peg_r, peg_h + cube_allowance, roundness);
             }
         }
         
         for(y = [-5:5]){
             for(x = [-8:-7]){
                 translate([peg_h * x, peg_h * y, -peg_h])
                 cylinder_base(peg_r, peg_h + cube_allowance, roundness);
             }
             for(x = [7:8]){
                 translate([peg_h * x, peg_h * y, -peg_h])
                 cylinder_base(peg_r, peg_h + cube_allowance, roundness);
             }
         }
         for(x = [-1, 1]){
            for(y = [-1, 1]){
                translate([(link_w/2) * x + link_t * 0.25, (link_l/2) * y + link_t * 0.25, 0])
                translate([((bearing_r)/2 + 3) * x, ((bearing_r)/2 + 3) * y, -peg_h * 2])
                cylinder_base((peg_r * 2 + link_t) + rad_allowance, peg_h * 3, roundness);
                //cylinder_base(peg_r - rad_allowance, peg_h, roundness);
                
            }
        }
     }
     /*
     for(x = [-1, 1]){
        for(y = [-1, 1]){
            translate([(link_w/2) * x + link_t * 0.25, (link_l/2) * y + link_t * 0.25, 0])
            translate([((bearing_r)/2 + 3) * x, ((bearing_r)/2 + 3) * y, 0]){
                sensor_deck_lock();
                
                difference(){
                    cylinder_base( bearing_r + link_t * 2, peg_h + cube_allowance, roundness);
                    cylinder_base( bearing_r + link_t, peg_h + cube_allowance, roundness);
                }  
            }
            //cylinder_base(peg_r - rad_allowance, peg_h, roundness);
        }
    }*/
    
    //Sensor deck lock gaurds X4
    translate([(link_w/2) * 1 + link_t * 0.25, (link_l/2) * 1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 2.55) * 1, ((bearing_r)/2 + 2.55) * 1, -peg_h * 2])
    union(){
        difference(){
            cylinder_base( bearing_r + peg_h, peg_h * 3 , roundness);
            cylinder_base( (peg_r * 2 + link_t) + rad_allowance, peg_h * 3, roundness);
            rotate([0, 0, 45])
            translate([-(bearing_r + link_t + rad_allowance) * 0.9, 0, 0])
            cube_base((bearing_r + link_t + rad_allowance) * 2, (bearing_r + link_t + rad_allowance) * 4, peg_h * 4 + cube_allowance);
            
            for(z = [-1, 1]){
                translate([0, 0, peg_h * z/2 - peg_h/2])
                rotate([0, 90, 45])
                cylinder_base(peg_r, peg_h * 4, roundness);
            }
        }
        translate([0, 0, peg_h])
        sensor_deck_lock();
                
        difference(){
            cylinder_base( bearing_r + link_t * 2, peg_h + cube_allowance, roundness);
            cylinder_base( bearing_r + link_t, peg_h + cube_allowance, roundness);
            //To fit the Link controller
            cube_base(link_w, link_l, peg_h * 3);
        }
    }
    
    translate([(link_w/2) * -1 + link_t * 0.25, (link_l/2) * -1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 3.5) * -1, ((bearing_r)/2 + 3.5) * -1, -peg_h * 2])
    union(){
        difference(){
            cylinder_base( bearing_r + peg_h, peg_h * 3, roundness);
            cylinder_base( (peg_r * 2 + link_t) + rad_allowance, peg_h * 3);
            rotate([0, 0, 45])
            translate([(bearing_r + link_t + rad_allowance) * 0.9, 0, 0])
            cube_base((bearing_r + link_t + rad_allowance) * 2, (bearing_r + link_t + rad_allowance) * 4, peg_h * 4 + cube_allowance);
            
            for(z = [-1, 1]){
                translate([0, 0, peg_h * z/2 - peg_h/2])
                rotate([0, 90, 45])
                cylinder_base(peg_r, peg_h * 4, roundness);
            }
        }
        translate([0, 0, peg_h])
        sensor_deck_lock();
        
        difference(){
            cylinder_base( bearing_r + link_t * 2, peg_h + cube_allowance, roundness);
            cylinder_base( bearing_r + link_t, peg_h + cube_allowance, roundness);
            //To fit the Link controller
            cube_base(link_w, link_l, peg_h * 3);
        }
    }
    
    translate([(link_w/2) * -1 + link_t * 0.25, (link_l/2) * 1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 3) * -1, ((bearing_r)/2 + 3) * 1, -peg_h * 2])
    union(){
        difference(){
            cylinder_base( bearing_r + peg_h, peg_h * 3, roundness);
            cylinder_base( (peg_r * 2 + link_t) + rad_allowance, peg_h * 3, roundness);
            rotate([0, 0, 45])
            translate([0, -(bearing_r + link_t + rad_allowance) * 0.9, 0])
            cube_base((bearing_r + link_t + rad_allowance) * 4, (bearing_r + link_t + rad_allowance) * 2, peg_h * 4 + cube_allowance);
            
            for(z = [-1, 1]){
                translate([0, 0, peg_h * z/2 - peg_h/2])
                rotate([0, 90, -45])
                cylinder_base(peg_r, peg_h * 4, roundness);
            }
        }
        translate([0, 0, peg_h])
        sensor_deck_lock();
                
        difference(){
            cylinder_base( bearing_r + link_t * 2, peg_h + cube_allowance, roundness);
            cylinder_base( bearing_r + link_t, peg_h + cube_allowance, roundness);
            //To fit the Link controller
            cube_base(link_w, link_l, peg_h * 3);
        }
    }
    
    translate([(link_w/2) * 1 + link_t * 0.25, (link_l/2) * -1 + link_t * 0.25, 0])
    translate([((bearing_r)/2 + 3) * 1, ((bearing_r)/2 + 3) * -1, -peg_h * 2])
    union(){
        difference(){
            cylinder_base( bearing_r + peg_h, peg_h * 3, roundness);
            cylinder_base( (peg_r * 2 + link_t) + rad_allowance, peg_h * 3);
            rotate([0, 0, 45])
            translate([0, (bearing_r + link_t + rad_allowance) * 0.9, 0])
            cube_base((bearing_r + link_t + rad_allowance) * 4, (bearing_r + link_t + rad_allowance) * 2, peg_h * 4 + cube_allowance);
            
            for(z = [-1, 1]){
                translate([0, 0, peg_h * z/2 - peg_h/2])
                rotate([0, 90, -45])
                cylinder_base(peg_r, peg_h * 4, roundness);
            }
        }
        translate([0, 0, peg_h])
        sensor_deck_lock();
                
        difference(){
            cylinder_base( bearing_r + link_t * 2, peg_h + cube_allowance, roundness);
            cylinder_base( bearing_r + link_t, peg_h + cube_allowance, roundness);
            //To fit the Link controller
            cube_base(link_w, link_l, peg_h * 3);
        }
    }
    
            
            
    
}
//controller_housing();
module parallax_wing(){
    difference(){
        cube_base(parallax_wing_w, parallax_wing_l, parallax_wing_h);
        translate([parallax_hole_off/2, parallax_hole_r * 1.0, 0])
        cylinder_base(parallax_hole_r, parallax_wing_h * 2, roundness);
        translate([-parallax_hole_off/2, parallax_hole_r * 1.0, 0])
        cylinder_base(parallax_hole_r, parallax_wing_h * 2, roundness);
    }
}

module parallax_servo(){
    translate([0, parallax_servo_l/2 + parallax_wing_l/2, parallax_servo_h/2 + parallax_wing_h/2])
    parallax_wing();
    cube_base(parallax_servo_w, parallax_servo_l, parallax_servo_h);
    rotate([0, 0, 180])
    translate([0, (parallax_servo_l/2 + parallax_wing_l/2), parallax_servo_h/2 + parallax_wing_h/2])
    parallax_wing();
    translate([0, 0, parallax_servo_h/2 + parallax_wing_h/2])
    cube_base(parallax_servo_w, parallax_servo_l, parallax_wing_h);
}

module parallax_wing_cutout(){
    union(){
        cube_base(parallax_wing_w + cube_allowance, parallax_wing_l + cube_allowance, parallax_wing_h);
        translate([parallax_hole_off/2, parallax_hole_r * 1.0, -(parallax_servo_h + parallax_wing_h)/2])
        cylinder_base(parallax_hole_r + rad_allowance, parallax_servo_h + parallax_wing_h * 2, roundness);
        translate([-parallax_hole_off/2, parallax_hole_r * 1.0, -(parallax_servo_h + parallax_wing_h)/2])
        cylinder_base(parallax_hole_r + rad_allowance, parallax_servo_h + parallax_wing_h * 2, roundness);
    }
}

module parallax_cutout(){
    translate([0, parallax_servo_l/2 + parallax_wing_l/2, (parallax_servo_h + parallax_wing_h)/2])
    parallax_wing_cutout();
    cube_base(parallax_servo_w + cube_allowance, parallax_servo_l + cube_allowance, parallax_servo_h);
    rotate([0, 0, 180])
    translate([0, (parallax_servo_l/2 + parallax_wing_l/2), (parallax_servo_h + parallax_wing_h)/2])
    parallax_wing_cutout();
    translate([0, 0, (parallax_servo_h + parallax_wing_h)/2])
    cube_base(parallax_servo_w + cube_allowance, parallax_servo_l + cube_allowance, parallax_wing_h);
}

//Servo Wing Mount
module servo_wing_mount(){
    difference(){
        rotate([0, 90, 0])
        difference(){
            cube_base(parallax_servo_w + (link_t * 2), parallax_servo_l + parallax_wing_l * 2 + (link_t * 2), parallax_wing_h * 3);
            parallax_cutout();
            translate([-2, 0, 0])
            cube_base(parallax_servo_w + (link_t * 2) + cube_allowance, parallax_servo_l + parallax_wing_l * 2 + cube_allowance, parallax_wing_h + cube_allowance);    
        }
        translate([0, 0, parallax_servo_w/2])
        cube_base(parallax_wing_h * 3 + cube_allowance, parallax_servo_l + cube_allowance, link_t * 2 + cube_allowance);
    }
}

module servo_body_mount(){
    difference(){
        rotate([0, 90, 0])
        translate([0, 0, (parallax_servo_h + parallax_wing_h + cube_allowance)/2])
        difference(){
            cube_base(parallax_servo_w + (link_t * 2), parallax_servo_l + cube_allowance + (link_t * 2), parallax_servo_h);
            translate([-(link_t / 2), 0, -(link_t - cube_allowance)])
            cube_base(parallax_servo_w + link_t + cube_allowance, parallax_servo_l + cube_allowance, parallax_servo_h);
        }

        translate([parallax_servo_h - link_t - cube_allowance, parallax_servo_l/2, link_t/2])
        cube_base(5 + cube_allowance, 7 + cube_allowance, parallax_servo_w + link_t + cube_allowance);
        translate([parallax_servo_h - link_t - cube_allowance, -parallax_servo_l/2, link_t/2])
        cube_base(5 + cube_allowance, 7 + cube_allowance, parallax_servo_w + link_t + cube_allowance);
    }
}

module peg_board_2x15(){
    difference(){
        cube_base(peg_h * 17 + link_t * 1.5, parallax_servo_w + link_t * 2, peg_h);
        for(i = [-7:7]){
            for(j = [-0.5,0.5]){
                translate([peg_h * i, peg_h * j, 0])
                cylinder_base(peg_r, peg_h * 2, roundness);
            }
        }
    }
}

module peg_board_2x11(){
    difference(){
        cube_base(peg_h * 11 + link_t * 1.5, parallax_servo_w + link_t * 2, peg_h);
        for(i = [-5:5]){
            for(j = [-0.5,0.5]){
                translate([peg_h * i, peg_h * j, 0])
                cylinder_base(peg_r, peg_h * 2, roundness);
            }
        }
    }
}

module peg_board_2x5(){
    difference(){
        cube_base(peg_h, peg_h * 5, peg_h * 2);//parallax_servo_l + link_t * 2 + cube_allowance, parallax_servo_w + link_t * 2);
        for(i = [-2:2]){
            for(j = [-0.5,0.5]){
                rotate([0, 90, 0])
                translate([peg_h * j,peg_h * i, 0])
                cylinder_base(peg_r, peg_h * 2, roundness);
            }
        }
    }
}

module peg_board_2x3(){
    difference(){
        cube_base(peg_h, (parallax_servo_l + link_t * 2 + cube_allowance - peg_h * 2), parallax_servo_w + link_t * 2);
        for(i = [-1:1]){
            for(j = [-0.5,0.5]){
                rotate([0, 90, 0])
                translate([peg_h * j,peg_h * i, 0])
                cylinder_base(peg_r, peg_h * 2, roundness);
            }
        }
    }
}

module peg_board_3x3(){
    difference(){
        cube_base(peg_h * 3, peg_h * 3, peg_h);
        for(x = [-1:1]){
            for(y = [-1:1]){
                translate([peg_h * x,peg_h * y, 0])
                cylinder_base(peg_r, peg_h, roundness);
            }
        }
    }
}

module zig_standoff(){
    wheel_clearance = 22;
    pos_peg_x = [-1, 0, 1];
    pos_peg_y = [0, -1, 0];
    standoff_h = (parallax_wing_w/2 + peg_h/2 + peg_h- link_t * 2) + peg_h * 2 + wheel_clearance;
    union(){
        cube_base(standoff_w, peg_h, standoff_h/2);
        translate([peg_h/2, 0, -peg_h])
        cylinder_base(peg_r - rad_allowance, standoff_h/2, roundness);
        translate([-peg_h/2, 0, -peg_h])
        cylinder_base(peg_r - rad_allowance, standoff_h/2, roundness);
    }
    translate([peg_h, 0, standoff_h/2 - peg_h/2])
    difference(){
        
        difference(){
            cube_base(standoff_w, peg_h, standoff_h/2 + peg_h);
            translate([peg_h/2, 0, 0])
            cylinder_base(peg_r, standoff_h/2 + peg_h, roundness);
            translate([-peg_h/2, 0, 0])
            cylinder_base(peg_r, standoff_h/2 + peg_h, roundness);
        }
        
        for(x = [-1, 1]){
            for(y = [-1, 1]){
                translate([peg_h * x, peg_h/2 * y, 0])
                rotate([0, 0, -45 * x*y])
                scale([2, 1, 1])
                cylinder_base(link_t, standoff_h/2 + peg_h, roundness);
            }
        }
    }
}

module standoff(){
    wheel_clearance = 22;
    pos_peg_x = [-1, 0, 1];
    pos_peg_y = [0, -1, 0];
    standoff_h = (parallax_wing_w/2 + peg_h/2 + peg_h- link_t * 2) + peg_h * 2 + wheel_clearance;
    standoff_r = sqrt(pow(peg_h * 3, 2) + pow(peg_h * 3, 2))/2;
    difference(){
        union(){
            difference(){
                scale([0.8, 1, 1]) 
                cylinder_base(standoff_r, standoff_h, roundness);
                translate([0, 0, standoff_h/2 - peg_h/2])
                cube_base(peg_h * 3, peg_h * 3, peg_h);
                translate([0, 0, -(standoff_h/2 - peg_h/2)])
                cube_base(peg_h * 3, peg_h * 3, peg_h);
                
                for(x = [-1:1]){
                    for(y = [-1:1]){
                        translate([peg_h * x,peg_h * y, 0])
                        cylinder_base(peg_r, peg_h * 3, roundness);
                    }
                }
                
            }
            difference(){
                union(){
                    translate([0, 0, standoff_h/2 - peg_h/2])
                    peg_board_3x3();
                    translate([0, 0, -(standoff_h/2 - peg_h/2)])
                    peg_board_3x3();
                }
                difference(){
                    cylinder_base(standoff_r, standoff_h, roundness);
                    scale([0.8, 1, 1]) 
                    cylinder_base(standoff_r, standoff_h, roundness);
                }
            }
        }
        translate([0, peg_h * 1.85, 0])
        cube_base(peg_h * 4, peg_h * 1, standoff_h);
    }
    for(i = [0:2]){
        translate([peg_h * pos_peg_x[i], peg_h * pos_peg_y[i], standoff_h/2 + peg_h/2])
            cylinder_base(peg_r - rad_allowance, peg_h, roundness);
            translate([peg_h * pos_peg_x[i], peg_h * pos_peg_y[i], 0])
            cylinder_base(peg_r, standoff_h, roundness);
    }
}

//standoff();

module battery_mount_v2(){
    
    translate([0,  puzzle_dim - peg_h, -(peg_h/2 + battery_h/2 + cube_allowance)])
    rotate([0, 0, 90])
    half_puzzle();
    translate([0,  -(puzzle_dim - peg_h), -(peg_h/2 + battery_h/2 + cube_allowance)])
    rotate([0, 0, -90])
    half_puzzle();
    translate([0, 0, -(peg_h/2 + battery_h/2 + cube_allowance)])
    cube_base(battery_w + link_t * 2, battery_l - puzzle_dim - peg_h * 4 - cube_allowance * 2, peg_h);
    /*
    translate([0, 0, - cube_allowance])
    rotate([0, 0, 90])
    difference(){
        union(){
            difference(){
                //cube_base(battery_l + link_t * 2, battery_w + link_t * 2, battery_h + link_t);
                cube_base(battery_l - puzzle_dim/2 - peg_h * 2 - cube_allowance * 4, battery_w + link_t * 2, battery_h);
                for(x = [-1,1]){
                    for(y = [-1, 1]){
                        translate([(battery_l - puzzle_dim/2 - peg_h + link_t * 1.5) * x, (battery_w/2 + link_t/2) * y, 0])
                        cube_base(link_t, link_t, battery_h + link_t * 2);
                    }
                }
            }
            
        }
        translate([0, 0, link_t])
        cube_base(battery_l, battery_w, battery_h);
        translate([battery_l/2 + link_t/2, battery_w/4, link_t/2])
        cube_base(link_t, battery_w/2, battery_h);
        
        for(x = [-1.5, 0, 1.5]){
            translate([(battery_l/4 - link_t) * x, 0, link_t])
            cube_base(battery_l * 0.2, battery_w + link_t * 3, battery_h - link_t);
        }
    }*/
    
    
        
}
battery_mount_v3();
module battery_mount_v3(){
    clip_w = battery_w  - cube_allowance;
    //translate([0, 0, -(peg_h/2 + battery_h/2 + cube_allowance)])
    //battery_l = 30;//FOR TESTING ONLY.
    difference(){
        //cube_base(battery_w + link_t * 2, battery_l, peg_h);
        cube_base(clip_w, battery_l + link_t * 2 - cube_allowance, peg_h);
        
        //Vents
        for(v = [-1:1]){
            translate([clip_w * 0.3 * v, 0, 0])
            cube_base(clip_w * 0.125, battery_l - peg_r * 8 - link_t, peg_h);
        }
        
        //Clips
        translate([0, battery_l/2 - peg_r - link_t * 2, 0]){
            cube_base(battery_w + link_t * 2, peg_r * 2, peg_h);
            translate([0, (peg_h/2 - link_t * 0.75) + link_t * 0.5, -peg_h/2])
            cube_base(clip_w, link_t, link_t * 4);
        }
        
        translate([0, battery_l/2 - peg_r + link_t * 2, - link_t/2])
        cube_base(battery_w + link_t * 2, peg_r * 2, peg_h - link_t);
        translate([0, battery_l/2 - link_t/2, -link_t/2])
        cube_base(battery_w + link_t * 2, link_t, peg_h - link_t);
        
        mirror([0, 1, 0]){
            translate([0, battery_l/2 - peg_r - link_t * 2, 0]){
                cube_base(battery_w + link_t * 2, peg_r * 2, peg_h);
                translate([0, (peg_h/2 - link_t * 0.75) + link_t * 0.5, -peg_h/2])
                cube_base(clip_w, link_t, link_t * 4);
            }  
            
            translate([0, battery_l/2 - peg_r + link_t * 2, - link_t/2])
            cube_base(battery_w + link_t * 2, peg_r * 2, peg_h - link_t);
            translate([0, battery_l/2 - link_t/2, -link_t/2])
            cube_base(battery_w + link_t * 2, link_t, peg_h - link_t);
        }
        
    }  
    
    translate([0, battery_l/2 - peg_r - link_t * 2, 0])
    rotate([0, 90, 0])
    difference(){
        cylinder_base(link_t/4 + peg_h/2, clip_w, roundness);
        cylinder_base(peg_h/2 - link_t * 0.75, clip_w, roundness);
        translate([-(link_t/2 + peg_h/2)/2, 0, 0])
        cube_base(link_t/2 + peg_h/2, (link_t/2 + peg_h/2) * 2, battery_w + link_t * 2);
    }
    
    mirror([0, 1, 0]){
        translate([0, battery_l/2 - peg_r - link_t * 2, 0])
        rotate([0, 90, 0])
        difference(){
            cylinder_base(link_t/4 + peg_h/2, clip_w, roundness);
            cylinder_base(peg_h/2 - link_t * 0.75, clip_w, roundness);
            translate([-(link_t/2 + peg_h/2)/2, 0, 0])
            cube_base(link_t/2 + peg_h/2, (link_t/2 + peg_h/2) * 2, battery_w + link_t * 2);
        }
    }
}
/*
 //battery_l = 30;//FOR TESTING ONLY.
translate([0, 0, -(link_t + cube_allowance)])
    difference(){
        cube_base(battery_w + link_t * 4, battery_l + link_t * 0, peg_h + link_t + cube_allowance);
        translate([0, 0, (link_t + cube_allowance)/2])
        cube_base(battery_w + link_t * 2 + cube_allowance, battery_l -link_t * 2+ cube_allowance, peg_h);
    }
*/
//sensor_mount_deck();
/*rotate([180, 0, 0])
translate([0, 0, battery_h + 5])
//tweak battery mount dimensions to fit hole in power base.
battery_mount_v3();
bumper_servo_power_base();
*/
/*
difference(){
    battery_mount_v2();
    translate([0, (puzzle_dim + peg_h)/2, -(peg_h/2 + battery_h/2 + cube_allowance)])
    cube_base(battery_w + link_t * 2.5, puzzle_dim + peg_h, peg_h);
}*/

/*
//Servos
translate([-(servo_wing_r - parallax_servo_h/2 - link_t), parallax_hole_off, 0])
rotate([0, -90, 0])
parallax_servo();
translate([servo_wing_r - parallax_servo_h/2 - link_t, parallax_hole_off, 0])
rotate([0, 90, 0])
parallax_servo();
*/
module half_puzzle(){
    
    difference(){
        cube_base(puzzle_dim, puzzle_dim, peg_h);
        translate([0, 0, -peg_h * 0.34])
        cylinder_base((battery_w - peg_h) * 0.5, peg_h * 0.34, roundness);
        cylinder_base((battery_w - link_t) * 0.5, peg_h * 0.34, roundness);
        translate([0, (battery_w + peg_h) * 0.25, -peg_h * 0.34])
        cube_base(peg_h, (battery_w - peg_h * 1.5) * 0.5, peg_h * 0.34);
        translate([0, -(battery_w + peg_h) * 0.25, -peg_h * 0.34])
        cube_base(peg_h, (battery_w - peg_h * 1.5) * 0.5, peg_h * 0.34);
        
        translate([(puzzle_dim) * 0.25, 0, 0])
        cube_base((puzzle_dim) * 0.5, puzzle_dim, peg_h);
    }
    //translate([0, 0, peg_h * 0.34])
    
    difference(){
        cylinder_base((battery_w) * 0.5 - rad_allowance, peg_h * 0.34, roundness);
        cylinder_base((battery_w) * 0.5 - peg_h, peg_h * 0.34, roundness);
        translate([0, ( ((battery_w) * 0.5 + peg_h - rad_allowance) - peg_h * 0.5 )/2, 0]) 
        cube_base(((battery_w) * 0.5  + peg_h - rad_allowance) * 2, ((battery_w) * 0.5  + peg_h - rad_allowance) + peg_h * 0.5, peg_h * 0.34);
        translate([( ((battery_w) * 0.5  + peg_h - rad_allowance) - peg_h * 0.5 )/2, 0, 0]) 
        cube_base(((battery_w) * 0.5  + peg_h - rad_allowance) + peg_h * 0.5, ((battery_w) * 0.5  + peg_h - rad_allowance) * 2, peg_h * 0.34);
    }
}

module key(){
    //translate([0, 0, -peg_h * 0.66 + peg_h * 0.16])
    difference(){
        cylinder_base((battery_w - peg_h) * 0.5 - rad_allowance * 2, peg_h * 0.34 - cube_allowance * 3, roundness);
        translate([0, 0, -peg_h * 0.82])
        rotate([90, 0, 0])
        cylinder_base(20/2, 2, roundness);
    }
    translate([0, 0, peg_h * 0.34 - cube_allowance]){
        translate([0, 0, -cube_allowance * 1.5])
        difference(){
            cylinder_base((battery_w) * 0.5 - peg_h - rad_allowance, peg_h * 0.34 + cube_allowance * 2, roundness);
            translate([0, 0, -peg_h * 0.82 - 1.25 - cube_allowance * 0.28   ])
            rotate([90, 0, 0])
            cylinder_base(20/2, 2, roundness);
        }   
        //arms
        translate([0, (battery_w + link_t) * 0.25, 0])
        cube_base(peg_h - cube_allowance, (battery_w + link_t) * 0.5 - cube_allowance - peg_h, peg_h * 0.34 - cube_allowance);
        translate([0, -(battery_w + link_t) * 0.25, 0])
        cube_base(peg_h - cube_allowance, (battery_w + link_t) * 0.5 - cube_allowance - peg_h, peg_h * 0.34 - cube_allowance);
        translate([0, (battery_w + link_t) * 0.25 + peg_h * 0.55 - cube_allowance, 0])
        cylinder_base((peg_h - cube_allowance)/2, peg_h * 0.34 - cube_allowance, roundness);
        translate([0, -(battery_w + link_t) * 0.25 - peg_h * 0.55 + cube_allowance, 0])
        cylinder_base((peg_h - cube_allowance)/2, peg_h * 0.34 - cube_allowance, roundness);
    }
}
/*
translate([0,  puzzle_dim - link_t - peg_h + cube_allowance, -(peg_h/2 + battery_h/2 + cube_allowance) - peg_h])
rotate([0, 0, -90])
key();

translate([0,  -(puzzle_dim * 0.75 + link_t+ cube_allowance*2), -(peg_h/2 + battery_h/2 + cube_allowance) - peg_h/4])
rotate([0, 0, -90])
key();*/

module bumper_servo_power_base(){
    pos_peg_x = [-5, -3, 3, 5, -5, 5, -3, -4, 3, 4];
    pos_peg_y = [-5, -5, -5, -5, -3, -3, 5, 5, 5, 5];
    //parallax_servo_l - link_t * 2;
    
    //Servo Mounts
    translate([-(servo_wing_r), parallax_hole_off, 0])
    servo_wing_mount();
    translate([servo_wing_r, parallax_hole_off, 0])
    servo_wing_mount();
    
    
    /*
    translate([0, battery_l/2 - (puzzle_dim)/2 + link_t, -(peg_h/2 + battery_h/2 + cube_allowance)])
    rotate([0, 0, -90])
    half_puzzle();
    translate([0, -(battery_l/2 - (puzzle_dim)/2 + link_t), -(peg_h/2 + battery_h/2 + cube_allowance)])
    rotate([0, 0, 90])
    half_puzzle();*/
    
    difference(){
        translate([0, 0, -(peg_h/2 + battery_h/2 + cube_allowance)])
        cylinder_base(bsp_r, peg_h, roundness);
        translate([0, 0, -(peg_h/2 + battery_h/2 + cube_allowance)])
        cube_base(battery_w + link_t * 2, battery_l + link_t * 2, peg_h);
        
       //Peg board holes
        for(x = [-5, -4, -3, 3, 4, 5]){
            for(y = [-5:5]){
                translate([peg_h * x, peg_h * y, -(peg_h/2 + battery_h/2 + cube_allowance)])
                cylinder_base(peg_r, peg_h * 2, roundness);
            }
        }
        
        //Wheels
        translate([-(servo_wing_r + link_t + 10 - cube_allowance), 0, -parallax_servo_l/4])
        rotate([0, 90, 0])
        cylinder_base(32.5 + rad_allowance, 14, roundness);
        translate([(servo_wing_r + link_t + 10 - cube_allowance), 0, -parallax_servo_l/4])
        rotate([0, 90, 0])
        cylinder_base(32.5 + rad_allowance, 14, roundness);
        //BumpInsert
        translate([0, 0, -(battery_h/2 + cube_allowance + peg_h/2)]){
            difference(){
                cylinder_base(bsp_r, peg_h + link_t, roundness);
                cylinder_base(bsp_r - peg_h, peg_h + link_t, roundness);
                cube_base(wheel_base_cutout * 2, bsp_r + peg_h * 2, peg_h + link_t);
            }
            for(x = [-1, 1]){
                for(y = [-1, 1]){
                    translate([servo_wing_r * x, (bsp_r + peg_h * 1)/2 * y, 0])
                    rotate([90, 0, 0])
                    cylinder_base(peg_r, peg_h, roundness);
                }
            }
            translate([0, bsp_r - peg_h * 1.5, 0])
            rotate([90, 0, 0])
            cylinder_base(peg_r, peg_h, roundness);
            translate([0, -(bsp_r - peg_h * 1.5), 0])
            rotate([90, 0, 0])
            cylinder_base(peg_r, peg_h, roundness);
        }
    }
    //Positive Pegs
    for(i = [0:9]){
        translate([peg_h * pos_peg_x[i], peg_h * pos_peg_y[i], -(peg_h/2 + battery_h/2 + cube_allowance) + peg_h])
        cylinder_base(peg_r - rad_allowance, peg_h, roundness);
        translate([peg_h * pos_peg_x[i], peg_h * pos_peg_y[i], -(peg_h/2 + battery_h/2 + cube_allowance)])
        cylinder_base(peg_r, peg_h, roundness);
    }
    
    //Ends of battery mount
    rotate([0, 0, 90])
    translate([0, 0, -peg_h/2 + link_t/2 - cube_allowance])
    difference(){
        union(){
            difference(){
                cube_base(battery_l + link_t * 2, battery_w + link_t * 2, battery_h + link_t);
                //cube_base(battery_l - puzzle_dim/2 - peg_h * 2 - cube_allowance * 2, battery_w + link_t * 2, battery_h + link_t + peg_h);
                for(x = [-1,1]){
                    for(y = [-1, 1]){
                        translate([(battery_l/2 + link_t/2) * x, (battery_w/2 + link_t/2) * y, 0])
                        cube_base(link_t, link_t, battery_h + link_t * 2);
                    }
                }
            }
            for(x = [-1,1]){
                for(y = [-1, 1]){
                    translate([(battery_l/2 + link_t/4) * x, (battery_w/2 + link_t/4) * y, 0])
                    cylinder_base(sqrt(pow(link_t, 2) + pow(link_t, 2))/2, battery_h + link_t, roundness);
                }
            }
        }
        translate([0, 0, link_t/2])
        cube_base(battery_l, battery_w, battery_h + link_t * 2);
        translate([battery_l/2 + link_t/2, battery_w/4, link_t * 0.5])
        cube_base(link_t, battery_w/2, battery_h);
        
        for(x = [-1.5, 0, 1.5]){
            translate([(battery_l/4 - link_t) * x, 0, link_t])
            cube_base(battery_l * 0.2, battery_w + link_t * 3, battery_h - link_t);
        }
    }
    /*translate([0, 0, - peg_h + cube_allowance])
    rotate([0, 0, 90])
    battery_mount_v2();*/
}

module bumpers(){
    
    difference(){
        cylinder_base(bumper_r, peg_h, roundness);
        cylinder_base(bsp_r - peg_h, peg_h, roundness);
        cube_base(wheel_base_cutout * 2, bsp_r + peg_h * 2, peg_h);
        for(theta = [-4:4]){
            rotate([0, 0, 10 * theta])
            translate([0, -(bsp_r - peg_h/2), 0])
            cylinder_base(peg_r, peg_h, roundness);
        }
    }
    for(x = [-1, 1]){
        for(y = [-1, 1]){
            translate([servo_wing_r * x, (bsp_r + peg_h * 1)/2 * y, 0])
            rotate([90, 0, 0])
            cylinder_base(peg_r - rad_allowance, peg_h, roundness);
        }
    }
    translate([0, bsp_r - peg_h * 1.25, 0])
    rotate([90, 0, 0])
    cylinder_base(peg_r - rad_allowance, peg_h/2, roundness);
    translate([0, -(bsp_r - peg_h * 1.25), 0])
    rotate([90, 0, 0])
    cylinder_base(peg_r - rad_allowance, peg_h/2, roundness);

    translate([0, 0, bumper_h - peg_h * 2 + link_t/2])
    difference(){
        cylinder_base(bumper_r, bumper_h, roundness);
        cylinder_base(bumper_r - link_t, bumper_h, roundness);
        //cube_base(wheel_base_cutout * 2, bump_cutout_w, bumper_h);
    }
    
    
}

module bumper_guards(){
    outer_h = 8;
    /*
    translate([0, 0, -bumper_h/4 + link_t/2 -cube_allowance])
    difference(){
        //cylinder_base(bumper_r + rad_allowance + link_t * 1.25, link_t, roundness);
        //cylinder_base(bump_sphere_r, link_t, roundness);
        cylinder_base(bumper_r, link_t, roundness);
        cylinder_base(bsp_r - peg_h, link_t, roundness);
        
        translate([0, -(bsp_r - peg_h/2), -link_t])
        cylinder_base(caster_w/2 + link_t, peg_h, roundness);
        translate([0, (bsp_r - peg_h/2), -link_t])
        cylinder_base(caster_w/2 + link_t, peg_h, roundness);
        
        //Wheel cutouts
        for(x = [-1,1]){
            translate([(bsp_r - peg_h) * x, -bsp_r * 0.3, 0])
            scale([1.5, 1.75, 1])
            cylinder_base(peg_h * 1.25, link_t * 2, roundness);
            //cube_base(peg_h * 3, peg_h * 2, peg_h);
        }
    }*/
    difference(){
        union(){
            translate([0, 0, (bumper_h/2 - peg_h/1) * 2 + link_t/2])
            rotate([0, 0, 10])
            difference(){
                cylinder_base(bumper_r - cube_allowance, (bumper_h - peg_h + link_t)/2, roundness);
                cylinder_base(bumper_r - link_t, (bumper_h - peg_h + link_t)/2, roundness);
                translate([0, bumper_r/2 + link_t * 3, 0])
                cube_base(bumper_r*2, bumper_r*2, bumper_h);
            }
            translate([0, 0, bumper_h/2 - link_t/2])
            difference(){
                cylinder_base(bumper_r + link_t * 2, link_t, roundness);
                cylinder_base(bumper_r - cube_allowance, link_t, roundness);
            }
            
        }
        translate([-bumper_r * 0.7, bumper_r * 0.14, link_t * 1.5])
        cube_base((bumper_r + link_t) * 0.35, (bumper_r + link_t) * 2, bumper_h * 0.75);
    }
    
    translate([0, 0, bumper_h/4 + link_t * 1.88 - outer_h/2])
    difference(){
        cylinder_base(bumper_r + link_t + 4, link_t + outer_h, roundness);
        cylinder_base(bumper_r + link_t + cube_allowance, link_t + outer_h, roundness);
        //Make a nice join with the bumper
        translate([0, 0, - (0.65 + 1.25 + outer_h * 0.5)])
        rotate_extrude(convexity = 10)
        translate([bumper_r + link_t * 2 + 1, 0, 0])
        rotate([0, 0, 45])
        scale([1, 1, 1.25])
        square(size = 4, center = true);
        //circle(r = 2.5, $fn = 200);
    }
    //The bumper itself
    
    translate([0, -4, - 3.5])
    difference(){

        rotate_extrude(convexity = 10, $fn = roundness)
        translate([bumper_r + link_t * 2 + 1, 0, 0])
        scale([0.8, 1, 1.25])
        circle(r = 6, $fn = roundness);
        //circle(r = 2.5, $fn = roundness);
        
        rotate_extrude(convexity = 10, $fn = roundness)
        translate([bumper_r + link_t * 2 + 1, 0, 0])
        scale([0.8, 1, 1.25])
        //square(size = 10, center = true);
        circle(r = 4, $fn = roundness);
        /*
        rotate_extrude(convexity = 10, $fn = roundness)
        translate([bumper_r + link_t * 2 + 1, 0, 0])
        rotate([0, 0, 45])
        scale([1, 1, 1.25])
        square(size = 5, center = true);*/
    }
    //The bumper itself
    /*
    translate([0, 0, -0.65])
    difference(){

        rotate_extrude(convexity = 10, $fn = roundness)
        translate([bumper_r + link_t * 2 + 1, 0, 0])
        rotate([0, 0, 45])
        scale([1, 1, 1.25])
        square(size = 5, center = true);
        //circle(r = 2.5, $fn = roundness);
        
        rotate_extrude(convexity = 10, $fn = roundness)
        translate([bumper_r + link_t * 2 + 1, 0, 0])
        rotate([0, 0, 45])
        scale([1, 1, 1.25])
        square(size = 4, center = true);
        //circle(r = 1.5, $fn = roundness);
    }*/
    
    difference(){
        union(){
            translate([0, 0, (bumper_h/2 - peg_h/1) * 2 + link_t/2])
            difference(){
                cylinder_base(bumper_r - link_t * 1, (bumper_h - peg_h + link_t)/2, roundness);
                cylinder_base(bumper_r - link_t * 2, (bumper_h - peg_h + link_t)/2, roundness);
            }
            translate([0, 0, bumper_h/2 - link_t/2])
            difference(){
                cylinder_base(bumper_r + link_t * 2, link_t, roundness);
                cylinder_base(bumper_r - link_t, link_t, roundness);
            }
        }
        translate([bumper_r * 0.5, 0, bumper_h/2 - link_t/2])
        cube_base((bumper_r + link_t) * 2, (bumper_r + link_t) * 2, bumper_h * 0.75);
        translate([0, bumper_r * 0.5, bumper_h/2 - link_t/2])
        cube_base((bumper_r + link_t) * 2, (bumper_r + link_t) * 2, bumper_h * 0.75);
    }

}


//Caster
module caster(){
    
    //translate([caster_w/2, 0, (peg_h - cube_allowance)/2])
    //cylinder_base(peg_r - rad_allowance, peg_h - cube_allowance, roundness);
    translate([0, 0, (peg_h - cube_allowance)/2 + 1.5])
    cylinder_base(peg_r - rad_allowance, peg_h - cube_allowance, roundness);
    translate([0, 0, -1.5])
    cylinder_base(peg_h, 6, roundness);
    scale([((caster_w + peg_r*2)/2)/((caster_w + peg_r*2)/2 - 3), ((caster_w + peg_r*2)/2)/((caster_w + peg_r*2)/2 - 3), 1])
    difference(){
        sphere_base((caster_w + peg_r*2)/2 - 3, roundness);
        translate([0, 0, ((caster_w + peg_r*2))/2 - caster_h/2 - 2.25])
        cube_base((caster_w + peg_r*2), (caster_w + peg_r*2), (caster_w + peg_r*2) - caster_h +1.5);
    }
}

module LDRMount(){
    jst_l = 8 + cube_allowance;
    jst_w = 5 + cube_allowance;
    jst_h = 11 + cube_allowance;
    //Main body
    translate([0, 0, -peg_h/2])
    cylinder_base(peg_r - rad_allowance, peg_h, roundness);
    translate([0, 0, (jst_h + link_t)/2])
    difference(){
        cube_base(jst_w + link_t/2, jst_l + link_t, jst_h + link_t);
        translate([link_t/4, 0, link_t/2])
        cube_base(jst_w, jst_l, jst_h + link_t);
    }
    //Top pinch
    /*
    translate([0, 0, jst_h + link_t/2])
    difference(){
        cube_base(jst_w + link_t/2, jst_l + link_t, link_t);
        cube_base(jst_w + link_t/2, jst_l - link_t, link_t);
    }*/
    translate([jst_w/2 + 2 - link_t/2, 0, (jst_h)/2 + link_t/2])
    difference(){
        cube_base(link_t + 2, jst_l + link_t * 3, jst_h + link_t);
        cube_base(jst_w + 0, jst_l + link_t, jst_h + link_t);
    }
    translate([jst_w/2 + link_t * 1.75, 0, (jst_h)/2 + link_t/2])
    difference(){
        cube_base(link_t/2, jst_l + link_t * 3, jst_h + link_t);
        cube_base(jst_w, jst_l - cube_allowance * 2, jst_h + link_t);
    }
}

module mount_IR()
{
    case_length  = 30;
    case_width   = 14;
    case_height  = 7.5;
    
    plug_length  = 10;
    plug_width   = 5;
    plug_height  = 7;
    
    tab_radius   = 8/2;
    tab_height   = 2;
    
    screw_radius = 3/2;
    screw_height = 2;
    
    wall = 3;
    
    //translate([0, 0, -(tab_height * 1.25 + 0.25)])
    
    //Plug will be subtracted from the sleave made by everything else
    //translate([0, case_width/2 + plug_width/2, -(case_height + cube_allowance - tab_height * 1.5)/2]) 
    //cube_base(plug_length, plug_width, tab_height * 1.5);
    //translate([0, case_width/2 + plug_width/2, case_height/2])
    //cube_base(plug_length, plug_width, plug_height);
    rotate([90, 0, 0])
    translate([0, 0, peg_h/2 + (case_width + cube_allowance + wall)/2])
    cylinder_base(peg_r - rad_allowance, peg_h, roundness);
    
    difference()
    {
        //scale([1, 1, 1])
        cube_base(case_length + cube_allowance + (tab_radius + rad_allowance) * 4 + wall, case_width + cube_allowance + wall, (peg_r - rad_allowance) * 2);//tab_height + cube_allowance);
        
        //Bevels
        translate([-case_length/2, -(case_width + cube_allowance + wall)/2, -(tab_height + cube_allowance + wall)/2])
        rotate([45, 0, 0])
        cube_base((case_length + cube_allowance + (tab_radius + rad_allowance) * 4 + wall)/2, wall, wall);
        translate([case_length/2, -(case_width + cube_allowance + wall)/2, -(tab_height + cube_allowance + wall)/2])
        rotate([45, 0, 0])
        cube_base((case_length + cube_allowance + (tab_radius + rad_allowance) * 4 + wall)/2, wall, wall); 
        translate([0, (case_width + cube_allowance + wall)/2, -(tab_height + cube_allowance + wall)/2])
        rotate([45, 0, 0])
        cube_base(case_length + cube_allowance + (tab_radius + rad_allowance) * 4 + wall, wall, wall); 
        
        translate([0, ((case_width + cube_allowance) * 0)/2, ((peg_r - rad_allowance)*2+wall/4)])
        union()
        {
            cube_base(case_length + cube_allowance, case_width + cube_allowance, case_height + cube_allowance);
            translate([case_length/2 + tab_radius, 0, -(case_height + cube_allowance)/2 + (tab_height + cube_allowance)/2])
            union()
            {
                cylinder_base(tab_radius + rad_allowance, tab_height + cube_allowance);
                translate([-tab_radius + rad_allowance, 0, tab_height/2])
                cube_base((tab_radius + rad_allowance) * 2, (tab_radius + rad_allowance) * 2, tab_height * 2 + cube_allowance);
               
            }
            
            translate([-(case_length/2 + tab_radius), 0, -(case_height + cube_allowance)/2 + (tab_height + cube_allowance)/2])
            union()
            {
                cylinder_base(tab_radius + rad_allowance, tab_height + cube_allowance);
                translate([tab_radius + rad_allowance, 0, tab_height/2])
                cube_base((tab_radius + rad_allowance) * 2, (tab_radius + rad_allowance) * 2, tab_height * 2 + cube_allowance);
            }
             
        }
        /*
        translate([case_length/2 + tab_radius, 0, 0])
        cylinder_base(screw_radius + rad_allowance, tab_height + cube_allowance + wall, roundness);
        translate([- (case_length/2 + tab_radius), 0, 0])
        cylinder_base(screw_radius + rad_allowance, tab_height + cube_allowance + wall, roundness);
        */
    }
    
    translate([case_length/2 + tab_radius - 0.75, 0, peg_h/4])
    cylinder_base(1.5 - rad_allowance, tab_height * 3 + cube_allowance, roundness);
    translate([- (case_length/2 + tab_radius - 0.75), 0, peg_h/4])
    cylinder_base(1.5 - rad_allowance, tab_height * 3 + cube_allowance, roundness);
}

module IRCap(){
    case_length  = 30;
    case_width   = 14;
    case_height  = 7.5;
    
    plug_length  = 10;
    plug_width   = 5;
    plug_height  = 7;
    
    tab_radius   = 8/2;
    tab_height   = 2;
    
    screw_radius = 3/2;
    screw_height = 2;
    
    wall = 3;
    difference(){
        cylinder_base(1.5 + link_t/2, tab_height * 2 + cube_allowance, roundness);
        translate([0, 0, -link_t/2])
        cylinder_base(1.5, tab_height * 2 + cube_allowance, roundness);
    }
}

module custom_wheel(){
    horn_r     = 23;
    horn_h     = 2;
    wheel_r    = horn_r + 4;
    wheel_h    = 4;
    hole_dist  = 20;

    //parallax_wing();
    difference(){
        cylinder_base(horn_r, horn_h, roundness);
        for(i = [-2, -1, 1, 0]){
            rotate([0, 0, 90 * i]){
                translate([hole_dist, 0, 0])
                cylinder_base(3, horn_h, roundness);
                translate([hole_dist + 1.5, 0, 0])
                cube_base(3, 4, horn_h);
            }
        }
        cylinder_base(3, horn_h, roundness);
    }
    translate([0, 0, -horn_h])
    difference(){
        cylinder_base(horn_r, horn_h, roundness);
        for(i = [-2, -1, 1, 0]){
            rotate([0, 0, 90 * i]){
                translate([hole_dist, 0, 0])
                cylinder_base(5, horn_h, roundness);
            }
        }
        cylinder_base(3, horn_h, roundness);
    }

    translate([0, 0, -(horn_h/2 + wheel_h/2) - horn_h])
    difference(){
        cylinder_base(wheel_r, wheel_h, roundness);
        for(i = [-2, -1, 1, 0]){
            rotate([0, 0, 90 * i])
            translate([horn_r/2 + 3, 0, 0])
            scale([1, 0.5, 1])
            cylinder_base(horn_r/2, wheel_h, roundness);
        }
        cylinder_base(3, wheel_h, roundness);
    }
}

//Wheels
//translate([-(parallax_servo_h + parallax_wing_h + link_t * 5 + 30), 0, 0])
//    rotate([0, 90, 0])
module parallax_tire(){
    tire_r = 30;
    tire_t = 2;//4;
    tire_w = 6;
    tire_d = 1; 
    guard_r = 2;
    difference(){
        cylinder_base(tire_r + rad_allowance + tire_t + guard_r, tire_w + tire_d * 2 + tire_t, roundness);
        cylinder_base(tire_r + rad_allowance - guard_r, tire_w + tire_d * 2 + tire_t, roundness);
        cylinder_base(tire_r + rad_allowance + guard_r, tire_w + cube_allowance, roundness);
        
        for(z = [-1,1]){
            for(r = [0:72]){
                rotate([90, 0, 5*r])
                rotate([0, 0, -45])
                translate([0, 4 * z, tire_r + (rad_allowance + tire_t + guard_r)/2 + 2.25])
                difference(){
                    cube_base(3.25, 3.25, 2);
                    translate([1, 1, 0])
                    cube_base(3.25, 3.25, 2);
                }
            }
        }
        for(r = [0:72]){
            rotate([90, 0, 5*r])
            rotate([0, 0, -45])
            translate([0, 0, tire_r + (rad_allowance + tire_t + guard_r)/2 + 2.5])
            difference(){
                cube_base(3.0, 3.0, 2);
                translate([1, 1, 0])
                cube_base(3.0, 3.0, 2);
            }
        }
    }
}

module bumper_extension1(){
    
    difference(){
        cylinder_base(bumper_r, peg_h, roundness);
        cylinder_base(bsp_r - peg_h, peg_h, roundness);
        cube_base(wheel_base_cutout * 2, bsp_r + peg_h * 2, peg_h);
        for(theta = [-4:4]){
            rotate([0, 0, 10 * theta])
            translate([0, -(bsp_r - peg_h/2), 0])
            cylinder_base(peg_r, peg_h, roundness);
        }
    }
    for(x = [-1, 1]){
        for(y = [-1, 1]){
            translate([servo_wing_r * x, (bsp_r + peg_h * 1)/2 * y, 0])
            rotate([90, 0, 0])
            cylinder_base(peg_r, peg_h, roundness);
        }
    }
    translate([0, bsp_r - peg_h * 1.25, 0])
    rotate([90, 0, 0])
    cylinder_base(peg_r, peg_h/2, roundness);
    translate([0, -(bsp_r - peg_h * 1.25), 0])
    rotate([90, 0, 0])
    cylinder_base(peg_r - rad_allowance, peg_h/2, roundness);
    
}

module bumper_extension2(){
    
    difference(){
        cylinder_base(bumper_r, peg_h, roundness);
        cylinder_base(bsp_r - peg_h, peg_h, roundness);
        cube_base(wheel_base_cutout * 2, bsp_r + peg_h * 2, peg_h);
        for(theta = [-4:4]){
            rotate([0, 0, 10 * theta])
            translate([0, -(bsp_r - peg_h/2), 0])
            cylinder_base(peg_r, peg_h, roundness);
        }
    }
    for(x = [-1, 1]){
        for(y = [-1, 1]){
            translate([servo_wing_r * x, (bsp_r + peg_h * 1)/2 * y, 0])
            rotate([90, 0, 0])
            cylinder_base(peg_r, peg_h, roundness);
        }
    }
    translate([0, bsp_r - peg_h * 1.25, 0])
    rotate([90, 0, 0])
    cylinder_base(peg_r, peg_h/2, roundness);
    translate([0, -(bsp_r - peg_h * 1.25), 0])
    rotate([90, 0, 0])
    cylinder_base(peg_r, peg_h/2, roundness);
    
}

module ez_bot_adapter(){
    ez_power_wall   = 4;
    ez_power_side   = 70 + cube_allowance;
    ez_power_height = 10;
    ez_power_base = (peg_h + link_w * 0.3) * 2;

    difference(){
        cube_base(ez_power_side + ez_power_wall, ez_power_side + ez_power_wall, ez_power_height + ez_power_wall);
        translate([0, 0, ez_power_wall/2])
        cube_base(ez_power_side, ez_power_side, ez_power_height);
        translate([ez_power_side/2 + ez_power_wall/2, 0, ez_power_wall/2])
        cube_base(ez_power_wall, ez_power_side - ez_power_wall * 2, ez_power_height);
    }


    translate([0, 0, -(ez_power_height + ez_power_wall + peg_h/2) * 0.5 + peg_h/2])
    cube_base(ez_power_base - peg_r * 2 + cube_allowance, ez_power_base - peg_r * 2, ez_power_wall);

    translate([0, 0, -(ez_power_height + ez_power_wall + peg_h) * 0.5])
    for(x = [-4,4]){
        translate([peg_h * x, link_w * 0.3, 0])
        cylinder_base(peg_r - rad_allowance, peg_h, roundness);
        translate([peg_h * x, - link_w * 0.3, 0])
        cylinder_base(peg_r - rad_allowance, peg_h, roundness);
    }
}


//BumperExtension... Full
/*
translate([0, -bumper_r * 0.25 + peg_h * 1 + cube_allowance * 1.25, -bumper_h * 0.5 - peg_r - cube_allowance * 2])
difference(){
    bumper_extension1();
    translate([0, peg_h * 1.5, 0])
    bumper_extension2();
    translate([0, -bumper_r * 1, 0])
    cube_base(bumper_r * 2.5, bumper_r * 2.5, bumper_h * 2);
}
rotate([0, 0, 180])
difference(){
    translate([0, 0, -(battery_h/2 + cube_allowance + peg_h/2)])
    bumpers();
    translate([0, 40 + 9, -(battery_h/2 + cube_allowance + peg_h/2) + 5])
    cube_base(172, 140, peg_h + bumper_h + link_t);
}
*/


//bumper_servo_power_base();
//translate([0, 0, peg_h * 3])
/*difference(){
    sensor_mount_deck();
    translate([peg_h * 1.5, link_w * 0.5 + peg_h, -8 - 7])
    cube_base(14, peg_h * 3, 14);
    
    translate([-peg_h * 2.5, link_w * 0.5 + peg_h, -8 - 7])
    rotate([90, 0, 0])
    cylinder_base(7, peg_h * 3, roundness);
}*/
//controller_housing();
/*
//Side 1
difference(){
    //translate([0, 0, - 10])
    sensor_mount_deck();
    rotate([0, 0, 7.5])
    translate([(deck_radius + bearing_r * 2), 0, -peg_h/2])
    cube_base((deck_radius + bearing_r * 2) * 2, (deck_radius + bearing_r * 2) * 2, (peg_h + cube_allowance) * 2);
    
    for(y = [-1,1]){
        rotate([0, 0, 7.5])
        translate([-peg_h/2, deck_radius * y, -peg_h/2])
        rotate([0, 90, 0])
        cylinder_base(peg_r * 2, peg_h, roundness);
    }
}

//Side 2
difference(){
    //translate([0, 0, - 10])
    sensor_mount_deck();
    rotate([0, 0, 7.5])
    translate([-(deck_radius + bearing_r * 2), 0, -peg_h/2])
    cube_base((deck_radius + bearing_r * 2) * 2, (deck_radius + bearing_r * 2) * 2, (peg_h + cube_allowance) * 2);
    
    
}
for(y = [-1,1]){
        rotate([0, 0, 7.5])
        translate([-peg_h/2 + cube_allowance, deck_radius * y, -peg_h/2])
        rotate([0, 90, 0])
        cylinder_base(peg_r * 2 - rad_allowance, peg_h - cube_allowance, roundness);
    }
    */
//caster();
//bumper_guards();

/*
//08 Aug 2018: Bumper Guards
difference(){
    translate([0, 0, -(battery_h/2 + cube_allowance + peg_h/2)])
    bumper_guards();
    translate([bumper_r - 2, -bumper_r/2 + 15.8, -(battery_h/2 + cube_allowance + peg_h/2)])
    cube_base(25, 9, bumper_h + cube_allowance);
    translate([0, 40 + 9, -(battery_h/2 + cube_allowance + peg_h/2) + 5])
    cube_base(190, 140, peg_h + bumper_h + link_t);
    
    
    //translate([-bumper_r * 0.5, 0, -(battery_h/2 + cube_allowance + peg_h/2)])
    //cube_base(bumper_r * 2.5, bumper_r * 2.5, bumper_h);
}
*/
//translate([0, 0, 12])
//IRCap();
//mount_IR();
//LDRMount();
/*
translate([battery_w/2 + peg_h * 2.65, -(battery_l/2 - peg_h * 2.75), 0])
rotate([0, 0, 90])
standoff();
translate([-(battery_w/2 + peg_h * 2.65), -(battery_l/2 - peg_h * 2.75), 0])
rotate([0, 0, -90])
standoff();

translate([battery_w/2 + peg_h * 2.125, (battery_l/2 - peg_h * 1.75), peg_h * 1.125])
rotate([180, 0, 180])
zig_standoff();
translate([-(battery_w/2 + peg_h * 2.125), (battery_l/2 - peg_h * 1.75), peg_h * 1.125])
rotate([180, 0, 0])
zig_standoff();

translate([0, (link_diagonal/2 - caster_w/2 - peg_r/2), -bumper_h+peg_h/2])
caster();
translate([0, -(link_diagonal/2 - caster_w/2 - peg_r/2), -bumper_h+peg_h/2])
caster();
*/
/*
difference(){
    translate([0, 0, -(battery_h/2 + cube_allowance + peg_h/2)])
    bumpers();
    translate([0, 40 + 9, -(battery_h/2 + cube_allowance + peg_h/2) + 5])
    cube_base(180, 140, peg_h + bumper_h + link_t);
}*/



//bumper_servo_power_base();



//cylinder_base(bar_r, bar_l, roundness);
//translate([0, 0, -(bar_l + bearing_r + peg_h/2)])
//          sensor_deck_lock();
//translate([0, 0, parallax_wing_w * 0.75 + link_t + peg_h/2])
//controller_housing();
/*
translate([0, 0, link_b + link_t * 0.5-peg_h/3-0.1])
    difference(){        
        for(x = [1]){
            for(y = [1]){
                translate([(link_w + link_t * 2.0)/2 * x, (link_l + link_t * 2.0)/2 * y, link_b/2 + 3])
                difference(){
                    //cylinder_base(peg_r * 2 + link_t, link_h + link_b, roundness);
                    cylinder_base(peg_r * 2 + link_t, bar_l + peg_h + 2, roundness);
                    translate([(peg_r/2) * x, (peg_r/2) * y, -4 + peg_h])
                    cylinder_base(bar_r, bar_l, roundness);
                    translate([(peg_r/4 - bar_r/2) * x, (peg_r/4 - bar_r/2) * y, -4 + peg_h])
                    rotate([0, 0, 45])
                    cube_base(bar_r *2, bar_r *2, bar_l);
                    translate([(peg_r/4 - bar_r * 1.5) * x, (peg_r/4 - bar_r * 1.5) * y, -4 + peg_h])
                    rotate([0, 0, 45])
                    cube_base(bar_r *2, bar_r *2, bar_l);
                    //cylinder_base(peg_r, link_h + link_b, roundness);
                }
            }
        }
        cube_base(link_w, link_l, link_h + link_b + bar_l + 4);
    }
*/
/*
//Controller housing peg insert
translate([-0, -0, peg_h + link_b + cube_allowance * 2.5])
difference(){
    translate([(link_w/2), (link_l/2), 0])
    rotate([0, 0, 45])
    cube_base(bar_r * 2 - cube_allowance, bar_r * 2 - cube_allowance, bar_l - cube_allowance);
    
    cube_base(link_w, link_l, bar_l - cube_allowance);
    translate([(link_w/2) + link_t * 0.25, (link_l/2) + link_t * 0.25, 0])
    translate([(peg_r/2), (peg_r/2), 0])
    cylinder_base(bar_r, bar_l - cube_allowance , roundness);
}*/
/*
rotate([180, 0, 90])
translate([0, 0, -(peg_h * 4.5 + link_t + peg_h/2)])
sensor_mount_deck();

translate([-(parallax_servo_h + link_t * 5 + 0), parallax_wing_l + peg_r, 0])
rotate([0, -90, 0])
parallax_servo();
translate([(parallax_servo_h + link_t * 5 + 0), parallax_wing_l + peg_r, 0])
rotate([0, 90, 0])
parallax_servo();
*/





/*
    translate([(parallax_servo_h + parallax_wing_h + link_t * 5 + 30), 0, 0])
    rotate([0, 90, 0])
    cylinder_base(32.5 + rad_allowance, 4, roundness);
*/


