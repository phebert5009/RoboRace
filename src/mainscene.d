import robo_race;
import dsfml.graphics;
import scene;

class MainScene : Scene {
    Grid grid;
    Player player;
    Deck deck;
    Hand hand;
    SceneManager manager;
    
    static MainScene instance;
    
    static this() {
        instance = new MainScene();
    }
    
    private this() {
        deck = Deck(6);
    }
    
    override bool init() {
        player = new Player("objects/Player1.png",Vector2f(5,5));
        hand.drawCards(deck);
        grid = new Grid();
        
        //start of tmp code
        hand.register(0);
	    hand.register(4);
	    hand.register(2);
	    hand.register(7);
	    hand.register(3);
	    hand.act(player);
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
    }
    
    override void handleEvent(Event event) {
        
    }
}
