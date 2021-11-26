include <./nice_nano_bracket.scad>
include <./switch_bracket.scad>
include <./battery_bracket.scad>
include <./the_alternate.scad>

$fa=1;
$fs=0.1;
$fn=32;

tray_slope = 4.99678036;
top_thickness = 6.376716613769531;
base_min_top = 8.194;
base_bottom_thickness = 1.9178695678710938;
spacer_height = 2.9;
num_spacers = 5;
lip_height = 2;
the_alternate_half_width = the_alternate_base_bounding_box_max_y - the_alternate_base_bounding_box_min_y;
the_alternate_depth = the_alternate_base_bounding_box_max_x - the_alternate_base_bounding_box_min_x;
cut_offset = the_alternate_half_width / 3;
battery_bracket_placement = (the_alternate_depth - battery_bracket_width) / 2;
usbc_plug_cutout_width = nice_nano_usbc_plug_width * 1.5;

spacer_stack_extrusion_height = 10;
spacer_stack_height = spacer_stack_extrusion_height - 2.5 + the_alternate_spacer_bounding_box_max_z - the_alternate_spacer_bounding_box_min_z;
module spacer_stack() {
  linear_extrude(spacer_stack_extrusion_height) projection() the_alternate_spacer();
  translate([0, 0, spacer_stack_extrusion_height - 2.5]) the_alternate_spacer();
}

module bottom_right_shell() {
  translate([0, sin(tray_slope) * (spacer_stack_height - lip_height), 0])
    the_alternate_base();
  translate([0, sin(tray_slope) * spacer_stack_height, base_min_top])
    rotate([tray_slope, 0, 0])
    spacer_stack();
}

module bottom_left_shell() {
  translate([the_alternate_half_width, 0, 0])
    mirror([1, 0, 0])
    bottom_right_shell();
}

module bottom_left() {
  difference() {
    bottom_left_shell();
    translate([cut_offset - (usbc_plug_cutout_width / 2), the_alternate_depth - 7.15, 0])
      cube([usbc_plug_cutout_width, 10, 11]);
    translate([cut_offset - (nice_nano_usbc_plug_width / 2) - 1, the_alternate_depth - 10.15, nice_nano_back_grip_notch_height - 1 + base_bottom_thickness])
      rotate([0, -90, -90])
      nice_nano_usbc_plug_cut();
  }
  translate([cut_offset - (nice_nano_bracket_base_width / 2), the_alternate_depth - 8.15, base_bottom_thickness])
    rotate([0, 0, -90])
    nice_nano_bracket();
  translate([the_alternate_half_width - battery_bracket_width, battery_bracket_placement, base_bottom_thickness])
    battery_bracket_front();
}

module bottom_right() {
  difference() {
    bottom_right_shell();
    translate([the_alternate_half_width - (switch_cut_width / 2) - cut_offset, the_alternate_depth - 12, base_bottom_thickness])
      switch_cut(15);
    translate([the_alternate_half_width - (switch_cut_width / 2) - cut_offset - 2.5, the_alternate_depth - 7.5, base_bottom_thickness - 1.5])
      cube([switch_cut_width + 5, 15, switch_cut_height + 3]);
  }
  translate([0, battery_bracket_placement, base_bottom_thickness])
    battery_bracket_back();
}

module top_left() {
  the_alternate_top_left();
}

module top_right() {
  the_alternate_top_right();
}

module bottom() {
  translate([0, sin(tray_slope) * top_thickness, 0]) {
    bottom_left();
    translate([the_alternate_half_width, 0, 0])
      bottom_right();
  }
}

module top() {
  top_left();
  translate([2 * the_alternate_half_width - (the_alternate_top_right_bounding_box_max_y - the_alternate_top_right_bounding_box_min_y), 0, 0])
    top_right();
}

module keyboard() {
  bottom();
  translate([0, sin(tray_slope) * (the_alternate_top_left_bounding_box_max_z - the_alternate_top_left_bounding_box_min_z), base_min_top + spacer_stack_height - lip_height])
    rotate([tray_slope, 0, 0])
    top();
}

keyboard();
