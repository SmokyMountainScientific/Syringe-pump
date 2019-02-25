/*  SyringePump

    Made with parts from Titraumatic2.0
    Compatable with Energia sketch Titraumatic_Engergia_09_15_15
    New buttons and corosponding functions for lading a calibration file or reading the raw data in the "Buttons" tab
    New textfield in the "Text_Fields" tab to show the loaded calibration file
 
*/

  //////////////////// Imports ////////////////
//  import org.gicentre.utils.stat.*;     // needed for charts
  import controlP5.*;                   // needed for text boxes
  import processing.serial.*;
  import java.io.*;                     // needed for BufferedWriter
  import java.util.Arrays;            // need for BufferedWriter?
  import java.util.*;

//  import java.lang.Math.*;             // for raising a number to a power
  ///////////////////// Declaring classes  ////////////////////
//  XYChart lineChart, calChart, trendChart; 
  //     int chartX =75;
    //   int chartY =100;
  ControlP5 cp5, cp5Com, cp5Txt, cp5list, cp5knob;
  Serial serial;
  Serial serialPort;
 // DropdownList mode;
  Button dirButton, runPump; // runValve;   // buttons for manual mode
  Button savRun, loadCal, readCal, pause;   // runButton,
  Textfield speed, volume, diam, syrCal, setVol;  //injections, 
 // Knob valveKnob;
 boolean conTry[] = new boolean[6];  // is port connected? try up to six of them
 boolean connected = false;
  String strSyr[] = new String[4];     // syringe name
  String strSpeed[] = new String[4];    // speed for this syringe
  String strDia[] = new String[4];       // diameter in mm
  String strVol[] = new String[4];          // volume to inject
  String units[] = new String[4];            // units (mL vs uL)
  String sendVol;  // volume to send
   String sendDia;  // diameter to send
  int syringe = 0;     // which syringe is selected
  String[] file = new String[6];  
  float maxRatio;
  boolean speedFlag = false;
  String stringMode;
  String Modetorun;
  String stringInjDelay;
  Boolean logFile = false;  // probably only want to log titration data, but ...
  Boolean paused = false;

  //////// chart stuff ////////
//char[] strtochar;  // dont know if this is used
 char cData;
 String sData3; // 11/25

int LINE_FEED = 10; 
int command;     // read variable from LaunchPad for status info

//String tab ="\t";
float[] xData = {0};   
float[] yData = {0};
float xRead;   
float yRead;
String[] file1 = new String[4];
//String file1 = "logdata.txt";
String file2;                  // save file path
String[] sData = new String[3];  //String sData;
String sData2 = " ";
char cData2;
int i =0;
int p = 0;           //stop signal

 String pHTxt = "No input";   // not used?
 float fVol;                              //volume from text box converted to float 
 float inVol;                             // volume dispensed
 float initVol;                        // initial volume in syringe

  /////// font stuff ////////
PFont font16, font12;
boolean runState = false;           // is the pump running?
boolean boolDir = false;              // false = inject, true = withdraw
boolean comState = false;               // is the com port connected?
    boolean addBase;                  // next 5 lines used in pause routine
    boolean passedTarget = false;
    boolean belowTarget;
    float delta0;
    float delta1;
int modeState = 0;                    // use int for more than two modes
String comStatTxt = "not connected";
//String modeTxt = "Mode; continuous";
String dirTxt = "Inject";
String runStateTxt = "Run";
String[] comList ;               //A string to hold the ports in.
boolean Comselected = false;
int valvewritepos;
//float[] calCoefsA = {0,1};
int bkgd = #0289A2;
int box1Xpos = 10;
int box1Ypos = 78;
int box1Xsize = 310;
int box1Ysize = 100;
 int y2 = box1Ypos+box1Ysize+20;
 int off1 = 50;
 int off2 = 25;
       String runPtxt = "Run Pump";
  boolean pumpRunState = false;
  String pauseTxt = "Pause";
  
      int j;  // used durring communications with launchpad
      char b;
   boolean contRead = false;  // continuous read of pH  from read button
  boolean newData = false;
  /////////////////////// setup ///////////////////////////
  void setup() {
    size(350, 250);
    surface.setResizable(true);

font16 = createFont("ArialMT-16.vlw", 16);
font12 = createFont("ArialMT-16.vlw", 12);
textFont(font16);
    String sFile[] = loadStrings("calFile.txt");
   String tokens[];
    for (int j=1; j<5; j++){
      println(sFile[j]);
    tokens = split(sFile[j],',');
    //strPh[j-1] = tokens[0];
    strSyr[j-1] = tokens[1];  //  float(tokens[1]);
     strDia[j-1] = tokens[2]; //float(tokens[1]);
     strVol[j-1] = tokens[3];
     units[j-1] = tokens[4];
     strSpeed[j-1] = tokens[5];
    }
    String strMax = sFile[5];
    println(strMax);
    tokens = split(strMax,':');

    maxRatio = float(tokens[1]);
    println("max ratio: "+maxRatio);
    setupTxtFields();
    setupComPort();      // defined in Com_Port tab
    connect();           // defined in Com_Port tab
    setupButtons();      // defined in Buttons tab
  }             /// end of setup /////
  
  ///////////////// start of draw loop ////////
  
  void draw() {
     background(bkgd);  //#0289A2);    //#162181);
     stroke(255);
     noFill();
     text(comStatTxt, 65,25);
     textSize(16);
       text("Current Vol:",20,55);
       text(fVol,120,55);
       text("Zero vol",210,55);
       text("Syringe ",170,box1Ypos+123);
       text(units[syringe],150,box1Ypos +23);
       text("uL/s",260,box1Ypos+23);
       text("mm",290,228);
       if(paused){
       text("Paused",210,153);
       }
       if(speedFlag){
        text("Speed to high",240,box1Ypos+123); 
       }
          textSize(14);
 rect(box1Xpos,box1Ypos,box1Xsize,box1Ysize);
       text(dirTxt, 45,box1Ypos+17);

       text(runPtxt, 70, box1Ypos+70);
///////////////////////////////  //////////       
if (runState == true){
       read_serial(); 
}
  }
 
