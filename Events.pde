public void controlEvent(ControlEvent theEvent) {

  if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}
