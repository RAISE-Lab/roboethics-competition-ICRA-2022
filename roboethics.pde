// `Scenario` is a singleton object with global scope that defines the scene


void setup(){
  size(1920,1080); 
  Controller controller = new Controller();
  Scenario scene = Scenario.instance();

  for (Room room : scene.rooms) {
    room.init(this);
  }

  for (Character chara : scene.characters){
    chara.init(this);
  }

  for (Item item : scene.items){
    item.init(this);
  }
  // controller.BFS(Scenario.instance().kitchen);
  // controller.command(scene.dog, 
  //                    scene.teddyBear,
  //                    scene.roomsHM.get("BEDROOM2"));
  // controller.command(scene.mom, 
  //                    scene.teddyBear,
  //                    scene.mom);
                     
}


void draw(){
  background(0);
  updateRooms(Scenario.instance().rooms);    
}

void updateRooms(Room[] rooms){
    for (int i = 0 ; i < rooms.length ; i++){      
      rooms[i].update(this);
    }
}

//int roomParse(Room room, int offset){
//    print("in room "+room.name+"\n");
//    int padding = 50;
//    rect(120 + (offset), 80, 100, 100);
//    if(room.connections.size() == 0){
//      return offset + 1;
//    }
//    for (int i = 1 ; i <= room.connections.size() ; i++){
//      roomParse(room.connections.get(i-1), offset + i*padding);
//    }    
//    return 0;    
//}
