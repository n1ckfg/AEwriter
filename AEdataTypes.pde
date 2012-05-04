//position
void AEdataPosInit() {
  data.add("Transform" + "\t" + "Position");
  data.add("\t" + "Frame" + "\t" + "X pixels" + "\t" + "Y pixels");
}

void AEdataPosWrite() {
  data.add("\t" + counter  
    + "\t" + (p.x * (dW/sW))
    + "\t" + (p.y * (dH/sH))
    ); //gets to the child we need //gets to the child we need
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//puppet pin
int pinNum = 1;

void AEdataPuppetInit() {
  data.add("Effects" + "\t" + "Puppet #2" + "\t" + "arap #3" + "\t" + "Mesh" + "\t" + "Mesh #1" + "\t" + "Deform" + "\t" + "Pin #" + pinNum + "\t" + "Position");
  data.add("\t" + "Frame" + "\t" + "X pixels" + "\t" + "Y pixels");
}

void AEdataPuppetWrite() {
  data.add("\t" + counter  
    + "\t" + (p.x * (dW/sW))
    + "\t" + (p.y * (dH/sH))
    ); //gets to the child we need //gets to the child we need
}

