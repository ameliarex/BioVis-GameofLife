README:
---
BCB4002 Lab#3 
---

Tete Zhang

**Previous Interaction Activities**

1. The user is able to press key "R" or "r" to reset the screen to the initial random state. This key press would also pause the display until the user command otherwise. 
2. The user is able to select the disease transmit pattern from one of "Airborne", "Fluid", and "Blood". 

**New Interaction Activity Ideas**

1. The user can change the speed of display by pressing key "+" (to increase) and key "-" (to decrease). This way the display can serve the users' personal preferences better than before. 
2. The user can type in a specific cell generation with the disease transmission state, choose the transmission pattern from a drop down list and hit the "show" button on screen to see one specific generation of the healthy and sick cells. This way the users can see precisely the cell behavior and disease spread pattern at any appointed generation and collect generation related data. 
3. The user can click on the black squares to add and/or delete healthy cells (green) and/or sick cells (red). This way the users are allowed to design their own start scenario for the diseases and living cells. Some interesting effects relating to the Game of Life ideas could be tested manually. 

**New Interaction Techniques**

1. Add another portion to the keyPressed() function to change the display to a different frameRate(). 
2. Add an input box, a drop down list and a button to the screen from the controlP5 library. Read from the input box and the drop down list. Add a new function to run the transmission pattern read from the drop down list for the number of generations read from the input box (set up a counter to stop the function), and display the final results on the screen. 
3. Write another portion to the keyPressed() function. After key "S" or "s" (sick) is pressed, the point that the user clicked is map() processed and cross referenced with the saved cell status ("vital"). If this vital value equals 0 or 1, the color of this square (cell) is changed into red after the mousePressed(). Similarly, after key "H" or "h" (healthy) is pressed, the cell color is changed to green. After key "D" or "d" is pressed, the cell color is changed to black. 

**The first interaction is implemented to the Assignment 1 code.**