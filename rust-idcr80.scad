// Minimal Double-Sided ID Card Holder
// Target Color: #D34516 (Rust/Burnt Orange)

/* [Card Dimensions] */
card_w = 54.5;
card_h = 86.5;
card_d = 1.0;

/* [Holder Settings] */
wall = 1.5;
lip = 4;        // Minimal 4mm border all around to maximize ID visibility
top_ext = 12;   // Space for lanyard hole

color("#D34516") {
    union() {
        difference() {
            // Main Body Shell
            translate([-wall, -wall, 0])
                cube([card_w + 2*wall, card_h + top_ext + wall, card_d + 2*wall]);
                
            // Inner Slot (Card slides in from the top)
            translate([0, 0, wall])
                cube([card_w, card_h + top_ext + wall + 1, card_d]);
                
            // Double-Sided Window (Cuts all the way through)
            translate([lip, lip, -1])
                cube([card_w - 2*lip, card_h - 2*lip, card_d + 2*wall + 2]);
                
            // Lanyard Hole
            translate([card_w/2, card_h + (top_ext/2), -1])
                hull() {
                    translate([-6, 0, 0]) cylinder(d=4, h=card_d + 2*wall + 2, $fn=30);
                    translate([ 6, 0, 0]) cylinder(d=4, h=card_d + 2*wall + 2, $fn=30);
                }
        }
        
        // --- LOGOS ONLY (No Backing Tab) ---
        // Offset adjusted for the smaller 0.9 scale to ensure the gear still bites into the lip
        logo_offset = 5.5; 
        
        // Y-coordinate (Bottom edge)
        inset_y = lip + logo_offset;
        
        // Front X-coordinate (Right side)
        inset_x_front = card_w - lip - logo_offset; 
        
        // Back X-coordinate (Left side from front view)
        inset_x_back = lip + logo_offset;
        
        // 1. FRONT Logo (Bottom-Right)
        // Extrudes from the inside face through the wall, popping out 0.6mm
        translate([inset_x_front, inset_y, card_d + wall]) {
            linear_extrude(height = wall + 0.6) 
                scale([0.9, 0.9, 1]) import("rust-logo-single-path.svg", center = true);
        }
        
        // 2. BACK Logo (Bottom-Left)
        // Extrudes from the inside face outward, popping out 0.6mm past the back wall
        translate([inset_x_back, inset_y, wall]) {
            mirror([0, 0, 1]) 
                linear_extrude(height = wall + 0.6) 
                    mirror([1, 0, 0]) 
                        scale([0.9, 0.9, 1]) import("rust-logo-single-path.svg", center = true);
        }
    }
}