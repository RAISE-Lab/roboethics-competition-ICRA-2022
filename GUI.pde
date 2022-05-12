import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;
import java.util.Arrays;


class GUI {
    private static final int CONSOLE_HEIGHT = 200;
    private static final int BUTTON_HEIGHT = 100;
    private static final int BUTTON_WIDTH = 200;
    private static final int TEXT_SIZE = 30;
    private static final int MARGIN_LEFT = 10;
    private int TEXTLINE_YPOS = height - (CONSOLE_HEIGHT/2) - (TEXT_SIZE/2);
    private int BUTTONLINE_YPOS = height - (CONSOLE_HEIGHT/2) - (BUTTON_HEIGHT/2) - (TEXT_SIZE/2);

    private String currentRequester = "REQUESTER";
    private String currentTarget = "ITEM";
    private String currentReceiver = "RECEIVER";

    private ArrayList<String> requesterOptions;
    private ArrayList<String> targetOptions;
    private ArrayList<String> receiverOptions;

    // public int reciever;

    GUI(){
        this.requesterOptions = new ArrayList<String>(Scenario.instance().characters.keySet());
        this.targetOptions = new ArrayList<String>(Scenario.instance().items.keySet());
        // Set<String> characters = Scenario.instance().characters.keySet();
        // Set<String> rooms = Scenario.instance().rooms.keySet();
        this.receiverOptions = new ArrayList<String>();
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


        // bottom bar options

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

            println("clickled");
        };

        if(Button("> Execute", 
                  width - BUTTON_WIDTH - MARGIN_LEFT, 
                  BUTTONLINE_YPOS, 
                  BUTTON_WIDTH, 
                  BUTTON_HEIGHT)){

            println("current requester: "+this.currentRequester);
            println("current target: "+this.currentTarget);
            println("current rec: "+this.currentReceiver);
            

            controller.command(Scenario.instance().characters.get(this.currentRequester), 
                               Scenario.instance().items.get(this.currentTarget), 
                               Scenario.instance().characters.get(this.currentReceiver));
        };

        
    }
}