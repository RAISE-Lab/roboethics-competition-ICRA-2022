import java.util.ArrayList;
import processing.core.PApplet;

class Room extends Entity
{
 public ArrayList<Item> items;
 public ArrayList<Character> characters;
 public ArrayList<Room> connections;
 
 protected int _x;
 protected int _y;
 protected int width = 100;
 
  Room(String name, int x, int y){
    super(name);
    this.items = new ArrayList<Item>();
    this.connections = new ArrayList<Room>();    
    this.characters = new ArrayList<Character>();
    this.items = new ArrayList<Item>();
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

  protected void addItem(Item item){
    this.items.add(item);
  }
  
  protected void removeCharacter(Character chara){
    this.characters.remove(chara);
  }
  
  public void update(PApplet papplet){
    this.connections.forEach((other)->{
      papplet.stroke(0,0,255);
      papplet.strokeWeight(3);
      papplet.line(this._x + (this.width/2), 
                   this._y + (this.width/2), 
                   other._x + (other.width/2), 
                   other._y + (other.width/2));
    });
    papplet.strokeWeight(0);
    papplet.rect(_x, _y, width, width);
  }
}
