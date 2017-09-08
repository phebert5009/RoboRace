module scene;

import dsfml.graphics;
import gui.button;
/**
 * Construct representing an in-game scene.
 * It is recommended that every scene has a referende to the manager
 */
interface Scene : Drawable {
    /**
     * Do when the scene is opened.
     * Returns: true if initialization was successful
     */
    bool init();
    /// Do when the scene is closed
    bool close();
    /// allows for handling events
    void handleEvent(Event event);
}

class SceneManager : Drawable {
    private Scene currScene;

    this(Scene initialScene) {
        currScene = initialScene;
        currScene.init();
    }

    bool changeScene(Scene scene) {
        currScene.close();
        currScene = scene;
        return currScene.init();
    }

    void handleEvent(Event event) {
        if(event.type == Event.EventType.Closed) {
            currScene.close();
        }
        currScene.handleEvent(event);
    }

    void draw(RenderTarget target, RenderStates states) {
        currScene.draw(target,states);
    }
}

SceneManager manager;


class MainScene : Scene {
    import robo_race;
    import std.meta;

    Grid grid;
    Player player;
    Deck deck;
    Hand hand;
    Button playHand, resetGame, newHand, exit;

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
        resetGame.position = Vector2f(btnRow,wHeight-btnSize[1]*2);
        resetGame.text = "new game";
        playHand = new Button(btnSize);
        playHand.position = Vector2f(btnRow,wHeight-btnSize[1]*3);
        playHand.text = "play hand";
        newHand = new Button(btnSize);
        newHand.position = Vector2f(btnRow,wHeight-btnSize[1]*4);
        newHand.text = "new hand";
        exit = new Button(btnSize);
        exit.position = Vector2f(btnRow,wHeight-btnSize[1]);
        exit.text = "exit";
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
        exit.draw(target,states);
    }

    override void handleEvent(Event event) {
        if(event.type == Event.EventType.MouseButtonReleased) {
            if(event.mouseButton.button == Mouse.Button.Left) {
                hand.register(event.mouseButton.x,event.mouseButton.y);

                if(playHand.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    hand.act(player);
                }
                if(resetGame.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    manager.changeScene(this);
                }
                if(newHand.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    hand.discardAll(deck);
                    hand.drawCards(deck);
                }
                if(exit.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    manager.changeScene(MenuScene.instance);
                }
            }
        }
    }
}

class MenuScene : Scene {
    Button playbtn, boardBuilderBtn;

    public static MenuScene instance;

    static this() {
        instance = new MenuScene();
    }

    this() {
        playbtn = new Button(120,50);
        playbtn.position = Vector2f(120,50);
        playbtn.text = "play";
        playbtn.characterSize = 19;
        boardBuilderBtn = new Button(120,50);
        boardBuilderBtn.position = Vector2f(120,150);
        boardBuilderBtn.text = "board builder";
        boardBuilderBtn.characterSize = 19;
    }

    override bool init() {
        return true;
    }

    override bool close() {
        return true;
    }

    override void draw(RenderTarget target, RenderStates states) {
        playbtn.draw(target,states);
        boardBuilderBtn.draw(target,states);
    }

    override void handleEvent(Event event) {
        if(event.type == Event.EventType.MouseButtonReleased) {
            if(event.mouseButton.button == Mouse.Button.Left) {
                if(playbtn.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    manager.changeScene(MainScene.instance);
                }
            }
        }
    }
}
