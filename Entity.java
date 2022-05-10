import processing.core.PApplet;
import processing.core.PImage;

// TODO: each entity has a PImage and filepath associated with it.
class Entity extends PApplet {
  // they also have an init(PApplet)
  String name;
  
  Entity(String name){
    this.name = name;
  }
}
