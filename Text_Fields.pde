void setupTxtFields() { 
 cp5Txt = new ControlP5(this);  
int step = 115;
//int box1Off = 25;
  speed = cp5Txt.addTextfield("speed")  // time based txt field
//  cp5Txt.addTextfield("speed")  // time based txt field
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(210, box1Ypos+10) //box1Off)
            .setSize(45, 20)
   //           .setFont(font)// 1/3/17
                .setFocus(false)
                    .setText(strSpeed[syringe]);
  /*                    controlP5.Label ril = speed.captionLabel(); 
                        ril.setFont(font);
                          ril.toUpperCase(false);
                            ril.setText("Speed (uL/s)");     */
 int textY1 = 35;
 

                    
diam = cp5Txt.addTextfield("diam")  
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(240, 210) //+off1)  //box1Off)
            .setSize(45, 20)
              .setFont(font12)
                .setFocus(false)
                    .setText(strDia[syringe]);
                    
cp5Txt.addTextfield("syringe")  
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(180, 210) //+off1)  //box1Off)
            .setSize(45, 20)
              .setFont(font12)
                .setFocus(false)
                    .setText(strSyr[syringe]);
  
                            

                    
setVol  = cp5Txt.addTextfield("volume")  
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(100, box1Ypos+10) //+off1)
            .setSize(45, 20)
              .setFont(font12)
                .setFocus(false)
                    .setText(strVol[syringe]);                   
                         

}
public void getParams(){
  
// println("in speed loop");
////////////////get speed value from text box
  stringMode = "0";  //String.valueOf(modeState);
  strSyr[syringe] = cp5Txt.get(Textfield.class, "syringe").getText();
  strSpeed[syringe] = cp5Txt.get(Textfield.class, "speed").getText();
  /* Info from text fields transmitted to u-controller as strings
   * to convert to float, int, or char, use commands below:
   *  float fSpeed = float(stringSpeed);
   *  iSpeed = round(fSpeed);
   *  cSpeed = char(iSpeed);
  */
//  println("in params loop, line 143");
///////// get volume from text field
//if (modeState == 0){
 //  println("in ModeState 0 loop");
   strVol[syringe] = cp5Txt.get(Textfield.class, "volume").getText();
//   println("got text");
   if(units[syringe] == "mL"){
   int p = int(1000*float(strVol[syringe]));

   sendVol = str(p);
   }else{
     sendVol = strVol[syringe];
   }
   println("volume: "+strVol[syringe]);
//}
//println("params, line 153");
//}
/*else{
  stringVolume = cp5Txt.get(Textfield.class, "volume").getText();
  println("params, line 156");
}*/
///////// get injetions from text field
//  stringInjections = cp5Txt.get(Textfield.class, "injections").getText();
//println("params, line 160");
  stringInjDelay = "0";  //cp5Txt.get(Textfield.class, "Delay_(s)").getText();
//  sTarget = "0"; //cp5Txt.get(Textfield.class, "target").getText();
//  fTarget = 0;  //float(sTarget);
  strDia[syringe] = cp5Txt.get(Textfield.class, "diam").getText();
  float fSpeed = float(strSpeed[syringe]);
  float spdCheck = fSpeed/sq(float(strDia[syringe]));
  if(spdCheck > maxRatio){
    speedFlag = true;
  }else{
  speedFlag = false;
  }
  int intDia = int(1000*float(strDia[syringe]));
  sendDia = str(intDia);
}
