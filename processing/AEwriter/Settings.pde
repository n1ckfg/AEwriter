class Settings {

  Data settings;

  Settings(String _s) {
    try {
      settings = new Data();
      settings.load(_s);
      for (int i=0;i<settings.data.length;i++) {
        if (settings.data[i].equals("Receive OSC Active")) useOsc = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("OSC Receive Port")) receivePort = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Write AE Script")) writeAE = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("Write Maya Script")) writeMaya = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("Stage Width")) sW = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Stage Height")) sH = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Stage Depth")) sD = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Destination AE Comp Width")) dW = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Destination AE Comp Height")) dH = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Destination AE Comp Depth")) dD = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Framerate")) fps = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Use Borders")) borders = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("Number of Particles")) numParticles = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Use AE Motion Blur")) motionBlur = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("Apply AE Effects")) applyEffects = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("Smoothing Amount")) smoothNum = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Particle Trace Color")) traceColor = setColor(settings.data[i+1]);
       }
    } 
    catch(Exception e) {
      println("Couldn't load settings file. Using defaults.");
    }
  }

  int setInt(String _s) {
    return int(_s);
  }

  float setFloat(String _s) {
    return float(_s);
  }

  boolean setBoolean(String _s) {
    return boolean(_s);
  }

  String setString(String _s) {
    return ""+(_s);
  }
  
  color setColor(String _s) {
    color endColor = color(0);
    int commaCounter=0;
    String sr = "";
    String sg = "";
    String sb = "";
    String sa = "";
    int r = 0;
    int g = 0;
    int b = 0;
    int a = 0;

    for (int i=0;i<_s.length();i++) {
        if (_s.charAt(i)!=char(' ') && _s.charAt(i)!=char('(') && _s.charAt(i)!=char(')')) {
          if (_s.charAt(i)==char(',')){
            commaCounter++;
          }else{
          if (commaCounter==0) sr += _s.charAt(i);
          if (commaCounter==1) sg += _s.charAt(i);
          if (commaCounter==2) sb += _s.charAt(i); 
          if (commaCounter==3) sa += _s.charAt(i);
         }
       }
     }

    if (sr!="" && sg=="" && sb=="" && sa=="") {
      r = int(sr);
      endColor = color(r);
    }
    if (sr!="" && sg!="" && sb=="" && sa=="") {
      r = int(sr);
      g = int(sg);
      endColor = color(r, g);
    }
    if (sr!="" && sg!="" && sb!="" && sa=="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      endColor = color(r, g, b);
    }
    if (sr!="" && sg!="" && sb!="" && sa!="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      a = int(sa);
      endColor = color(r, g, b, a);
    }
      return endColor;
  }
}

