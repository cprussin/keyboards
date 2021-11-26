switch_outer_width = 21;
switch_outer_depth = 2;
switch_outer_height = 15;
switch_inner_width = 18.6;
switch_inner_depth = 11.5;
switch_inner_height = 13;
module switch() {
  color("#555") {
    translate([(switch_outer_width - switch_inner_width) / 2, switch_outer_depth, (switch_outer_height - switch_inner_height) / 2])
      cube([switch_inner_width, switch_inner_depth, switch_inner_height]);
    cube([switch_outer_width, switch_outer_depth, switch_outer_height]);
  }
}

switch_cut_tolerance = 0.4;
switch_cut_width = switch_inner_width + switch_cut_tolerance;
switch_cut_height = switch_inner_height + switch_cut_tolerance;
module switch_cut(thickness) {
  cube([switch_cut_width, thickness, switch_cut_height]);
}

switch_bracket_base_thickness = 2;
switch_bracket_wall_thickness = 2;
switch_bracket_wall_border = 3;
switch_bracket_wall_width = switch_outer_width + (2 * switch_bracket_wall_border);
switch_bracket_wall_height = switch_outer_height + (2 * switch_bracket_wall_border);
module switch_bracket(with_switch = false) {
  eps = 0.1;

  if (with_switch) {
    translate([switch_bracket_wall_border, 0, switch_bracket_wall_border]) switch();
  }

  translate([0, with_switch ? switch_outer_depth : 0, 0]) {
    color("blue") {
      cube([switch_bracket_wall_width, switch_inner_depth, switch_bracket_base_thickness]);
      difference() {
        cube([switch_bracket_wall_width, switch_bracket_wall_thickness, switch_bracket_wall_height]);
        translate([(switch_bracket_wall_width - switch_inner_width - switch_cut_tolerance) / 2, -(eps / 2), (switch_bracket_wall_height - switch_inner_height - switch_cut_tolerance) / 2])
          switch_cut(switch_bracket_wall_thickness + eps);
      }
    }
  }
}
