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
    Room kitchen = new Room("Kitchen", 500, 300);
    Room bedroom1 = new Room("Bedroom 1", 300, 500);
    Room bedroom2 = new Room("Bedroom 2", 500, 500);

    // characters .................................................
    Character mom = new Character("Jill Smith");  
    Character daughter = new Character("Amy Copper");  
    Character baby = new Character("Ben");  
    Character dog = new Character("Buddy");  
    Character bf = new Character("V");
  

    private Scenario(){

        // -----------------------------------------------------------\\
        // creating map
        // -----------------------------------------------------------//        
        rooms = new Room[] {commonSpace, kitchen, bedroom1, bedroom2};
        
        // connecting rooms
        commonSpace.addConnection(kitchen);
        commonSpace.addConnection(bedroom1);
        commonSpace.addConnection(bedroom2);
        
        // placing characters
        commonSpace.addCharacter(mom);
        bedroom2.addCharacter(daughter);
        bedroom2.addCharacter(bf);
        kitchen.addCharacter(dog);
        bedroom1.addCharacter(baby);
    }
}
