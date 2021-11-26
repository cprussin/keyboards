use <./util.scad>

battery_width = 37;
battery_length = 66.4;
battery_height = 18.8;
battery_radius = battery_height / 2;
module battery() {
  color("#AAA") {
    translate([0, 0, battery_height]) rotate([0, 90, 0]) hull() {
      translate([battery_radius, battery_radius, 0])
        cylinder(battery_length, battery_radius, battery_radius);
      translate([battery_radius, battery_width - battery_radius, 0]) cylinder(battery_length, battery_radius, battery_radius);
    }
  }
}

battery_stop_width = 25;
battery_stop_thickness = 2.6;
battery_stop_rounding = 0.6;
module battery_stop(height) {
  translate([0, battery_stop_width, 0]) rotate([90, 0, 0])
    HalfSmoothXYCube(size = [battery_stop_thickness, height, battery_stop_width], smooth_rad = battery_stop_rounding);
}

battery_bracket_grip_length = 20;
battery_bracket_grip_width = 12;
battery_bracket_grip_height = 16;
battery_bracket_grip_fillet = 2;
module battery_bracket_right_grip() {
  eps = 0.1;

  difference() {
    rotate([90, 0, 90])
      HalfSmoothXYCube(size = [battery_bracket_grip_width, battery_bracket_grip_height, battery_bracket_grip_length], smooth_rad = battery_bracket_grip_fillet);
    translate([- eps / 2, battery_bracket_grip_width, battery_radius]) rotate([0, 90, 0])
      cylinder(battery_bracket_grip_length + eps, battery_radius, battery_radius);
  }
}

module battery_bracket_left_grip() {
  //translate([0, battery_bracket_grip_width, 0])
  mirror([0, 1, 0]) battery_bracket_right_grip();
}

battery_bracket_tolerance = 0.1;
battery_bracket_grip_offset = battery_bracket_grip_width - battery_radius + battery_bracket_tolerance;
battery_bracket_stop_offset = (battery_width - battery_stop_width) / 2 + battery_bracket_grip_offset;
module battery_bracket_front() {
  translate([0, battery_bracket_stop_offset, 0])
    battery_stop(battery_bracket_front_stop_height);
  translate([battery_length / 2 - battery_bracket_grip_length + battery_stop_thickness + battery_bracket_tolerance, 0, 0]) {
    battery_bracket_right_grip();
    translate([0, battery_width + (2 * battery_bracket_grip_offset), 0])
      battery_bracket_left_grip();
  }
}

module battery_bracket_back() {
  translate([(battery_length / 2) + battery_bracket_tolerance, battery_bracket_stop_offset, 0]) battery_stop(battery_bracket_back_stop_height);
  battery_bracket_right_grip();
  translate([0, battery_width + (2 * battery_bracket_grip_offset), 0])
    battery_bracket_left_grip();
  }

battery_bracket_base_thickness = 2;
battery_bracket_front_stop_height = 2;
battery_bracket_back_stop_height = 10;
battery_bracket_width = battery_length / 2 + battery_stop_thickness + battery_bracket_tolerance;
module battery_bracket(with_battery = false, standalone = false) {
  if (standalone)
    color("blue")
      cube([battery_length + 2 * (battery_stop_thickness + battery_bracket_tolerance), battery_width + (2 * battery_bracket_grip_offset), battery_bracket_base_thickness]);

  translate([0, 0, standalone ? battery_bracket_base_thickness : 0]) {
    if (with_battery)
      translate([battery_stop_thickness + battery_bracket_tolerance, battery_bracket_grip_offset, 0])
        battery();
    color("#333") {
      battery_bracket_front();
      translate([(battery_length / 2) + battery_bracket_tolerance + battery_stop_thickness, 0, 0])
        battery_bracket_back();
    }
  }
}
