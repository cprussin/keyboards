use <smooth-prim/smooth_prim.scad>

nice_nano_depth = 33.3;
nice_nano_width = 18.3;
nice_nano_thickness = 1.7;
nice_nano_usbc_plug_extrusion_depth = 1;
nice_nano_usbc_plug_width = 9;
nice_nano_usbc_plug_depth = 6.4;
nice_nano_usbc_plug_thickness = 3.3;
module nice_nano() {
  color("#222")
    translate([nice_nano_usbc_plug_extrusion_depth, 0, 0])
    SmoothXYCube(size=[nice_nano_depth, nice_nano_width, nice_nano_thickness], smooth_rad=1);
  color("silver")
    translate([0, (nice_nano_width - nice_nano_usbc_plug_width) / 2, nice_nano_usbc_plug_thickness])
    rotate([0, 90, 0])
    SmoothXYCube(size=[nice_nano_usbc_plug_thickness, nice_nano_usbc_plug_width, nice_nano_usbc_plug_depth], smooth_rad=1);
}

nice_nano_side_grip_width = 20;
nice_nano_side_grip_thickness = 2;
nice_nano_side_grip_height = 6;
module nice_nano_side_grip() {
  cube([nice_nano_side_grip_width, nice_nano_side_grip_thickness, nice_nano_side_grip_height - (nice_nano_side_grip_thickness / 2)]);
  translate([0, nice_nano_side_grip_thickness / 2, nice_nano_side_grip_height - (nice_nano_side_grip_thickness / 2)])
    rotate([0, 90, 0])
    cylinder(nice_nano_side_grip_width, nice_nano_side_grip_thickness / 2, nice_nano_side_grip_thickness / 2);
}

nice_nano_back_grip_depth = 3;
nice_nano_back_grip_width = 10;
nice_nano_back_grip_height = 6;
nice_nano_back_grip_notch_height = 3;
nice_nano_back_grip_notch_tolerance = 0.4;
nice_nano_back_grip_notch_depth = 1;
module nice_nano_back_grip() {
  translate([0, nice_nano_back_grip_width, 0])
    rotate([90, 0, 0]) {
      linear_extrude(nice_nano_back_grip_width)
        polygon(
          [
            [0, 0],
            [0, nice_nano_back_grip_notch_height],
            [nice_nano_back_grip_notch_depth, nice_nano_back_grip_notch_height],
            [nice_nano_back_grip_notch_depth, nice_nano_back_grip_notch_height + nice_nano_thickness + nice_nano_back_grip_notch_tolerance],
            [0.2, nice_nano_back_grip_notch_height + nice_nano_thickness + nice_nano_back_grip_notch_tolerance],
            [nice_nano_back_grip_notch_depth - 0.2, nice_nano_back_grip_height],
            [nice_nano_back_grip_depth - 1, nice_nano_back_grip_height],
            [nice_nano_back_grip_depth, nice_nano_back_grip_height - 1],
            [nice_nano_back_grip_depth, 0],
          ],
          [
           [0, 1, 2, 3, 4, 5, 6, 7, 8]
          ]
        );
      translate([nice_nano_back_grip_depth - 1, nice_nano_back_grip_height - 1, 0])
        cylinder(nice_nano_back_grip_width);
    }
}

nice_nano_usbc_plug_cut_tolerance = 0.1;
module nice_nano_usbc_plug_cut() {
  translate([1 - nice_nano_usbc_plug_cut_tolerance, 1 - nice_nano_usbc_plug_cut_tolerance, 0])
    SmoothXYCube(size=[nice_nano_usbc_plug_thickness + (2 * nice_nano_usbc_plug_cut_tolerance), nice_nano_usbc_plug_width + (2 * nice_nano_usbc_plug_cut_tolerance), nice_nano_bracket_wall_thickness + 2], smooth_rad = 1);
  hull() {
    translate([1 - nice_nano_usbc_plug_cut_tolerance, 1 - nice_nano_usbc_plug_cut_tolerance, nice_nano_bracket_wall_thickness])
      SmoothXYCube(size=[nice_nano_usbc_plug_thickness + (2 * nice_nano_usbc_plug_cut_tolerance), nice_nano_usbc_plug_width + (2 * nice_nano_usbc_plug_cut_tolerance), 1], smooth_rad = 1);
    translate([0, 0, nice_nano_bracket_wall_thickness + 1])
      SmoothXYCube(size=[nice_nano_usbc_plug_thickness + 2, nice_nano_usbc_plug_width + 2, 1], smooth_rad = 2);
  }
}

nice_nano_bracket_base_thickness = 2;
nice_nano_bracket_base_width = nice_nano_side_grip_thickness * 2 + nice_nano_width;
nice_nano_bracket_wall_thickness = 2;
nice_nano_bracket_length_tolerance = 0.2;
module nice_nano_bracket(with_nice_nano = false, standalone = false) {
  translate([standalone ? nice_nano_bracket_wall_thickness - nice_nano_back_grip_notch_depth: 0, 0, standalone ? nice_nano_bracket_base_thickness: 0]) {
    if (with_nice_nano) {
      translate([0, nice_nano_side_grip_thickness, nice_nano_back_grip_notch_height])
        nice_nano();
    }

    color("lightblue") {
      translate([(nice_nano_depth + nice_nano_usbc_plug_extrusion_depth - nice_nano_side_grip_width) / 2, 0, 0]) {
        nice_nano_side_grip();
        translate([0, nice_nano_width + nice_nano_side_grip_thickness, 0])
          nice_nano_side_grip();
      }

      translate([nice_nano_depth + nice_nano_usbc_plug_extrusion_depth - nice_nano_back_grip_notch_depth + nice_nano_bracket_length_tolerance, (nice_nano_width - nice_nano_back_grip_width) / 2 + nice_nano_side_grip_thickness, 0])
        nice_nano_back_grip();
    }
  }

  if (standalone) {
    color("blue") {
      cube([nice_nano_depth + nice_nano_bracket_wall_thickness + nice_nano_back_grip_depth - nice_nano_back_grip_notch_depth + nice_nano_bracket_length_tolerance, nice_nano_bracket_base_width, nice_nano_bracket_base_thickness]);
      translate([0, 0, nice_nano_bracket_base_thickness])
        difference() {
        cube([nice_nano_bracket_wall_thickness, nice_nano_bracket_base_width, nice_nano_back_grip_notch_height + nice_nano_usbc_plug_thickness + 2]);
        translate([nice_nano_bracket_wall_thickness + 1, (nice_nano_bracket_base_width - nice_nano_usbc_plug_width) / 2 - 1, nice_nano_back_grip_notch_height - 1])
          rotate([0, -90, 0])
          nice_nano_usbc_plug_cut();
      }
    }
  }
}
