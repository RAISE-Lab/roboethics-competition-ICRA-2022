import java.util.ArrayList;
import processing.core.PApplet;

class Room extends Entity
{
 public ArrayList<Item> items;
 public ArrayList<Character> characters;
 public ArrayList<Room> connections;
 
 private int _x;
 private int _y;
 
  Room(String name, int x, int y){
    super(name);
    this.items = new ArrayList<Item>();
    this.characters = new ArrayList<Character>();
    this.connections = new ArrayList<Room>();    
    this._x = x;
    this._y = y;
  }
  
  public void addConnection(Room room){
    if(room == this){
      System.out.println("ERROR! Can't add room to itself! Room: "+room.name);
      return;
    }
    if(this.connections.contains(room)){
      return;
    }
    System.out.println("connected "+this.name+" --> "+room.name);
    this.connections.add(room);
    room.addConnection(this);
  }
  
  protected void addCharacter(Character chara){
    
    // TODO:
    // scan all other rooms to make sure agent doesn't exist elsewhere
    // if exists elsewhere, remove it from the room
    // then add to room
    // may need a controller pattern
    this.characters.add(chara);
  }
  
  protected void removeCharacter(Character chara){
    this.characters.remove(chara);
  }
  
  public void update(PApplet papplet){
    papplet.rect(_x, _y, 100, 100);
  }
}
