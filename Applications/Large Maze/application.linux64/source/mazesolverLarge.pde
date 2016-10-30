
PImage img, oimg;
int width = 49; // VSpace widthidth 
int height = 49; // VSpace heighteight 
int size = 6;  // Block size 
int g; 

int[] VSpace  = new int[width*height+height]; 
int[] VSpace2 = new int[width*height+height];
String[] grid = new String[width*height+height];
int i, x, y;
int u, v;
int it;




void setup() { 
  //initial maze
  img = createImage(width*size, height*size, RGB);
  //saved maze
  oimg = createImage(width*size, height*size, RGB);

  //initalize canvas
  size(294, 294);

  for (i = 0; i < (width * height) -1; i ++) VSpace[i] =0;

  g= 0;

  //generate maze
  VSpaceSetup(VSpace, 1, 1);
  // set goal
  VSpace[width+1] = 2;

  //set start point
  VSpace[(width-2)*width+(height-1)] = 1;
  
  //draw canvas and initalize grid
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      switch( VSpace[y*width+x] ) { 
        //blocked
      case 0: 
        grid[y*width+x] ="X ";
        noStroke(); 
        fill(0); 
        rect(x*size, y*size, x*size+size, y*size+size); 
        break;
      case 1: 
      //open
        grid[y*width+x] = "  ";
        stroke(255); 
        fill(255); 
        rect(x*size, y*size, x*size+size, y*size+size); 
        break; 
      case 2: 
      //closed
        grid[y*width+x] = "X ";
        stroke(255); 
        fill(color(255,0,0,255)); 
        rect(x*size, y*size, x*size+size, y*size+size); 
        break;
      }
    }
  }
  fill(color(0,255,0));
  rect((width-2)*size,(height-1)*size, (width-2)*size+size, (height-1)*size+size);
  
  //print initial grid
//  printGrid();
  
  

  u = width - 5;
  v = height - 5;
  
  //maze solver
//  follow(); 
  
  //print second grid after maze solving algorithm has been run
  printGrid();
  
}

//recursive agent that moves in the first open cardinal direction by priority N E S W until goal state or 100 iterations
void follow(){
 it++;
 
 //iterating the recursive step 100x
 if(it > 100){
   return;
 }
 System.out.print("Follow(): ");
 

 //check if goal not reached
 if(VSpace[u * height + v] != 2){
   //set traveled in img, canvas, and grid
   fill(color(0,0,255));
   //rect(x*size, y *size,size,size);
   oimg.set(u,v,color(255,0,0,50));
//north
    if(VSpace[u * height + (v+1)] == 1){
      System.out.println(" N");
     v++;
      follow(); 
    }
    //east
    else if(VSpace[(u+1) * height + (v)] == 1){
       System.out.println(" E");
      u++;
      follow(); 
    }
    //south
    else if(VSpace[(u) * height + (v-1)] == 1){
     System.out.println(" S");
      v--;
      follow(); 
    }
    //west
    else if(VSpace[(u-1) * height + (v)] == 1){
     System.out.println(" W");
      u--;
      follow(); 
    }
  }
  else{
    System.out.println("corner!");
  }
  for(int j = 0; j < height; j++){
    for(int i = 0; i < width; i++){
      System.out.print(oimg.get(i,j) + "  ");
      if(oimg.get(i,j) <= 0){
        System.out.println("blackie");
        oimg.set(i,j,color(0,0,0,0));      
      }
    }
  }
 image(oimg, 0,0);
  
}

//print grid with x and y labels
void printGrid(){

  int c =0;
      System.out.print("   ");
  for(int jj = 0; jj < width; jj++, c++){
    
    if(jj == 10){
      jj = 0;
    }
    System.out.print(jj + " ");
    if(c == width){
      break;
    }
  }
  System.out.println();
    for ( int j = 0; j < height; j++) {
      if(j < 10) System.out.print(j + "  " );
      else System.out.print(j + " ");
    for (int ii = 0; ii < width; ii++) {
    System.out.print(VSpace[ii * height + j]);
  
}
    System.out.println();
  }

  System.out.println();
}


void VSpaceSetup(int[] VSpace, int x, int y) { 
  g ++; 
  VSpace[y*width+x] = 1; 

  int count = isValid(VSpace, x, y); 

  while (count > 0) { 
    switch (int(random(1)*4)) { 
    case 0: 
      if (isValidStep(VSpace, x, y-2) > 0) { 
        VSpace[(y-1)*width+x] = 1; 
        VSpaceSetup(VSpace, x, y-2);
      } 
      break; 
    case 1: 
      if (isValidStep(VSpace, x+2, y) > 0) { 
        VSpace[y*width+x+1] = 1; 
        VSpaceSetup (VSpace, x+2, y);
      } 
      break; 
    case 2: 
      if (isValidStep(VSpace, x, y+2) > 0) { 
        VSpace[(y+1)*width+x] = 1; 
        VSpaceSetup (VSpace, x, y+2);
      } 
      break; 
    case 3: 
      if (isValidStep(VSpace, x-2, y) > 0) { 
        VSpace[y*width+x-1] = 1; 
        VSpaceSetup (VSpace, x-2, y);
      } 
      break;
    } 
    count = isValid(VSpace, x, y);
  } 

  g--;
}  


public int isValidStep(int[] VSpace, int x, int y) { 
  int result = 0; 
  if (x>=0 && x<width && y>=0 && y<height 
    && VSpace[y*width+x] == 0) result = 1; 
  return result;
} 

public int isValid(int[] VSpace, int x, int y) { 
  int result = 0; 

  result += isValidStep(VSpace, x, y-2); 
  result += isValidStep(VSpace, x+2, y); 
  result += isValidStep(VSpace, x, y+2); 
  result += isValidStep(VSpace, x-2, y); 

  return result;
}