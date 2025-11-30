// ========================
// Parameters
// ========================
corner_r = 5;    // PCB corner radius

wall_thickness = 2;  // Wall thickness
$fn = 64;              // smooth corners


// Case
case_width = 78;
case_lenght = 97;
case_height = 20;

// Outer cylinder
outer_r = 3;
outer_h = 4;

// Inner hole
hole_r = 3;
hole_h = 2;

// USB-C connector
usbc_l = 10;
usbc_h = 5;

// LED
led_r = 5;

// increase for smoother cone ($fn)
segments = 64;

// ========================
// Case Top Module
// ========================
module case_top() {

    // Translate so inner PCB pocket starts at (0,0)
    translate([corner_r, corner_r, 0]) {
        difference() {
            // Outer shell (walls included)
            linear_extrude(height = case_height)
                rounded_rect(case_width,
                             case_lenght,
                             corner_r);

            // Main hollow interior
            translate([wall_thickness, wall_thickness, wall_thickness])
                linear_extrude(height = 18.5)
                    rounded_rect(case_width-2*wall_thickness, case_lenght-2*wall_thickness, corner_r);
            
            // Top hollow interior
            translate([wall_thickness/2, wall_thickness/2, 18.5-3])
                linear_extrude(height = 5)
                    rounded_rect(case_width-wall_thickness, case_lenght-wall_thickness, corner_r);

            // Mounting hole 1 (top left)
            translate([2, case_lenght-4.5-hole_r*3, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);
            
            // Mounting hole 2 (top right)
            translate([case_width-4.5-hole_r*3+1, case_lenght-4.5-hole_r*3, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);

            // Mounting hole 2 (top right)
            translate([case_width-4.5-hole_r*3+1, hole_h, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);
            
            // Mounting hole 4 (bottom left)
            translate([2, 2, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);
                
            // WS2812B LEDs
            
            // LED bottom left
            translate([17.5, 27, 0])
                cylinder(h = wall_thickness, r = led_r, $fn = segments);
                
            // LED top left
            translate([17.5, 46, 0])
                cylinder(h = wall_thickness, r = led_r, $fn = segments);
                
            // LED bottom right
            translate([50.5, 27, 0])
                cylinder(h = wall_thickness, r = led_r, $fn = segments);
            
            // LED top right
            translate([50.5, 46, 0])
                cylinder(h = wall_thickness, r = led_r, $fn = segments);
            
        }
    }
}

// ========================
// Rounded rectangle module
// ========================
module rounded_rect(x, y, radius) {
    minkowski() {
        square([x - 2*radius, y - 2*radius], center = false);
        circle(r = radius, $fn = $fn);
    }
}

// ========================
// Mounting hole
// ========================
module mounting_hole() {
    difference() {
        // Outer cylinder
        cylinder(h = outer_h, r = outer_r, $fn = 64);
        
        // Inner hole
        translate([0, 0, outer_h-hole_h])  // hole starts at base
            cylinder(h = hole_h, r = hole_r, $fn = 64);
    }
}

module usbc() {
    rotate([90,0,0])
        linear_extrude(height = wall_thickness)
            rounded_rect(usbc_l,usbc_h,1);
}

// ========================
// Top case
// ========================

difference() {
    // Main part of the case
    case_top();  
    // USB-C connector
    translate([1+24, case_lenght, 1+7.8])
       usbc();
}

// ========================
// Visual Tests
// ========================
/*
// Check LED bottom left
translate([0, 27, -10])
    cube([17.5, 10, 30]);

// Check LED top left
translate([0, 46, -10])
    cube([17.5, 10, 30]);

// Check USB-C shorter distance
translate([0, case_lenght, -10])
    cube([24, 4.5, 30]);

// Check USB-C height from bottom
translate([0, case_lenght, 0])
    cube([34, 4.5, 7.8]);

// Check mounting hole 1
translate([0, case_lenght-4.5-20, -10])
    cube([4.5, 20, 30]); 
translate([0, case_lenght-4.5, -10])
    cube([20, 4.5, 30]);

// Check mounting hole 2
translate([case_width-4.5, case_lenght-4.5-20, -10])
    cube([4.5, 20, 30]); 
translate([case_width-20, case_lenght-4.5, -10])
    cube([20, 4.5, 30]);

// Check mounting hole 3
translate([case_width-4.5, 0, -10])
    cube([4.5, 20, 30]); 
translate([case_width-20, 0, -10])
    cube([20, 4.5, 30]);

// Check mounting hole 4
translate([0, 0, -10])
    cube([4.5, 20, 30]); 
translate([0, 0, -10])
    cube([20, 4.5, 30]);
*/