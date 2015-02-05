// BCB 4002 Assignment 1
// Game of Life
// Tete Zhang - Epidemiology

// import the library for the buttons
import controlP5.*;
ControlP5 controlP5;

// Color
color alive = color(0,200,0);
color infected = color(255,0,0);
color dead = color(0,0,0);

// Subject Array
int[][] subjects;
int[][] subjectsBuffer;
// Size
int squareSize = 4;

// Subject Evolution Factor, in percentage
// (The likeliness of a subject being alive initially)
int EF = 25;

// Subject Infection Factor, in percentage
// (The likeliness of a subject getting the disease initially; 
// Patient 0 in epidemiology)
float IF = 0.5;

// button event triggers
boolean air = false;
boolean fluid = false;
boolean blood = false;

// Pause Trigger
boolean pause = false;

void setup() {
  size(979,600); //size of the grid
  
  //set up epidemic mode buttons
  controlP5 = new ControlP5(this);
  controlP5.addButton("Airborne",0,700,560,40,10).setId(1);
  controlP5.addButton("Fluid",0,700,570,40,10).setId(2);
  controlP5.addButton("Blood",1,700,580,40,10).setId(3);
  
  //set up cell array
  subjects = new int[width/squareSize][height/squareSize];
  subjectsBuffer = new int[width/squareSize][height/squareSize];
  
  //grid color
  stroke(74);

  // set up random subject initial state
  for (int i = 0; i<width/squareSize; i++) {
    for (int j = 0; j<height/squareSize; j++) {
      float vital = random(100.01); //generate a random number 0-100
      
      //set the cell vitality according to evolution factor
      if (vital < EF && vital > IF) {
        vital = 1;
      }
      //set the number of sick subjects according to infection factor
      else if (vital < IF) {
        vital = 2;
      }
      // blank space
      else {
        vital = 0;
      }
      subjects[i][j] = int(vital); //save the subject vitality
    }
  }
  // set the display speed
  frameRate(2);
}

void draw(){
  background(0);
  
  //display initial subject vitality on the grid
  for (int i = 0; i<width/squareSize; i++) {
    for (int j = 0; j<height/squareSize; j++) {
      //pick out the proper color for each subject
      if (subjects[i][j] == 1) {
        fill(alive); //display an alive subject
      }
      else if (subjects[i][j] == 2) {
        fill(infected); //display an infected subject
      }
      else {
        fill(dead); //display a dead subject
      }
      //draw each cell
      rect(i*squareSize, j*squareSize, squareSize, squareSize);
    }
  }
  // apply the situation control to the initially drawn subjects
    control();
}
  //set the trigger events control & participate in reset pause
void control(){
  if (air) {
    if (!pause) {
      game1();
    }
  }
  if (fluid) {
    if (!pause) {
      game2();
    }
  }
  if (blood) {
     if (!pause) {
      game3();
    }
  }
}

// set trigger on when buttons are pressed
void controlEvent (ControlEvent theEvent) {
  if (theEvent.getId() == 1) {
    air = true;   
    pause = false;
  }
  if (theEvent.getId() == 2) {
    fluid = true;
    pause = false;
  }
  if (theEvent.getId() == 3) {
    blood = true;
    pause = false;
  }
}

// Reset function to set the subjects back to initial status
// Work in conjunction with mode change function
void keyPressed() {

  // set up random cell initial state
  if (key=='r' || key == 'R') {
  for (int i = 0; i<width/squareSize; i++) {
    for (int j = 0; j<height/squareSize; j++) {
      float vital = random(100.01); //generate a random number 0-100
      //set the subject vitality according to subject evolution factor
      if (vital < EF && vital > IF) {
        vital = 1;
      }
      else if (vital < IF) {
        vital = 2;
      }
      else {
        vital = 0;
      }
      subjects[i][j] = int(vital); //save the subject vitality
    }
  }
  // reset triggers
  pause = true;
  air = false;
  fluid = false;
  blood = false;
  }
}

// airborne disease transfer pattern
void game1(){
  
  //save subjects info to buffer
  for (int i=0; i<width/squareSize; i++) {
    for (int j=0; j<height/squareSize; j++) {
      subjectsBuffer[i][j] = subjects[i][j];
    }
  }
  
  //iterate over each subject
  for (int i=0; i<width/squareSize; i++) {
    for (int j=0; j<height/squareSize; j++) {
      //iterate over all eight neighbors of each subject
      int alivenb = 0; //count the neighbors who are alive
      int sicknb = 0; //count the neightbors who are infected
      for (int x=i-1; x<=i+1; x++) {
        for (int y=j-1; y<=j+1; y++) {
          if (((x>=0) && (x<width/squareSize)) && ((y>=0) && (y<height/squareSize))) {
            if (!((x==i) && (y==j))) {
              if (subjectsBuffer[x][y]==1) {
                alivenb ++;
              }
              else if (subjectsBuffer[x][y]==2) {
                sicknb ++;
              }
            }
          }
        }
      }
      
      //rules
      if (subjectsBuffer[i][j] == 0) {
        if (alivenb == 3) {
          subjects[i][j] = 1; 
        }
      }
      else if (subjectsBuffer[i][j] == 1) {
        if (alivenb < 2 || alivenb > 3) {
          subjects[i][j] = 0; 
        }
      }
      else if (subjectsBuffer[i][j] == 2) {
        if (alivenb >= 5 || sicknb >= 4 ) {
          if ((i+1)>=0 && (i+1)<width/squareSize && 
          (j+1)>=0 && (j+1)<height/squareSize &&
          (i-1)>=0 && (i-1)<width/squareSize &&
          (j-1)>=0 && (j-1)<height/squareSize) {
          subjects[i-1][j] = 2;
          subjects[i+1][j] = 2;
          subjects[i][j-1] = 2;
          subjects[i][j+1] = 2;
          subjects[i-1][j-1] = 2;
          subjects[i+1][j-1] = 2;
          subjects[i-1][j+1] = 2;
          subjects[i+1][j+1] = 2;
          }
        }
        else if (alivenb < 2 && sicknb == 0) {
          subjects[i][j] = 1; 
        }
        else if (sicknb == 0 && alivenb == 0) {
          subjects[i][j] = 0;
        }
      }
    }
  }
}

// fluid transmitting disease transfer pattern
void game2(){
  
  //save subjects info to buffer
  for (int i=0; i<width/squareSize; i++) {
    for (int j=0; j<height/squareSize; j++) {
      subjectsBuffer[i][j] = subjects[i][j];
    }
  }
  
  //iterate over each subject
  for (int i=0; i<width/squareSize; i++) {
    for (int j=0; j<height/squareSize; j++) {
      //iterate over all eight neighbors of each subject
      int alivenb = 0; //count the neighbors who are alive
      int sicknb = 0; //count the neightbors who are infected
      for (int x=i-1; x<=i+1; x++) {
        for (int y=j-1; y<=j+1; y++) {
          if (((x>=0) && (x<width/squareSize)) && ((y>=0) && (y<height/squareSize))) {
            if (!((x==i) && (y==j))) {
              if (subjectsBuffer[x][y]==1) {
                alivenb ++;
              }
              else if (subjectsBuffer[x][y]==2) {
                sicknb ++;
              }
            }
          }
        }
      }
      
      //rules
      if (subjectsBuffer[i][j] == 0) {
        if (alivenb == 3) {
          subjects[i][j] = 1; 
        }
      }
      else if (subjectsBuffer[i][j] == 1) {
        if (alivenb < 2 || alivenb > 3) {
          subjects[i][j] = 0; 
        }
      }
      else if (subjectsBuffer[i][j] == 2) {
        if (alivenb >= 5 || sicknb >= 4 ) {
          if ((i+1)>=0 && (i+1)<width/squareSize && 
          (j+1)>=0 && (j+1)<height/squareSize &&
          (i-1)>=0 && (i-1)<width/squareSize &&
          (j-1)>=0 && (j-1)<height/squareSize) {
          subjects[i-1][j] = 2;
          subjects[i+1][j] = 2;
          subjects[i][j-1] = 2;
          subjects[i][j+1] = 2;
          }
        }
        else if (alivenb < 4 && sicknb < 2) {
          subjects[i][j] = 1; 
        }
        else if (sicknb == 0 && alivenb == 0) {
          subjects[i][j] = 0;
        }
      }
    }
  }
}
  
// blood transmitting disease transfer pattern
void game3(){
  //save subjects info to buffer
  for (int i=0; i<width/squareSize; i++) {
    for (int j=0; j<height/squareSize; j++) {
      subjectsBuffer[i][j] = subjects[i][j];
    }
  }
  
  //iterate over each subject
  for (int i=0; i<width/squareSize; i++) {
    for (int j=0; j<height/squareSize; j++) {
      //iterate over all eight neighbors of each subject
      int alivenb = 0; //count the neighbors who are alive
      int sicknb = 0; //count the neightbors who are infected
      for (int x=i-1; x<=i+1; x++) {
        for (int y=j-1; y<=j+1; y++) {
          if (((x>=0) && (x<width/squareSize)) && ((y>=0) && (y<height/squareSize))) {
            if (!((x==i) && (y==j))) {
              if (subjectsBuffer[x][y]==1) {
                alivenb ++;
              }
              else if (subjectsBuffer[x][y]==2) {
                sicknb ++;
              }
            }
          }
        }
      }
      
      //rules
      if (subjectsBuffer[i][j] == 0) {
        if (alivenb == 3) {
          subjects[i][j] = 1; 
        }
      }
      else if (subjectsBuffer[i][j] == 1) {
        if (alivenb < 2 || alivenb > 3) {
          subjects[i][j] = 0; 
        }
      }
      else if (subjectsBuffer[i][j] == 2) {
        if (alivenb >= 5 || sicknb >= 4 ) {
          if ((i+1)>=0 && (i+1)<width/squareSize && 
          (j+1)>=0 && (j+1)<height/squareSize &&
          (i-1)>=0 && (i-1)<width/squareSize &&
          (j-1)>=0 && (j-1)<height/squareSize) {
          subjects[i][j-1] = 2;
          subjects[i][j+1] = 2;
          }
        }
        else if (sicknb == 0 && alivenb == 0) {
          subjects[i][j] = 0;
        }
      }
    }
  }
}
