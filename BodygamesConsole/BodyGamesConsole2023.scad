// The Console
$fn=200;

Lid=0;
Box=1;
Foot=false;

if(Foot) translate([15,15,-25]) {
 cylinder(d=4,h=4,$fn=5);
 translate([0,0,-3])cylinder(d1=10,d2=12,h=5,$fn=10);
}

if(Box) {
 color("orange")difference() {
  union() {
   hull() {
    cube([10,10,30]);
    translate([10,80,0])cylinder(d=20,h=30);
    translate([150,0,0])cube([10,10,30]);
    translate([150,80,0])cylinder(d=20,h=30);
   }
   // Side ridges
   for(i=[1:8.25:80])   
     translate([-0.8,0.5+i,0])cube([1,4,30]); 
    translate([0.5,85,0])
     rotate([0,0,-37.5])
      cube([1,4,30]);
   for(i=[1:8.25:80])   
     translate([159.8,0.5+i,0])cube([1,4,30]);  
    translate([158.5,85,0])
     rotate([0,0,41.5])
      cube([1,4,30]);
   
   /* Doesn't print for(i=[0:1:3]) {
   translate([16+i*35,-1,21])
    rotate([90,0,0])#linear_extrude(height=0.6) text(
    halign="center",valign="center",text=str(i+2),spacing=1.2,
    size=6,
    font="SF Atarian System:style=Regular");
  }*/
  
  }
  // Cut main inside
  hull() {
   translate([2,18,2])cube([10,10,30]);
   translate([12,78,2])cylinder(d=20,h=30);
   translate([150-2,18,2])cube([10,10,30]);
   translate([150-2,78,2])cylinder(d=20,h=30);
  }
  // Cut inside below brand bar (no supports need to be added by slicer)
  translate([12,3,2])cube([40,20,24]);
  translate([54,3,2])cube([50,20,24]);
  translate([106,3,2])cube([20,20,24]);
  //translate([46+32+2,2,2])cube([32,20,24]);
  translate([46+64+4,3,2])cube([34,20,24]);
  
  
  
  // DIN plugs at front
  for(i=[0:1:3]) {
   if(i!=1 && i!=2) {
    //translate([27.5+i*32,5,13])rotate([90,0,0])DINPlug();
    //translate([27.5+i*32,1.2,13])rotate([90,0,0])DINPlug(true);
   }
  }
  
  translate([80+50,5,13])rotate([90,0,0])DINPlug();
  translate([80+50,1.2,13])rotate([90,0,0])DINPlug(true);
  translate([80-50,5,13])rotate([90,0,0])DINPlug();
  translate([80-50,1.2,13])rotate([90,0,0])DINPlug(true);
  
  translate([80,5,13])rotate([90,0,0])DINPlug();
  translate([80,1.2,13])rotate([90,0,0])DINPlug(true);
  //j=1.5;
  //translate([27.5+j*35,5,13])rotate([90,0,0])DINPlug();
  //translate([27.5+j*35,1.2,13])rotate([90,0,0])DINPlug(true);
  
  // Left button DIN
  translate([-2,44,15]) rotate([90,0,90]) DINPlug();
  translate([-9,44,15]) rotate([90,0,90]) DINPlug(true);
  // Right button DIN
  translate([155,44,15]) rotate([90,0,90]) DINPlug();
  translate([159,44,15]) rotate([90,0,90]) DINPlug(true);
  
  // Holes to mount feet
  translate([15,15,-1]) cylinder(d=4,h=10,$fn=5);
  translate([160-15,15,-1]) cylinder(d=4,h=10,$fn=5);
  translate([160-15,90-15,-1]) cylinder(d=4,h=10,$fn=5);
  translate([15,90-15,-1]) cylinder(d=4,h=10,$fn=5);
    
  // Arduino PCB outline
  //translate([90,87,2])rotate([0,0,180])
  //#import("/media/marcel/4TB/ff/bumper_leonardo.stl");
  #translate([70,86,5]) {
   // Arduino (Leonardo) holes
   translate([-0.5,0,0])cube([10,10,4]); // USB
   translate([-30.5,0,0])cube([11,10,12]); // Power      
   // Screw holes 
   translate([20,0,0]) {
    translate([-2.6,-14.2,-6]) cylinder(d=2.8,h=10);
    translate([-17.8,-14-51,-6]) cylinder(d=2.8,h=10);
    translate([-17.8-27.9,-14-51,-6]) cylinder(d=2.8,h=10);
    translate([-(53.3-2.5),-14+1.1,-6]) cylinder(d=2.8,h=10);
   }
  }
  
 }
 
 // Cyl's for screwing lid
 color("orange") {
  #translate([8,22,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
  translate([160-8,22,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
  translate([160-8,83,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
  translate([8,83,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
 }
 
 // Brand text
 translate([80,8.8,30]) color("lightblue")
 linear_extrude(height=0.8) text(
  halign="center",valign="center",text="BODY GAMES",spacing=1.2,
  font="SF Atarian System:style=Regular");
}

module DINPlug(Surrounding=false) {
 if(Surrounding) {
  hull() {
   cylinder(d=20.2,h=10);
   translate([11.1,0,0]) cylinder(d=7,h=10);
   translate([-11.1,0,0]) cylinder(d=7,h=10);
  }
 }
 else {
  cylinder(d=15.4,h=10);
  translate([11.1,0,0]) cylinder(d=3.1,h=10);
  translate([-11.1,0,0]) cylinder(d=3.1,h=10);
 }
}

module SpeakerPanel() {
 translate([-45.2/2,0,0]) {
  // Inset
  translate([0,-9,0])cube([45.2,10,21.4]);
  // Screw holes
  translate([45/2-35/2,5,21.4/2])rotate([90,0,0])cylinder(d=3.2,h=10);
  translate([45/2+35/2,5,21.4/2])rotate([90,0,0])cylinder(d=3.2,h=10);
  // Wiring holes
  translate([45/2-27/2,-1,5])cube([27,10,14]);
 }
}

if(Lid) translate([0,0,40])  { 
 Ypos=53; // Pos. of push button
 Xpos=40; // Pos. of push button
 Extra=10;
 
 difference() {
  union() {
   color("silver") hull() {
    translate([2,18,1])cube([10,10,3]);
    translate([12,78,1])cylinder(d=20,h=3);
    translate([150-2,18,1])cube([10,10,3]);
    translate([150-2,78,1])cylinder(d=20,h=3);
   }  
   intersection() {
    color("gray") hull() {
     translate([2,18,2])cube([10,10,3]);
     translate([12,78,2])cylinder(d=20,h=3);
     translate([150-2,18,2])cube([10,10,3]);
     translate([150-2,78,2])cylinder(d=20,h=3);
    }
    // Ridges
    for(i=[1:8.25:70]) {
     translate([2,i+17,3]) color("silver") cube([156,4,2.8]);
    }
   }
 
  } // union
  // Cyl's for screwing lid
  translate([8,22,-1])cylinder(d=2.6,h=10);
  translate([160-8,22,-1])cylinder(d=2.6,h=10);
  translate([160-8,83,-1])cylinder(d=2.6,h=10);
  translate([8,83,0])cylinder(d=2.6,h=10);
  color("silver")translate([8,22,2.4])cylinder(d=4.6,h=10);
  color("silver")translate([160-8,22,2.4])cylinder(d=4.6,h=10);
  color("silver")translate([160-8,83,2.4])cylinder(d=4.6,h=10);
  color("silver")translate([8,83,2.4])cylinder(d=4.6,h=10);
  // Hole push button 
  color("grey")translate([160-Xpos,Ypos,-1]) cylinder(d=30,h=10);  
  color("grey")translate([160-Xpos,Ypos,3]) cylinder(d=34,h=10);  
  // space for ridge around push button
  color("grey")translate([160-Xpos,Ypos,3]) cylinder(d=40,h=10);  
  
  // LED's bevel & holes  
  
  hull() {
   color("silver")translate([Xpos,Ypos,4]) cylinder(d=40,h=10);  
   color("silver")translate([Xpos+Extra,Ypos,4]) cylinder(d=40,h=10);  
  }
  
  color("silver")translate([Xpos+Extra/2+8,Ypos+10,-1]) cylinder(d=5,h=10); 
  color("silver")translate([Xpos+Extra/2+8,Ypos,-1]) cylinder(d=5,h=10); 
  color("silver")translate([Xpos+Extra/2+8,Ypos-10,-1]) cylinder(d=5,h=10); 
 //OK color("silver")translate([Xpos+Extra/2-18,Ypos+4,-1]) cylinder(d=5,h=10); 
//OK  color("silver")translate([Xpos+Extra/2,Ypos+4,-1]) cylinder(d=5,h=10); 
 //OK color("silver")translate([Xpos+Extra/2+18,Ypos+4,-1]) cylinder(d=5,h=10); 
 } // difference
 
 // Ridge around LED's
 color("grey") {
  translate([Xpos+Extra/2+8,Ypos+10,1]) difference() {
   cylinder(d=9,h=4); translate([0,0,-1])cylinder(d=5,h=20);
  }
  translate([Xpos+Extra/2+8,Ypos,1]) difference() {
   cylinder(d=9,h=4); translate([0,0,-1])cylinder(d=5,h=20);
  }
  translate([Xpos+Extra/2+8,Ypos-10,1]) difference() {
   cylinder(d=9,h=4); translate([0,0,-1])cylinder(d=5,h=20);
  }
 }
 
 // Ridge around push button
 color("grey") {
  difference() {
   hull() {
    color("grey")translate([Xpos,Ypos,3])  cylinder(d=44,h=2);  
    translate([Xpos+Extra,Ypos,3]) cylinder(d=44,h=2);  
   }
   hull() {
    color("grey")translate([Xpos, Ypos,-1])cylinder(d=36,h=20);  
    translate([Xpos+Extra, Ypos,-1])cylinder(d=36,h=20);
   }
  }  
 }
 
 // LED texts
 color("green")translate([Xpos+Extra/2+1,Ypos+10,4]) linear_extrude(height=1.6) text(
  halign="right",valign="center",text="pow",spacing=1,size=8.6,
  font="SF Atarian System:style=Regular");
 color("green")translate([Xpos+Extra/2+1,Ypos,4]) linear_extrude(height=1.6) text(
  halign="right",valign="center",text="on",spacing=1,size=8.6,
  font="SF Atarian System:style=Regular");
 color("green")translate([Xpos+Extra/2+1,Ypos-10,4]) linear_extrude(height=1.6) text(
  halign="right",valign="center",text="sens",spacing=1,size=8.6,
  font="SF Atarian System:style=Regular");
 
 // Ridge around LED's
 color("grey") translate([160-Xpos,Ypos,3]) difference() {     
  cylinder(d=44,h=2);  
  translate([0,0,-1])cylinder(d=36,h=20);  
 }
}




