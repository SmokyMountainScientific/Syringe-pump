////////// Initiate Buttons tab ////
// methods for the following are defined on this tab
// runPump
// pause
// writeParams

void runPump(){
  serialPort.write('&');
  println("'&' char sent to pump");
 if(pumpRunState == true){  // if running, turn off
    runPtxt = "Run Pump";
    runState = false;
  }
  else{
    getParams();
    delay(100); 
    writeParams();
    runPtxt = "Stop Pump";
    runState = true;
  }
  pumpRunState =! pumpRunState;
  println("pump run state = "+pumpRunState);

}

void pause(){
   println("pause button pressed");
   if(paused == true){        // resume injection
      runStateTxt = "Stop";
      pauseTxt = "Pause";
      runState = true;
      paused = false;
      //get new values for addition delay, target and addition volume
        serialPort.clear();                             // did not help
        serialPort.write('N');
        println("N sent to microcontroller");
        delay(100);
      
    
   }else if (paused == false && runState == true){
     println("pause signal sent");
      runState = false;
      paused = true;
      runStateTxt = "Stop";
      pauseTxt = "Resume";     
      serialPort.write('P');  // p is 80 in ascii
     } else {
     }

}

void writeParams() {
  ///////////// write parameters to lauchpad ////////////////////
//  serialPort.write(stringMode);    // transmit mode
//  serialPort.write(',');               
  serialPort.write(sendDia);          // transmit syringe diameter
  serialPort.write(',');               
  serialPort.write(sendVol);  // transmit volume to inject /withdraw
  serialPort.write(',');
  ////////////////////////////// transmit direction ///////////////////                                  
  if (boolDir == false) {     // if direction = inject
    serialPort.write(",0,");    // specifies direction
    println("Direction = inject");
  }  // end of if direction = inject
  else {                        // if direction = withdraw
    serialPort.write(",1,");
    println("Direction = withdraw");
  }  
  ///////////////////// end of transmit direction //////////////////////
  serialPort.write(strSpeed[syringe]);       // speed
//  serialPort.write(',');
/*  if(modeState == 0){
  serialPort.write(valveMode);
  }else{ */
//    serialPort.write("0");
//  }
  //  serialPort.write(stringInjections);  // number of injections
//  serialPort.write(',');
//  serialPort.write(stringInjDelay);    // delay between injections
  //////////////////// end of transmissions ////////////////////

//  println("mode = "+stringMode);
  println("Volume = "+strVol[syringe]);
  println("units = "+units[syringe]);
  println("Speed = "+strSpeed[syringe]);   
 // println("valve mode = 0");
//  println("delay = "+stringInjDelay);

  //   Wait for LaunchPad to transmit '&' before starting data read
  boolean startRead = false;  
      char priorB = 'o';

  while (startRead == false) {
   b = serialPort.readChar();

    if(b != priorB){
      j = int(b);
      println("b value: "+j);
      priorB = b;
    }
    if (j == 65535){  //b == '&') {         // was b == '#' to end run
 //   if (b == '&') {         // was b == '#' to end run
      runState = true; 
      println("runState = true, line 82");
      runStateTxt = "Stop";
      startRead = true;
    }
    b='b';
  }  // end of while serialport available
}  

/*public void runButton() {  

  println("holy crap, sombody pressed run");

  serialPort.write('&');         // initiates run
//  println("line 12");
//  delay(100); 

  if (runState == false) {      // start run
 // println("line 16");
    if (modeState == 2  && paused == false) {  // only restart data file if paused is false
    println("line18");
      // create log file for pH adjust and titration
  //    logData(file1, "volume,pH,\n", false);   // log data to file 1, do not append, start new file
      // added 4/15/15
 //     xData = nullData;  /// Clear X and Y data to redraw chart
   //   yData = nullY;
      inVol = 0;
      p = 0;                        // reset counter
      runStateTxt = "Stop";
    }
    println("line28");
      getParams();
    println("line 30");
      delay(100);
    writeParams();
    println("line 29, did not get here");
  } // end of if runState  == false loop

  ///////////////////////

  else {                       // stop run at button press
    runState = false;
    paused = false;
    println("runState = false");
    //  delay(100);
    runStateTxt = "Run";
    pauseTxt="Pause";
  }
}
*/
