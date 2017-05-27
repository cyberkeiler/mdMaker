/* ### Lampenfassung ###*/
$fass_d1 = 41; // Fassung Durchmesser Spitze
$fass_d2 = 36; // Fassung Durchmesser Unten
$fass_l1 = 17; // Fassung Länge Spitze

$fass_l = 46; // Fassung Länge gesamt


$fass_op_d = 35; // Fassung Öffnungs Durchmesser
$fass_op_l = 3; // Fassung Öffnung Tiefe


module FassungCutout(){
    rotate([0,180,0])
    union(){
        cylinder(h=$fass_op_l+0.1, r=$fass_op_d/2);
        translate([0,0,$fass_op_l])
        union(){
            cylinder(h=$fass_l, r=$fass_d2/2);
            cylinder(h=$fass_l1, r=$fass_d1/2);
        }
    }
}