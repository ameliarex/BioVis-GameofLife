README: 
---
BCB4002 HW1 
---
Tete Zhang

**Description:**

This program visualizes the transmission of an imaginary epidemic disease in air, through fluid exchange, or through blood exchange. The disease can transmit through dead subjects as well. 

The first generation of living subjects is generated randomly with a living possibility of 25%. The first generation of infected subjects (patient 0 in epidemiology) is generated randomly with a living possibility of 0.5% for all three transmission modes. 

All healthy subjects are following the classic John Conway's Game of Life set of rules: 

For a space that is populated, 

1. Each subject with one or no neighbors dies, as if by loneliness. 
2. Each subject with four or more neighbors dies, as if by overpopulation. 
3. Each subject with two or three neighbors survives. 

For a space that is unpopulated,

1. Each space with three neighbors becomes populated. 

The airborne model transmits following rules listed below: 

For a subject who is sick, 

1. If the subject has more than 4 healthy neighbors or more than 3 sick neighbors, all neighbors including the subject gets sick.
2. If the subject has less than 2 healthy neighbors and no sick neighbor, the sick subject is cured and become a healthy subject. 
3. If the subject has no neighbor, healthy or sick, the subject dies. 

The fluid based model transmits following rules listed below: 

For a subject who is sick, 

1. If the subject has more than 4 healthy neighbors or more than 3 sick neighbors, the 4 neighbors that touches the subject square's sides gets sick. 
2. If the subject has less than 4 healthy neighbors and less than 2 sick neighbor, the sick subject is cured and become a healthy subject. 
3. If the subject has no neighbor, healthy or sick, the subject dies. 

The blood based model transmits following rules listed below: 

For a subject who is sick, 

1. If the subject has more than 4 healthy neighbors or more than 3 sick neighbors, the neighbor sits above and below the subject gets sick.
2. The blood based disease cannot be cured.
3. If the subject has no neighbor, healthy or sick, the subject dies.

Biological significance: 

1. The red squares grow in different patterns, modeling the different transmission pathways of an epidemic disease. 
2. The disease transmits in a way that minimal treatment is given to all patients, representing an epidemic disease's transmission pattern before the disease is well studied and an effective treatment is developed.
3. The user is able to reset the display window whenever they want and run a new transmission model they would like to see visualized. 

Technical significance: 

1. The user is able to reset the display window whenever they want and run a new transmission model they would like to see visualized. 

**Instructions:**

1. Download the hw1.pde file. 
2. Open the hw1.pde file in Processing. 
3. Hit "Run" to run the program. 
4. Click on button "Airborne", "fluid", or "blood" to display the transmission pattern you would like to see. 
5. Press "R" or "r" key to reset the screen.
6. Click on another button for a different pattern. 