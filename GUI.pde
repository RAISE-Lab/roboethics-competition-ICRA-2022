import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import java.util.ArrayDeque;

class GUI {
    private static final int CONSOLE_HEIGHT = 200;
    private static final int BUTTON_HEIGHT = 100;
    private static final int BUTTON_WIDTH = 200;
    private static final int TEXT_SIZE = 30;
    private static final int MARGIN_LEFT = 10;
    private final int MARGIN_RIGHT = width - 100;
    private final int TEXTLINE_YPOS = height - (CONSOLE_HEIGHT/2) - (TEXT_SIZE/2);
    private final int CONSOLE_YBASE = height - 10;
    private final int BUTTONLINE_YPOS = height - (CONSOLE_HEIGHT/2) - (BUTTON_HEIGHT/2) - (TEXT_SIZE/2);
    private final int RIGHTLINE_YPOS = 300;
    private static final int MAX_CONSOLE_LINES = 6;

    private String currentRequester = "Amy Copper";
    private String currentTarget = "Credit Card";
    private String currentReceiver = "Jill Smith";

    private String itemToAdd = "Add";
    private String itemToRemove = "Remove";

    private ArrayList<String> requesterOptions;
    private ArrayList<String> targetOptions;
    private ArrayList<String> receiverOptions;
    private ArrayList<String> existingOptions;
    private ArrayList<String> newOptions;

    private ArrayList<String> rooms;

    private ArrayDeque<String> consoleLines;

    private UIState uiState; 
    
    roboethics robo;


    GUI(){

        this.requesterOptions = new ArrayList<String>(Scenario.instance().characters.keySet());
        this.targetOptions = new ArrayList<String>(Scenario.instance().items.keySet());

        this.receiverOptions = new ArrayList<String>();
        this.consoleLines = new ArrayDeque<String>(6);
        this.existingOptions = new ArrayList<String>();
        this.newOptions = new ArrayList<String>();
        this.existingOptions.addAll(this.requesterOptions);
        this.existingOptions.addAll(this.targetOptions);
        this.newOptions.addAll(this.existingOptions);
        this.rooms = new ArrayList<String>(Scenario.instance().rooms.keySet());

        this.uiState = UIState.INPUT;

        for (String characterName : Scenario.instance().characters.keySet()) {
            this.receiverOptions.add(characterName);
        }
        for (String roomName : Scenario.instance().rooms.keySet()) {
            this.receiverOptions.add(roomName);
        }
    }

    void update(Controller controller){
        fill(c_dark);
        rect(0, height-CONSOLE_HEIGHT, width, CONSOLE_HEIGHT);
        rect(width - 200, 0, 200, height - CONSOLE_HEIGHT);
        switch (uiState) {
            case INPUT:
                renderInputMenu();
                renderEditMenu();
                break;
            default:
                renderTerminalFeedback();
                break;
        }
    }
private void renderEditMenu(){
            text("Add/Remove", 
            MARGIN_RIGHT, 
            RIGHTLINE_YPOS - 30);

            if(Button(itemToAdd, MARGIN_RIGHT - BUTTON_WIDTH/2, RIGHTLINE_YPOS, BUTTON_WIDTH, BUTTON_HEIGHT)){
                String selectionAdd = new UiBooster().showSelectionDialog(
                                                                        "Select new item/character to add:",
                                                                        "Selected item/character",
                                                                        this.newOptions
                                                                        );


                if(selectionAdd != null){
                    String selectionRoom = new UiBooster().showSelectionDialog(
                                                                            "Select the room to add",
                                                                            "Selected the room to add",
                                                                            this.rooms
                                                                            );

                    if(selectionRoom != null){
                        this.existingOptions.add(selectionAdd);
                        this.requesterOptions.add(selectionAdd);
                        // we need one list for new items and one for new characters
                        // to check which one to add to the hashmap
                        // TODO


                    }

                }
                    
            };

            if(Button(itemToRemove, MARGIN_RIGHT - BUTTON_WIDTH/2, RIGHTLINE_YPOS + BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)){
                String selectionRemove = new UiBooster().showSelectionDialog(
                                                                        "Select existing item/character to remove:",
                                                                        "Selected item/character",
                                                                        this.existingOptions
                                                                        );
                if(selectionRemove != null) {
                    this.existingOptions.remove(selectionRemove);
                    this.newOptions.add(selectionRemove);
                    
                    // check if selection is from a hashmap
                    // if character, remove from characters hashmap
                    if(Scenario.instance().characters.containsKey(selectionRemove)){
                       this.requesterOptions.remove(selectionRemove);
                       this.receiverOptions.remove(selectionRemove);
                       Scenario.instance().rooms.get(Scenario.instance().relations.get(selectionRemove)).removeCharacter(Scenario.instance().characters.get(selectionRemove));
                       Scenario.instance().relations.remove(selectionRemove);
                       Scenario.instance().characters.remove(selectionRemove); 
                    }

                    if(Scenario.instance().items.containsKey(selectionRemove)){
                       this.targetOptions.remove(selectionRemove); 
                       Scenario.instance().rooms.get(Scenario.instance().relations.get(selectionRemove)).removeItem(Scenario.instance().items.get(selectionRemove));
                       Scenario.instance().relations.remove(selectionRemove);
                       Scenario.instance().items.remove(selectionRemove); 
                    }

                    // Scenario.instance().characters.remove(selection);
                    //gui.update(controller);
                    //robo.updateRooms(Scenario.instance().rooms);





                    // remove a key value pair from a hashmap

                    //Scenario.instance().items.remove(selection);

                }
            };
    }


    private void renderInputMenu(){
            if(Button(currentRequester, MARGIN_LEFT, BUTTONLINE_YPOS, BUTTON_WIDTH, BUTTON_HEIGHT)){
                String selection = new UiBooster().showSelectionDialog(
                                                                        "Select requester:",
                                                                        "Requester Character",
                                                                        this.requesterOptions
                                                                        );
                if(selection != null) currentRequester = selection;                
            };

            text("requests: bring", 
                MARGIN_LEFT + 330, 
                TEXTLINE_YPOS);

            if(Button(currentTarget, MARGIN_LEFT + 460, BUTTONLINE_YPOS, BUTTON_WIDTH, BUTTON_HEIGHT)){
                String selection = new UiBooster().showSelectionDialog(
                                                                        "Select item:",
                                                                        "Item to Bring",
                                                                        this.targetOptions
                                                                        );
                if(selection != null) currentTarget = selection;
            };

            text("to: ", 
                MARGIN_LEFT + 710, 
                TEXTLINE_YPOS);

            if(Button(currentReceiver, 
                    MARGIN_LEFT + 740, 
                    BUTTONLINE_YPOS, 
                    BUTTON_WIDTH, 
                    BUTTON_HEIGHT)){
                        String selection = new UiBooster().showSelectionDialog(
                                                                        "Select receiver:",
                                                                        "Destination",
                                                                        this.receiverOptions
                                                                        );
                if(selection != null) currentReceiver = selection;
            };

            if(Button("> Execute", 
                    width - BUTTON_WIDTH - MARGIN_LEFT, 
                    BUTTONLINE_YPOS, 
                    BUTTON_WIDTH, 
                    BUTTON_HEIGHT)){

                println("current requester: "+this.currentRequester);
                println("current target: "+this.currentTarget);
                println("current rec: "+this.currentReceiver);

                println("current receiver:");

                Entity destination = Scenario.instance().characters.get(this.currentReceiver);
                if(destination == null){
                    destination = Scenario.instance().rooms.get(this.currentReceiver);
                }

                controller.command(Scenario.instance().characters.get(this.currentRequester), 
                                Scenario.instance().items.get(this.currentTarget), 
                                destination);
                toggleState();
            };
    }

    public void renderTerminalFeedback(){
        fill(255,255,255);
        textAlign(LEFT);

        int i = 0;
        for (String msg : this.consoleLines) {
            if(msg != null){
                text(msg, MARGIN_LEFT, CONSOLE_YBASE - (i * TEXT_SIZE));
            }
            i++;
        }
    }

    public void updateTerminal(String msg){
        if(this.consoleLines.size() >= 6){
            this.consoleLines.removeLast();
        }
        this.consoleLines.push(msg);
    }

    public void toggleState(){
        if (this.uiState == UIState.INPUT) this.uiState = UIState.FEEDBACK;
        else this.uiState = UIState.INPUT;
    }
}
