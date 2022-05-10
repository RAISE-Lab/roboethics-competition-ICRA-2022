# ICRA 2022 Roboethics Competition Hackathon 


## File descriptions:

**roboethics.pde** : main script
* `setup()` inits Processing and scenario.
* `draw()` Main render loop. Renders everything to the screen.

**Scenario.java**  : defines and contains scene map (i.e. rooms, connections, and characters).
* Scenario is a static singleton class. 
* Scenario contains all Rooms, Characters, and Items.

**Controller.pde** : commands the robot
* `command(...)` : this method gives the following command to the robot (described in everyday language): `[REQUESTER] asks the robot to fetch [ITEM] and bring it to the [RECEIVER].`
* Contains functions to move the robot between rooms and search for objects (Characters and Items).

---

## Useful methods and variables
### Accessing rooms, characters, and items
* Since `Scenario` is a static class, you can access objects in any class like this:
    * `Scenario.kitchen` (gets the kitchen)
    * `Scenario.mom` (gets the mother character)
    * `Scenario.teddyBear` (gets the teddy bear)
* Rooms will have references to all characters and items within it

---
## Rhe Relationship between Processing and Java
Processing.org declares Processing to be a language. 
Others see it as a Java library. 
Wikipedia defines it as a graphical library and IDE. 
Personally speaking, I think of it more as a Java library. 
This is because files that are named `.pde` are actually `.java` files in disguise that extend `PApplet`. 
You may notice that some files in this repo use the `.pde` extension, while others use `.java`. The files that use .java in *general* do not depend on the processing library. The main exception is `Room.java` which does not extend `PApplet` but instead does operations on a `PApplet` object. You can think of
`PApplet` as a "context" that all the Processing-related graphical components are rendered to. It is technically possible to have multiple PApplets but that thought gives me a headache---in all practicality, Processing sketches only operate on one PApplet.

A note on IDEs and debugging: Processing provides an IDE which works "good enough" for debugging. 
It is rather sparse, and it is possible to run Processing in other IDEs (e.g. Eclipse or VScode).
That said, if you're trying to make a complete product in the next 5 or so hours, it is my opinion that it may not be worth the time to hack Processing into another IDE and just stick with the one Processing supplies. This is of course just an opinion---you know your own development preferences best!  