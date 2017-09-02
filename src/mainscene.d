import robo_race;
import dsfml.graphics;
import scene;
import gui.button;
import std.meta;

class MainScene : Scene {
    Grid grid;
    Player player;
    Deck deck;
    Hand hand;
    SceneManager manager;
    Button playHand, resetGame, newHand;
    
    static MainScene instance;
    
    static this() {
        instance = new MainScene();
    }
    
    private this() {
        deck = Deck(6);
        enum float btnRow = 9*90+10;
        enum float wHeight = 40*12+120;
        AliasSeq!(uint,uint) btnSize;btnSize[0] = 90; btnSize[1] = 30;
        resetGame = new Button(btnSize);
        resetGame.position = Vector2f(btnRow,wHeight-btnSize[1]);
        resetGame.text = "new game";
        playHand = new Button(btnSize);
        playHand.position = Vector2f(btnRow,wHeight-btnSize[1]*2);
        playHand.text = "play hand";
        newHand = new Button(btnSize);
        newHand.position = Vector2f(btnRow,wHeight-btnSize[1]*3);
        newHand.text = "new hand";
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
        resetGame.draw(target,states);
        newHand.draw(target,states);
    }
    
    override void handleEvent(Event event) {
        import std.stdio;
        if(event.type == Event.EventType.MouseButtonReleased) {
            if(event.mouseButton.button == Mouse.Button.Left) {
                hand.register(event.mouseButton.x,event.mouseButton.y);
            }
            if(playHand.clicked(event.mouseButton.x,event.mouseButton.y)) {
                hand.act(player);
                writeln(playHand.text);
            }
            if(resetGame.clicked(event.mouseButton.x,event.mouseButton.y)) {
                manager.changeScene(this);
                writeln(resetGame.text);
            }
            if(newHand.clicked(event.mouseButton.x,event.mouseButton.y)) {
                hand.discardAll(deck);
                hand.drawCards(deck);
                writeln(newHand.text);
            }
        }
    }
}
