import java.util.Queue;
import java.util.Deque;
import java.util.ArrayDeque;
import java.util.LinkedList;
import java.util.HashMap;
import java.util.Collections;
import java.util.Arrays;

class Controller {

    Scenario scene = Scenario.instance();
    Character robot;

    Controller() {
        robot = scene.getRobot();
    }

    public void command(Character requester, Item item, Entity receiver){

        // TODO: remove item from room and place it in new room.
        //       should probably make a function `moveItem` to do this.

        // REQUESTER asks the robot to fetch ITEM and bring it to RECEIVER
        // requester := a Character
        // item := an interactable objec
        // reciever := a Room or Character to bring the item to

        Room fetchRoom = getRoomItemIsIn(item);
        Room destination;

        println("COMMAND: "+"["+requester.name+"] asks the robot to bring ["+item.name+"] to ["+receiver.name+"]");

        if(receiver instanceof Room){
            destination = (Room)receiver;
        }
        else if (receiver instanceof Character){
            destination = getRoomCharacterIsIn((Character)receiver);
            println(destination);
        }
        else{
            destination = getCurrentRobotRoom();
            println("Reciever is of an invalid type");
        }

        // move to item
        ArrayList<Room> pathToItem = BFS(fetchRoom);
        travel(pathToItem);
        print("''[-.-] --{picked up "+item.name+")");
        fetchRoom.removeItem(item);
        delay(3000);
        ArrayList<Room> pathToReceiver = BFS(destination);
        travel(pathToReceiver);
        destination.addItem(item);
        print("![^-^] --{brought item to: "+receiver.name+")");
    }

    

    private void travel(ArrayList<Room> path){
        // println("travel path: ");
        // println(path);
        if (path.get(0) == getCurrentRobotRoom()){
            println("  ['_'] ...");
            return;
        }
        path.forEach(room -> {
            moveRobot(getCurrentRobotRoom(), room);
        });
    }

    private void moveRobot(Room from, Room to){
        from.removeCharacter(robot);
        println("*~ [o_o] --{beep boop moving to room: "+to.name+")");
        to.addCharacter(robot);
        delay(1000);        
    }

    private Room getRoomItemIsIn(Item item){
        // finds the room an item is in and returns it
        for (int i = 0; i < scene.rooms.length; i++) {
            if(scene.rooms[i].items.contains(item)){
                return scene.rooms[i];
            }
        }
        print("Cannot find item! Is it not placed in a room?");
        return new Room("ITEM_NOT_FOUND", "", 0,0);
    }

    private Room getRoomCharacterIsIn(Character chara){
        // finds the room an item is in and returns it
        for (int i = 0; i < scene.rooms.length; i++) {
            if(scene.rooms[i].characters.contains(chara)){
                println("Found "+chara.name+" in room: "+scene.rooms[i].name);
                return scene.rooms[i];
            }
        }
        print("Cannot find character! Do they exist or are they not in the apartment?");
        return new Room("CHARACTER_NOT_FOUND","",0,0);
    }

    class Edge{
        Room from;
        Room to;
        int cost;
        Edge(Room from, Room to, int cost){
            this.from = from;
            this.to = to;
            this.cost = cost;
        }
    }

    public ArrayList<Room> BFS(Room targetRoom){
        // conducts a breadth-first-search and returns a path to a targetRoom
        // targetRoom := a Room that an object of interest is in
        // returns: an ArrayList of rooms for the robot to travel through
        // if for whatever reason the algorithm cannot find the room
        // (i.e. it was not connected to other rooms), the the method
        // will just return the targetRoom and the robot will appear
        // to teleport.
        

        Room startingRoom = getCurrentRobotRoom(); // room robot is currently in
        ArrayList<Room> visited = new ArrayList<Room>(); // saves list of visited rooms (graph is bidirectional, prevents loops)
        Queue<Room> queue = new LinkedList<Room>(); // bfs uses queue
        ArrayList<Edge> distanceTable = new ArrayList<Edge>(); // creates a table of edges between rooms (nodes) and their 
                                                               // unweighted distance from the startingRoom

        println("\nsearching for path from "+startingRoom.name+" ~> "+targetRoom.name);
        
        if(startingRoom == targetRoom) return new ArrayList<Room>(Arrays.asList(targetRoom));
        
        int cost = 0; // distance from starting room

        queue.add( startingRoom ); // start of BFS algorithm
        distanceTable.add( new Edge(startingRoom, startingRoom, cost) );
        while(queue.size() != 0){
            
            cost++;
            Room currentRoom = queue.poll();
            ArrayList<Room> adjacentRooms = currentRoom.connections;

            for (Room room : adjacentRooms) {
                if(!visited.contains(room)){
                    visited.add(room);                    
                    distanceTable.add(new Edge(currentRoom, room, cost));
                    if(room == targetRoom){
                        // we get the path here by recursively iterating through parent nodes
                        ArrayList<Room> navPath = ReconstructPath(distanceTable, room);

                        return navPath;
                    }
                    queue.add(room);
                }
            }
        }
    print("WARNING: cannot find target room! Initiating teleportation sequence...");
    return(new ArrayList<Room>(Arrays.asList(targetRoom)));
    }

    private ArrayList<Room> ReconstructPath(ArrayList<Edge> edges, Room target){
        // reconstructs a path to a target room from a matrix of edges
        ArrayList<Room> path = new ArrayList<Room>();
        for (Edge edge : edges) {
            if(edge.to == target){
                ArrayList<Room> reconstructedPath = ReconstructPathUtil(path, edge, edges);
                Collections.reverse(reconstructedPath);
                // println("reconstructed path:");
                // reconstructedPath.forEach(e -> print(e.name+" "));
                // print("\n");
                return (reconstructedPath);
            }
        }
        println("WARNING: TARGET ROOM CANNOT BE FOUND! Returning null path");  
        return new ArrayList<Room>();
    }


    private ArrayList<Room> ReconstructPathUtil(ArrayList<Room> path, Edge edge, ArrayList<Edge> edges){      
        // recursive utility function for ReconstructPath
        // builds an ArrayList (path) of prev rooms                  
        if(edge.to == edge.from){
            return(path);
        }
        else{            
            for (Edge e : edges) {
                if(e.to == edge.from){
                    path.add(edge.to);
                    return ReconstructPathUtil(path, e, edges );
                }
            }
        }
        print("WARNING: cannot find parent node! Returning truncated path");
        return path;
    }

    private Room getCurrentRobotRoom(){
        for (int i = 0; i < scene.rooms.length; i++) {
            if(scene.rooms[i].characters.contains(robot)){
                return scene.rooms[i];
            }
        }
        println("ERROR: CANNOT FIND ROBOT! Has it not been placed in a room, or does Scenario.java not have a reference to the Room?");
        return new Room("ROBOT_NOT_FOUND","",0,0); // a bit hacky lol
    }


    private void printEdgeInfo(Edge edge){
        // for debugging
        println("edge---");
        println("from: "+edge.from.name+"\n"+
                "to: "  +edge.to.name+"\n"+
                "cost: "+edge.cost);   
    }

    
}
