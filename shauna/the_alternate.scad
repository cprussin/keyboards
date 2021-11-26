the_alternate_base_bounding_box_min_x = -137.1273193359375;
the_alternate_base_bounding_box_max_x = -19.7692928314209;
the_alternate_base_bounding_box_min_y = 178.4666290283203;
the_alternate_base_bounding_box_max_y = 336.4766540527344;
the_alternate_base_bounding_box_min_z = 6.598999977111816;
the_alternate_base_bounding_box_max_z = 26.981773376464844;
module the_alternate_base() {
  translate([0, the_alternate_base_bounding_box_max_x - the_alternate_base_bounding_box_min_x, 0]) {
    rotate([0, 0, -90]) {
      translate([-the_alternate_base_bounding_box_min_x, -the_alternate_base_bounding_box_min_y, -the_alternate_base_bounding_box_min_z]) {
        import("the_alternate/bottom_right.stl");
      }
    }
  }
}

the_alternate_spacer_bounding_box_min_x = -136.4912109375;
the_alternate_spacer_bounding_box_max_x = -19.4912166595459;
the_alternate_spacer_bounding_box_min_y = 178.4666290283203;
the_alternate_spacer_bounding_box_max_y = 336.4766540527344;
the_alternate_spacer_bounding_box_min_z = 39.97416687011719;
the_alternate_spacer_bounding_box_max_z = 44.874168395996094;
module the_alternate_spacer() {
  translate([0, the_alternate_spacer_bounding_box_max_x - the_alternate_spacer_bounding_box_min_x, 0]) {
    rotate([0, 0, -90]) {
      translate([-the_alternate_spacer_bounding_box_min_x, -the_alternate_spacer_bounding_box_min_y, -the_alternate_spacer_bounding_box_min_z]) {
        import("the_alternate/spacer.stl");
      }
    }
  }
}

the_alternate_top_left_bounding_box_min_x = -136.3489990234375;
the_alternate_top_left_bounding_box_max_x = -19.348995208740234;
the_alternate_top_left_bounding_box_min_y = 20.476652145385742;
the_alternate_top_left_bounding_box_max_y = 187.38912963867188;
the_alternate_top_left_bounding_box_min_z = 69.86933898925781;
the_alternate_top_left_bounding_box_max_z = 78.26934051513672;
module the_alternate_top_left() {
  translate([0, the_alternate_top_left_bounding_box_max_x - the_alternate_top_left_bounding_box_min_x, 0]) {
    rotate([0, 0, -90]) {
      translate([-the_alternate_top_left_bounding_box_min_x, -the_alternate_top_left_bounding_box_min_y, -the_alternate_top_left_bounding_box_min_z]) {
        import("the_alternate/top_left.stl");
      }
    }
  }
}

the_alternate_top_right_bounding_box_min_x = -136.3489990234375;
the_alternate_top_right_bounding_box_max_x = -19.348995208740234;
the_alternate_top_right_bounding_box_min_y = 173.3821258544922;
the_alternate_top_right_bounding_box_max_y = 336.4766540527344;
the_alternate_top_right_bounding_box_min_z = 69.86933898925781;
the_alternate_top_right_bounding_box_max_z = 78.26934051513672;
module the_alternate_top_right() {
  translate([0, the_alternate_top_right_bounding_box_max_x - the_alternate_top_right_bounding_box_min_x, 0]) {
    rotate([0, 0, -90]) {
      translate([-the_alternate_top_right_bounding_box_min_x, -the_alternate_top_right_bounding_box_min_y, -the_alternate_top_right_bounding_box_min_z]) {
        import("the_alternate/top_right.stl");
      }
    }
  }
}
