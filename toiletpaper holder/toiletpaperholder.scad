// unit = mm

$fn = 128;

module cylinderhole(h,r,t,center = true) {
    difference() {
        cylinder(h=h, r=r+t, center = center);
        cylinder(h=h+1, r=r, center = center);
    }
}

module cylinderhollow(h,r,t,center = true) {
    difference() {
        cylinder(h=h, r=r, center = center);
        cylinder(h=h+1, r=r-t, center = center);
    }
}

module Hook(diameter,thickness) {
    cylinderhole(h=thickness, r=diameter/2, t = thickness);
}

module Stick(diameter,thickness,length) {
    translate([0-thickness/2,diameter/2,0-thickness/2]) {
        cube([thickness,length,thickness]);
    };
}

module RollHolder(diameter,thickness,length,tpLength, innerRollDiameter) {
    translate([0,length+thickness,0]) {
        translate([0,diameter/2,0]) {
            translate([0,innerRollDiameter/2-thickness,-thickness/2]) {
                intersection() {
                    cylinderhollow(h=tpLength, r=innerRollDiameter/2, t = thickness, center = false);
                    cropX = innerRollDiameter/2;
                    translate([0-cropX/2,0-innerRollDiameter/2,0]) {
                        cube([cropX,innerRollDiameter/8,tpLength]);
                    }
                    //rotate(90-90) square(innerRollDiameter/2);
                }
                
                
            }
        }
    }
}

module Main(hookRadius=16,thickness=5,length=120,rollDiameter=37) {
    Hook(hookRadius,thickness);
    Stick(hookRadius,thickness,length);
    RollHolder(hookRadius,thickness,length,100,rollDiameter);
    
}

Main();