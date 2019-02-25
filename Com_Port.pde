// Com_Port tab
// code on this tab sets up communications with the launchpad

void setupComPort() {
 /////////  connect button ////////////
  cp5Com = new ControlP5(this); 
    cp5Com.addButton("connect")
     .setPosition(10,10)
     .setSize(45,20)
     ;
}

/////////// connect button program //////////
public void connect() {
  if(connected){
      serialPort.clear();
      serialPort.stop();
      connected = false;
  }

  println("connect button pressed");
//  char cData = 'a';
  comList = null;
  comList = Serial.list();  
  int n = comList.length;
  println("com list length = "+n);
  if (n == 0) { 
    comStatTxt = "No com ports detected";
  }
  else {
    int k = 9999;
    comStatTxt = "Multiple com ports detected";
    for (int m = 0; m <= n-1; m++) {
         conTry[m]= tryCom(m);
         if(conTry[m]){
           k = m;
         }
            serialPort.clear();
            serialPort.stop();
         }  // end of m loop
    if (k == 9999) {
      comStatTxt = "No responsive port";
    }
    else{
    serialPort = new Serial(this, comList[k], 9600);
    connected = true;
//    comStatTxt = "Connected on "+comList[k];
    }
  }

}

   boolean tryCom(int n){
     boolean ans = false;
     String pumpName;
   try{
     serialPort = new Serial(this, comList[n], 9600);
      // serial print character '&'
     serialPort.write('*');
     println("* character sent to LaunchPad");
 // listen for return character '&'
     delay(100);
     if (serialPort.available () <= 0) {}
     if (serialPort.available() > 0)
        {
        cData =  serialPort.readChar();
        if (cData == '&') {
          println(comList[n] + " responsive");
          if (serialPort.available() > 0) {                     
        pumpName = serialPort.readStringUntil(LINE_FEED);
        pumpName = pumpName.substring(0,pumpName.indexOf(LINE_FEED));
        comStatTxt = pumpName+" on "+comList[n];
          }else{
          comStatTxt = "Connected on "+comList[n];
          }
          ans = true;
        }
       
        }
   }
        catch(Exception e){
     println("exception in try com port");
        }
   return ans;
   }
