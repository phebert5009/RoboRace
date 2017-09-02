import robo_race;
import dsfml.graphics;
import scene;
import gui.button;

class MainScene : Scene {
    Grid grid;
    Player player;
    Deck deck;
    Hand hand;
    SceneManager manager;
    Button playHand;
    
    static MainScene instance;
    
    static this() {
        instance = new MainScene();
    }
    
    private this() {
        deck = Deck(6);
        playHand = new Button(90,20);
        playHand.position = Vector2f(9*90+10,40*12+100);
        playHand.text = "play hand";
    }
    
    override bool init() {
        player = new Player("objects/Player1.png",Vector2f(5,5));
        hand.drawCards(deck);
        grid = new Grid();
        
        //start of tmp code
        /*hand.register(0);
	    hand.register(4);
	    hand.register(2);
	    hand.register(7);
	    hand.register(3);
	    hand.act(player);*/
	    //end of tmp code
        return true;
    }
    
    override bool close() {
        hand.discardAll(deck);
        //player will be deallocated when init() is called
        //deck was restarted by hand.discardAll
        //grid will be reloaded in init
        return true;
    }
    
    override void draw(RenderTarget target, RenderStates states) {
        grid.draw(target,states);
        player.draw(target,states);
        hand.draw(target,states);
        playHand.draw(target,states);
    }
    
    override void handleEvent(Event event) {
        if(event.type == Event.EventType.MouseButtonReleased) {
            if(event.mouseButton.button == Mouse.Button.Left) {
                hand.register(event.mouseButton.x,event.mouseButton.y);
            }
            if(playHand.clicked(event.mouseButton.x,event.mouseButton.y)) {
                hand.act(player);
            }
        }
    }
}
