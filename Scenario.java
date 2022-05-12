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

    public static HashMap<String, Room> rooms = new HashMap<String, Room>() {{


        // Room commonSpace = new Room("Common Space", "assets/CommonSpace.jpg", 1f, 1f);
        // Room kitchen     = new Room("Kitchen",      "assets/Kitchen.jpg",     2f, 1f);
        // Room bedroom1    = new Room("Bedroom 1",    "assets/Bedroom1.jpg",    0.5f, 0.0f);
        // Room bedroom2    = new Room("Bedroom 2",    "assets/Bedroom2.jpg",    1.5f, 0.0f);
        // Room washroom    = new Room("Washroom",     "assets/Washroom.jpg",    3f, 1f);

        put("Common Space",  new Room("Common Space", "assets/CommonSpace.jpg", 1f, 1f));
        put("Kitchen",       new Room("Kitchen",      "assets/Kitchen.jpg",     2f, 1f));
        put("Bedroom 1",     new Room("Bedroom 1",    "assets/Bedroom1.jpg",    0.5f, 0.0f));
        put("Bedroom 2",     new Room("Bedroom 2",    "assets/Bedroom2.jpg",    1.5f, 0.0f));
        put("Washroom",      new Room("Washroom",     "assets/Washroom-old.jpg",    3f, 1f));

    }}; 

    // characters .................................................

    public static HashMap<String, Character> characters = new HashMap<String, Character>(){{

        put("Jill Smith", new Character("Jill Smith", "assets/characters/mom.png"));
        put("Amy Copper", new Character("Amy Copper", "assets/characters/daughter.png"));
        put("Ben",        new Character("Ben",        "assets/characters/bebe.png"));
        put("Buddy",      new Character("Buddy",      "assets/characters/dog.png"));
        put("V",          new Character("V",          "assets/characters/bf.png"));
        put("Robot",      new Character("Robot",      "assets/characters/robot.png"));

    }};


    // items ......................................................

    public static HashMap<String, Item> items = new HashMap<String, Item>(){{
        put("Credit Card", new Item("Credit Card", "assets/items/credit_card.png")); 
        put("Wallet",      new Item("Wallet", "assets/items/wallet.png")); 
        put("Knife",       new Item("Knife", "assets/items/knife.png")); 
        put("Beer",        new Item("Beer", "assets/items/beer.png")); 
        put("Diary",       new Item("Diary", "assets/items/diary.png")); 

    }};
 
    
    private Scenario(){

        // -----------------------------------------------------------\\
        // creating map        
        // -----------------------------------------------------------//

        // connecting rooms ............................................
        rooms.get("Common Space").addConnection(rooms.get("Kitchen"));
        rooms.get("Common Space").addConnection(rooms.get("Bedroom 1"));
        rooms.get("Common Space").addConnection(rooms.get("Bedroom 2"));
        rooms.get("Kitchen")     .addConnection(rooms.get("Washroom"));        
        
        // placing characters ..........................................
        rooms.get("Common Space").addCharacter(characters.get("Jill Smith"));
        rooms.get("Bedroom 1")   .addCharacter(characters.get("Amy Copper"));
        rooms.get("Bedroom 2")   .addCharacter(characters.get("Ben"));
        rooms.get("Kitchen")     .addCharacter(characters.get("Buddy"));
        rooms.get("Bedroom 1")   .addCharacter(characters.get("V"));
        rooms.get("Common Space").addCharacter(characters.get("Robot"));


        // placing items .............................................
        rooms.get("Kitchen")     .addItem(items.get("Knife"));
        rooms.get("Bedroom 2")   .addItem(items.get("Diary"));
        rooms.get("Common Space").addItem(items.get("Credit Card"));
        rooms.get("Bedroom 1")   .addItem(items.get("Wallet"));
        rooms.get("Washroom")    .addItem(items.get("Beer"));       

    }

    public Character getRobot(){
        return characters.get("Robot");
    }
}
