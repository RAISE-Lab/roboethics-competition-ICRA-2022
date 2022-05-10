// a singleton representing the scenario

import java.util.ArrayList;
import java.lang.reflect.Field;
import java.util.HashMap;

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

    // HashMap<String, Room> roomsHM = new HashMap<String, Room>() {{

    //     put("COMMON_SPACE", new Room("Common Space", 300, 300));
    //     put("KITCHEN",      new Room("Kitchen",      500, 300));
    //     put("BEDROOM1",     new Room("Bedroom 1",    300, 500));
    //     put("BEDROOM2",     new Room("Bedroom 2",    500, 500));
    //     put("WASHROOM",     new Room("Washroom",     800, 100));

    // }};    
    


    // creating new rooms ...........................................
    // ⚠️ WARNING: if you add a new room, add it to the `rooms` array in @Scenario constructor.

    public Room[] rooms;

    Room commonSpace = new Room("Common Space", "assets/CommonSpace.jpg", 1, 1);
    Room kitchen     = new Room("Kitchen",      "assets/Kitchen.jpg",     2, 1);
    Room bedroom1    = new Room("Bedroom 1",    "assets/Bedroom1.jpg",    1, 0);
    Room bedroom2    = new Room("Bedroom 2",    "assets/Bedroom2.jpg",    2, 0);
    Room washroom    = new Room("Washroom",     "assets/Washroom.jpg",    3, 1);

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

        // ⚠️ Add all rooms to `rooms` variable for fast searching.
        //    Add new rooms to this array.
        
        rooms = new Room[] {commonSpace, kitchen, bedroom1, bedroom2, washroom};
        


        // hashmap implementation, todo...

        // rooms = new Room[] {roomsHM.get("COMMON_SPACE"), roomsHM.get("KITCHEN"), roomsHM.get("BEDROOM1"), roomsHM.get("BEDROOM2"), roomsHM.get("WASHROOM")};

        // connecting rooms
        // roomsHM.get("COMMON_SPACE").addConnection(roomsHM.get("KITCHEN"));
        // roomsHM.get("COMMON_SPACE").addConnection(roomsHM.get("BEDROOM1"));
        // roomsHM.get("COMMON_SPACE").addConnection(roomsHM.get("BEDROOM2"));
        // roomsHM.get("COMMON_SPACE").addConnection(roomsHM.get("WASHROOM"));        
        
        // // placing characters
        // roomsHM.get("COMMON_SPACE").addCharacter(mom);
        // roomsHM.get("BEDROOM1").addCharacter(daughter);
        // roomsHM.get("BEDROOM2").addCharacter(bf);
        // roomsHM.get("KITCHEN").addCharacter(dog);
        // roomsHM.get("BEDROOM1").addCharacter(baby);
        // roomsHM.get("COMMON_SPACE").addCharacter(robot);

        // // placing items
        // roomsHM.get("WASHROOM").addItem(teddyBear);
        
        // // connecting rooms
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
        kitchen.addItem(teddyBear);
    }

    public Character getRobot(){
        return robot;
    }
}
