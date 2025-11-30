// ========================
// Parameters
// ========================
// PCB corner radius
corner_r = 5;    
// Wall thickness
wall_thickness = 2;  
// smooth corners
$fn = 64;              


// Case (2 mm shorter than the bottom, aka 1 mm on each side)
case_width = 76;
case_lenght = 95;
case_height = 2.5;

// Outer cylinder
outer_r = 4;
outer_h = 5;

// Inner hole
hole_r = 2.5;
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
    difference() {
        
        // Translate so inner PCB pocket starts at (0,0)
        union() {
            
            translate([corner_r, corner_r, 0])
            // Outer shell (walls included)
            linear_extrude(height = case_height)
                rounded_rect(case_width,
                             case_lenght,
                             corner_r);
            
            // Rotary encoder border
            translate([13+9, 71+9, 0])
                cylinder(6, 9, 9, $fn = segments);
            
            // Bottom left
            translate([2, 2, case_height])
                mounting_hole(true);
            
            // Bottom right
            translate([case_width-2*outer_r-2, 2, case_height])
                mounting_hole(false);
            
            // Top left
            translate([2, case_lenght-2*outer_r-3, case_height])
                mounting_hole_round();
            
            // Top right
            translate([case_width-2*outer_r-2, case_lenght-2*outer_r-3, case_height])
                mounting_hole_round();
        }
        
        // Inner hollow segment of the keycaps
        translate([7, 9, 0])
            cube([61, 59, 30]);
        
        // Opening for the rotary encoder
        translate([14+8, 72+8, 0])
            cylinder(6, 8, 8, $fn = segments);
        
        // Openings for the buttons
        translate([43, 73, 0])
            cylinder(3, 1, 1, $fn = segments);
        
        translate([51, 73, 0])
            cylinder(3, 1, 1, $fn = segments);
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
// Mounting holes
// ========================
module mounting_hole_round() {
    // Position at start
    translate([outer_r, outer_r, 0]) {
        difference() {
            // Outer cylinder
            cylinder(h = outer_h, r = outer_r, $fn = segments);
            
            // Inner hole
            translate([0, 0, outer_h-hole_h])
                cylinder(h = hole_h, r = hole_r, $fn = segments);
        }
    }
}

module mounting_hole(left = true) {
    tr = left ? 0 : -outer_r;
    // Position at start
    translate([outer_r, outer_r, 0]) {
        difference() {
            
            union() {
                // Outer cylinder
                cylinder(h = outer_h, r = outer_r, $fn = segments);
                translate([tr, -outer_r, 0])
                    cube([4, 8, outer_h]);
                translate([-outer_r, 0, 0])
                    cube([8, 4, outer_h]);
            }
            
            // Inner hole
            translate([0, 0, outer_h-hole_h])
                cylinder(h = hole_h, r = hole_r, $fn = segments);
        }
    }
}

// ========================
// Top case
// ========================

case_top();