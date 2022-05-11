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


    // public int reciever;

    GUI(){}

    void update(Controller controller){
        fill(c_dark);
        rect(0, height-CONSOLE_HEIGHT, width, CONSOLE_HEIGHT);


        // bottom bar options

        if(Button(currentRequester, MARGIN_LEFT, BUTTONLINE_YPOS, BUTTON_WIDTH, BUTTON_HEIGHT)){
            String selection = new UiBooster().showSelectionDialog(
                                                                    "Select requester:",
                                                                    "Requester Character",
                                                                    Arrays.asList(
                                                                        Util.getNames(Scenario.instance().characters)
                                                                  ));
            if(selection != null) currentRequester = selection;                
        };

        text("requests: bring", 
             MARGIN_LEFT + 330, 
             TEXTLINE_YPOS);

        if(Button(currentTarget, MARGIN_LEFT + 460, BUTTONLINE_YPOS, BUTTON_WIDTH, BUTTON_HEIGHT)){
            String selection = new UiBooster().showSelectionDialog(
                                                                    "Select item:",
                                                                    "Item to Bring",
                                                                    Arrays.asList(
                                                                        Util.getNames(Scenario.instance().items)
                                                                  ));
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

                      String[] characters = Util.getNames(Scenario.instance().characters);
                      String[] rooms = Util.getNames(Scenario.instance().rooms);
                      ArrayList<String> options = new ArrayList();
                      for (String characterName : characters) {
                          options.add(characterName);
                      }
                      for (String roomName : rooms) {
                          options.add(roomName);
                      }
                      String selection = new UiBooster().showSelectionDialog(
                                                                    "Select receiver:",
                                                                    "Destination",
                                                                    options
                                                                    );
            if(selection != null) currentReceiver = selection;

            println("clickled");
        };

        if(Button("> Execute", 
                  width - BUTTON_WIDTH - MARGIN_LEFT, 
                  BUTTONLINE_YPOS, 
                  BUTTON_WIDTH, 
                  BUTTON_HEIGHT)){
            controller.command(Scenario.instance().mom, 
                               Scenario.instance().teddyBear, 
                               Scenario.instance().bf);
        };

        
    }
}