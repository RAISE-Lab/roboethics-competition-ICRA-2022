import java.util.ArrayList;
import processing.core.PApplet;
import processing.core.PImage;

class Room extends Entity
{
 public ArrayList<Item> items;
 public ArrayList<Character> characters;
 public ArrayList<Room> connections;
 
 private PImage img;
 private String imagePath;
 protected float _x;
 protected float _y;
 protected int width = 400;
 private int iconSize = 60;
 private float iconPadding = 20;
 
  Room(String name, String imagePath, float x, float y){
    super(name, imagePath);
    this.items = new ArrayList<Item>();
    this.connections = new ArrayList<Room>();    
    this.characters = new ArrayList<Character>();
    this.items = new ArrayList<Item>();
    this._x = x;
    this._y = y;
    this.imagePath = imagePath;
  }

  public void init(PApplet papplet){
    this.img = papplet.loadImage(this.imagePath);
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

  protected void removeItem(Item item){
    for (int i = 0; i < this.items.size(); i++) {
      if(this.items.get(i) == item){
        this.items.remove(i);
      }
    }
  }
  
  protected void removeCharacter(Character chara){
    this.characters.remove(chara);
  }
  
  public void update(PApplet papplet){
  
    papplet.image(this.img, 
                  this._x * this.width, 
                  this._y * this.width, 
                  this.width, 
                  this.width);
    
    // place items
    int yPosItem = -1;
    for (int i = 0; i < this.items.size(); i++) {
      if(i%6 == 0) yPosItem++;
      this.items.get(i).getImage(papplet, 
                            this._x * this.width + ((i % 6) * 60) + this.iconPadding, 
                            this._y * this.width + yPosItem * 60 + this.iconPadding, 
                            this.iconSize, 
                            this.iconSize);
    }

    // place characters
    int yPosChara = -1;
    for (int i = 0; i < characters.size(); i++) {
      if(i%5 == 0) yPosChara++;
      characters.get(i).getImage(papplet, 
                                 this._x * this.width   + ((i % 5) * 60) + this.iconPadding, 
                                 (this._y * this.width) + this.width/2 - this.iconSize/2   + yPosChara * 60, 
                                 this.iconSize, 
                                 this.iconSize);
      characters.get(i).update(papplet);
    }
    papplet.tint(255, 255);
    // this.characters.forEach(chara -> {
    //   chara.getImage(papplet, thix.x)
    // }};
  }
}
