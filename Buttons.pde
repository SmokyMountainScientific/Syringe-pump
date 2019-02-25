// Buttons tab
// Titraumatic_3 GUI

 void setupButtons() {
    PImage[] run_imgs = {loadImage("run_button1.png"),loadImage("run_button2.png"),loadImage("run_button3.png")};
    PImage[] stop_imgs = {loadImage("stop_button1.png"),loadImage("stop_button2.png"),loadImage("stop_button3.png")};
    PImage[] togs = {loadImage("tog_button1.png"),loadImage("tog_button2.png"),loadImage("tog_button3.png")};
 cp5 = new ControlP5(this);  
 

   
  runPump = cp5.addButton("runPump")
     .setPosition(20,box1Ypos+50)
     .setSize(30,30)
    .setImages(run_imgs)
   ;

   
    dirButton = cp5.addButton("dirButton")     //  dirrection button
     .setPosition(20,box1Ypos+6)  //off2)  // y position was 50
     .setSize(30,20)
        .setImages(togs)   //stop_imgs)
    ;
    
    cp5.addButton("zero")
    .setPosition(190,43)
    .setSize(30,20)
    .setImages(togs)
    ;
    
        cp5.addButton("syr")
    .setPosition(150,box1Ypos+113)
    .setSize(30,20)
    .setImages(togs)
    ;
  
                
  loadCal  = cp5.addButton("loadCal")                          // program is at bottom of this tab
            .setPosition(30, 2*box1Ypos+40)
              .setSize(50, 20)
                  .setLabel("Load File") //
                      ;
    readCal =   cp5.addButton("writeCal")                          // program is at bottom of this tab
           .setPosition(90, 2*box1Ypos+40)
              .setSize(50, 20)
                  .setLabel("Write File") //
                      ;


    pause = cp5.addButton("pause")                          // program is at bottom of this tab
        .setPosition(160, box1Ypos+off1+5)
              .setSize(40, 30);
             
 }


public void dirButton() {
 boolDir =! boolDir;
 if(boolDir == false) {
  println ("direction = inject");
  dirTxt = "Inject";
 }
else {
 println ("direction = withdraw");
  dirTxt = "Withdraw";
} 
} 



void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    file2 = selection.getAbsolutePath();
    println("User selected " + file2);
   // myTextarea.setText(file2);
      ///////////////////////////////////////
  //  String file2 = "C:/Users/Ben/Documents/Voltammetry Stuff/log/data.txt";
  try{
    saveStrings(file2,file1);
  //saveStream(file2,file1);
      }
      catch(Exception e){}              
            
          }}
          
 public void loadCal() {                                       // load the calibration file
 selectInput("Select a file:", "fileToLoad");
}

void fileToLoad(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    String[] sFile = loadStrings(selection.getAbsolutePath());
 //   for (int j = 0; j<3; j++){
   //    String[] tokens = split(file2str[j+1],',');
       
for (int j=1; j<5; j++){
      println(sFile[j]);
    String tokens[] = split(sFile[j],',');
    //strPh[j-1] = tokens[0];
    strSyr[j-1] = tokens[1];  //  float(tokens[1]);
     strDia[j-1] = tokens[2]; //float(tokens[1]);
     strVol[j-1] = tokens[3];
     units[j-1] = tokens[4];
     strSpeed[j-1] = tokens[5];
    }
  }
  setupTxtFields();

}
    

   
void zero(){
      fVol = 0;
    }
    
 void syr(){
   getParams();  // needed to save current parameters input
 syringe++;
 syringe = syringe%4;
 println("syringe: "+syringe);
 cp5Txt.get(Textfield.class, "volume").setText(strVol[syringe]);  // set volume
// println("volume set");
 cp5Txt.get(Textfield.class, "speed").setText(strSpeed[syringe]);  // set speed
 cp5Txt.get(Textfield.class, "diam").setText(strDia[syringe]);  // set volume
  cp5Txt.get(Textfield.class, "syringe").setText(strSyr[syringe]);  // set volume
 // set up text files
 }
