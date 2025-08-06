// Settings

// Height of the keyboard spacer
height = 1.7;
// Outer diameter of the main cylinder
outer_d = 8;
// Diameter of the hole
inner_d = 4;
// Width of the rectangular extension
rect_w = 6;
// Height (depth in X-Y) of the rectangular extension
rect_h = 8;

module base_shape() {
    difference() {
        union() {
            // Main cylinder
            cylinder(h=height, d=outer_d, $fn=100);
            
            // Rectangular cuboid on the right
            // which starts at the middle of the cylinder
            translate([0, -rect_h/2, 0])
                cube([rect_w, rect_h, height]);
        }

        // Inner hole
        cylinder(h=height + 0.1, d=inner_d, $fn=100);
    }
}

// Render the 3D object
base_shape();