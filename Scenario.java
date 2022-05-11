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
    public Character[] characters;
    public Item[] items;

    Room commonSpace = new Room("Common Space", "assets/CommonSpace.jpg", 1f, 1f);
    Room kitchen     = new Room("Kitchen",      "assets/Kitchen.jpg",     2f, 1f);
    Room bedroom1    = new Room("Bedroom 1",    "assets/Bedroom1.jpg",    0.5f, 0.0f);
    Room bedroom2    = new Room("Bedroom 2",    "assets/Bedroom2.jpg",    1.5f, 0.0f);
    Room washroom    = new Room("Washroom",     "assets/Washroom.jpg",    3f, 1f);

    // characters .................................................
    Character mom      = new Character("Jill Smith", "assets/characters/mom.png");  
    Character daughter = new Character("Amy Copper", "assets/characters/daughter.png");  
    Character baby     = new Character("Ben",        "assets/characters/bebe.png");  
    Character dog      = new Character("Buddy",      "assets/characters/dog.png");  
    Character bf       = new Character("V",          "assets/characters/bf.png");
    Character robot    = new Character("Robot",      "assets/characters/robot.png");

    // items ......................................................
    Item teddyBear = new Item("Teddy", "assets/items/item-icon.png");
    Item creditCard = new Item("Credit Card", "assets/items/credit_card.png");
    Item wallet = new Item("Wallet", "assets/items/wallet.png");
    Item knife = new Item("Knife", "assets/items/knife.png");
    Item beer = new Item("Beer", "assets/items/beer.png");
    Item diary = new Item("Diary", "assets/items/diary.png");
 



    
    private Scenario(){

        // -----------------------------------------------------------\\
        // creating map        
        // -----------------------------------------------------------//

        // ⚠️ Add all rooms to `rooms` variable for fast searching.
        //    Add new rooms to this array.
        
        this.rooms      = new Room[]      {commonSpace, kitchen, bedroom1, bedroom2, washroom};
        this.characters = new Character[] {mom, daughter, baby, dog, bf, robot};
        this.items      = new Item[]      {teddyBear, creditCard, wallet, knife, beer, diary};
        
        
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
        kitchen.addConnection(washroom);        
        
        // placing characters
        commonSpace.addCharacter(mom);
        bedroom2.addCharacter(daughter);
        bedroom2.addCharacter(bf);
        kitchen.addCharacter(dog);
        bedroom1.addCharacter(baby);
        commonSpace.addCharacter(robot);

        // placing items
        kitchen.addItem(teddyBear);
        kitchen.addItem(knife);
        bedroom2.addItem(diary);
        commonSpace.addItem(creditCard);
        bedroom1.addItem(wallet);
        washroom.addItem(beer);

    }

    public Character getRobot(){
        return robot;
    }
}
