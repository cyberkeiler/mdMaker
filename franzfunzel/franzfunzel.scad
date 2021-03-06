// Layers of Multiplex
$layer_anz = 10;
$layer_thickness = 12;

/* ### Corpus ###*/
$corpus="sonos";
$width = 120;
$sonos_r = 30;
$depth = $width;
$height = $layer_anz * $layer_thickness;

// Anzeige Settings
$fn = 128;
$show_layer = 1;
$show2d = true;

// Button
// Favorit Taster von pollin (http://www.pollin.de/shop/dt/MjM0OTc1OTk-/Bauelemente_Bauteile/Mechanische_Bauelemente/Schalter_Taster/Drucktaster_PBS_28B_2_Schliesser.html)
$button_layer = ceil($layer_anz/2);     // zwischen Welchen Ebene der Button eingebaut werden soll
$button_diameter=19;    // Der Einbaudurchmesser des Buttons

/* ### Lampenfassung ###*/
$fass_d = 41; // Fassung Durchmesser
$fass_l = 47; // Fassung Länge

$fass_op_d = 10; // Fassung Öffnungs Durchmesser
$fass_op_l = 3; // Fassung Öffnung Tiefe

/* ### Dübel ###*/
$dueb_d = 6;
$dieb_l=30;
$dieb_r=$width/2-20;

/* Stellt 3D Modell des Fassungsausschnitts ( "FassungCutout()" ) bereit: */
include <fassung.scad>


    projection(cut = true)
    translate([0,0,-12+3])
difference(){
//projection(cut = false)
difference(){
    color([0.1,.5,.5,0.5])
    union(){
        for(i = [1 : 1 : $layer_anz]){
            if($show_layer == 0 || $show_layer == i){
            translate([0,0,$layer_thickness*(i-0.5)])
                MultiplexLayer();
            }
         }
    };
    ButtonLochTop();
    
    translate([0,0,6])
    duebepoints();
    
}
//projection(cut = false)
FassungsLoch();

translate([-20,0,2*$layer_thickness])
rotate([180,0,0])
import("sonoff-th.stl");


//projection(cut = false)
//FassungsOeffnung();
}



//SonoffCorpus();


module MultiplexLayer(){
    if($corpus=="cubic"){
        linear_extrude(height = $layer_thickness, center = true, convexity = 1, twist = 0)
            square(size = [$width,$depth], center = true);
        // cube(size = [$width,$depth,$layer_thickness], center = true);
    }else if($corpus=="sonos"){
        linear_extrude(height = $layer_thickness, center = true, convexity = 1, twist = 0)
            hull(){
                r=$width/2-$sonos_r;
                translate([r,r,0])
                    circle(r=$sonos_r, center = true);
                translate([-r,r,0])
                    circle(r=$sonos_r, center = true);
                translate([r,-r,0])
                    circle(r=$sonos_r, center = true);
                translate([-r,-r,0])
                    circle(r=$sonos_r, center = true);
            }
    }else{
    
    }
}


module duebel90(){
union(){
        for(i = [1 : 1 : $layer_anz-1]){  
            rotate([0,0,90*i])
            union(){
                translate([$dieb_r,$dieb_r,$layer_thickness*(i)])
                    cylinder(r=3, h=30, center=true);
                translate([-$dieb_r,-$dieb_r,$layer_thickness*(i)])
                    cylinder(r=3, h=30, center=true);
            }
         }
    };
}

module duebepoints(){
union(){
        
           for(o = [1 : 1 : 4]){ 
            rotate([0,0,90*o])
                translate([$dieb_r,$dieb_r,$height/2])
                    cylinder(r=3, h=$height+0.2, center=true);
        }
         
    };
}


module ButtonLoch(){
    translate([-$depth/2-0.1,0,$button_layer * $layer_thickness])
        rotate([0,90,0])
            cylinder(r=$button_diameter/2, h=10.1);
}
module ButtonLochTop(){
    translate([$width/3,0,$height-20.1])
        rotate([0,0,0])
            cylinder(r=$button_diameter/2, h=20.2);
}

module FassungsLoch(){
    union(){
        FassungsOeffnung();
        FassungsTunnel();
    }
}

module FassungsOeffnung(){
translate([0,0,$height+0.1])
        rotate([180,0,0])
            cylinder(r=36/2, h=$fass_op_l+0.2);
}
module FassungsTunnel(){
    translate([0,0,$height-$fass_op_l])
        rotate([180,0,0])
            cylinder(r=$fass_d/2, h=$fass_l);
}

module sonoffLoch(){
    translate([20,0,$layer_thickness])
        rotate([180,0,180])
    import("sonoff-th.stl", convexity=3);
}

module SonoffCorpus(){
    
        rotate([180,0,180-45])
    translate([-20,0,-$layer_thickness*2])
    import("sonoff-th.stl", convexity=3);
}
