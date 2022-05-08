// a singleton representing the scenario

import java.util.ArrayList;

class Scenario {

   // -----------------------------------------------------------\\
   // singleton method
   // -----------------------------------------------------------//
    private static Scenario _instance = null;

    public static Scenario instance(){
        if (_instance == null){
            _instance = new Scenario();
        }
        return _instance;
    }
    
   // -----------------------------------------------------------\\
   // defining scenario objects
   // -----------------------------------------------------------//

    // rooms ......................................................
    Room[] rooms;

    Room commonSpace = new Room("Common Space", 300, 300);
    Room kitchen     = new Room("Kitchen",      500, 300);
    Room bedroom1    = new Room("Bedroom 1",    300, 500);
    Room bedroom2    = new Room("Bedroom 2",    500, 500);
    Room washroom    = new Room("Washroom",     800, 100);

    // characters .................................................
    Character mom = new Character("Jill Smith");  
    Character daughter = new Character("Amy Copper");  
    Character baby = new Character("Ben");  
    Character dog = new Character("Buddy");  
    Character bf = new Character("V");
    Character robot = new Character("Robot");

    // items ......................................................
    Item teddyBear = new Item("Teddy");
  
    
    private Scenario(){

        // -----------------------------------------------------------\\
        // creating map        
        // -----------------------------------------------------------//

        // Add all rooms to `rooms` variable for fast searching.
        rooms = new Room[] {commonSpace, kitchen, bedroom1, bedroom2, washroom};
        
        // connecting rooms
        commonSpace.addConnection(kitchen);
        commonSpace.addConnection(bedroom1);
        commonSpace.addConnection(bedroom2);
        commonSpace.addConnection(washroom);        
        
        // placing characters
        commonSpace.addCharacter(mom);
        bedroom2.addCharacter(daughter);
        bedroom2.addCharacter(bf);
        kitchen.addCharacter(dog);
        bedroom1.addCharacter(baby);
        commonSpace.addCharacter(robot);

        // placing items
        washroom.addItem(teddyBear);
    }

    public Character getRobot(){
        return robot;
    }
}
