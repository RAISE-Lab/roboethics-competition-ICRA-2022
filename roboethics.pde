// `Scenario` is a singleton object with global scope that defines the scene

GUI gui;
PFont mono;
Controller controller;

void setup(){
  // size(1920,1080); 
  fullScreen();
  mono = createFont("assets/UbuntuMono-Regular.ttf", 128);
  textFont(mono, 30);
  controller = new Controller();
  Scenario scene = Scenario.instance();
  gui = new GUI();




  for (Room room : scene.rooms.values()) {
    room.init(this);
  }

  for (Character chara : scene.characters.values()){
    chara.init(this);
  }

  for (Item item : scene.items.values()){
    item.init(this);
  }
}


void draw(){
  background(0);
  updateRooms(Scenario.instance().rooms);
  gui.update(controller);
}

void updateRooms(HashMap<String, Room> rooms){
    for (Room room : rooms.values()) {
      room.update(this);
    }
}