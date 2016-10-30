# maze-solver
Processing project that generates a visualization of a maze and its solution.

<h2>Generating a Perfect Maze</h2>
<img src= "http://www.astrolog.org/labyrnth/maze/cruiser1.gif"/>
<br>
    Creating a standard perfect Maze usually involves "growing" the Maze while ensuring the no loops and no isolations restriction is kept. Start with the outer wall, and add a wall segment touching it at random. Keep on adding wall segments to the Maze at random, but ensure that each new segment touches an existing wall at one end, and has its other end in an unmade portion of the Maze. If you ever added a wall segment where both ends were separate from the rest of the Maze, that would create a detached wall with a loop around it, and if you ever added a segment such that both ends touch the Maze, that would create an inaccessible area. This is the wall adding method; a nearly identical way to do it is passage carved, where new passage sections are carved such that exactly one end touches an existing passage.

<h2>Solving Algorithm: Wall Follower</h2>
<img src="http://www.astrolog.org/labyrnth/sample/follow.gif"/>
<br>
    This is a simple Maze solving algorithm. It focuses on you, is always very fast, and uses no extra memory. Start following passages, and whenever you reach a junction always turn right (or left). Equivalent to a human solving a Maze by putting their hand on the right (or left) wall and leaving it there as they walk through. If you like you can mark what cells you've visited, and what cells you've visited twice, where at the end you can retrace the solution by following those cells visited once. This method won't necessarily find the shortest solution, and it doesn't work at all when the goal is in the center of the Maze and there's a closed circuit surrounding it, as you'll go around the center and eventually find yourself back at the beginning. Wall following can be done in a deterministic way in a 3D Maze by projecting the 3D passages onto the 2D plane, e.g. by pretending up passages actually lead northwest and down lead southeast, and then applying normal wall following rules.

<h2>References</h2>
http://stackoverflow.com/questions/9318534/creating-a-maze-solving-algorithm-in-java
http://www.astrolog.org/labyrnth/algrithm.htm
https://processing.org/
https://processing.org/reference/PImage_set_.html
