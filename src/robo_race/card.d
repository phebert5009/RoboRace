module robo_race.card;

import dsfml.graphics;
import robo_race.player;
import defaults;
//private string ratio = "1:3:3:1:3:2:1" // met ceci dans deck.d, comme fonction pour créer un deck

class Card : Drawable {
    alias opCmp = Object.opCmp;
    private uint _priority;
    private string _name;
    private RenderTexture texture;
    private Sprite sprite;
    Vector2f position = Vector2f(0,0);
    package int registered = -1;
    private void delegate(Player) action;

    static Texture bkg;
    static this() {
        bkg = new Texture();
        if(!bkg.loadFromFile("objects/card.png")) throw new Exception("card.png not found");
    }

    uint priority() @property {
        return _priority;
    }

    string name()  @property {
        return _name;
    }

    this(uint priority, int factor) {
        _priority = priority;
        setName(factor);
    }

    void act(Player player) {
        action(player);
    }

    void setName (int factor) {
        factor *= 10;
        if (priority <= factor) {
            _name = "U-Turn";
            action = (player){player.uTurn();};
        } else if (factor < priority && priority <= factor * 7) {
            if (priority % 20 == 10) {
                _name = "Left";
                action = (player){player.turnLeft();};
            } else {
                _name = "Right";
                action = (player){player.turnRight();};
            }
        } else if (factor * 7 < priority && priority <= factor * 8) {
            _name = "Back Up";
            action = (player){player.move(-1);};
        } else if (factor * 8 < priority && priority <= factor * 11) {
            _name = "Move 1";
            action = (player){player.move();};
        } else if (factor * 11 < priority && priority <= factor * 13) {
            _name = "Move 2";
            action = (player){player.move(2);};
        } else if (factor * 13 < priority && priority <= factor * 14) {
            _name = "Move 3";
            action = (player){player.move(3);};
        } else _name = "unknown"; // if this happens: Error
    }

    int opCmp(Card other) {
        if(priority < other.priority) return -1;
        else if(priority > other.priority) return 1;
        else return 0;
    }

    void initTexture () {
        import std.conv;
        texture = new RenderTexture();
        texture.create(90, 120);
        Sprite sprite = new Sprite();
        sprite.setTexture(bkg);
        texture.draw(sprite);
        Text text1 = new Text();
        text1.setString(name);
        text1.setColor(Color.Green);
        text1.setFont(defaultFont);
        text1.setCharacterSize = 16;
        text1.position(Vector2f(17, 85));
        texture.draw(text1);
        Text text2 = new Text();
        text2.setString(priority.to!string);
        text2.setColor(Color.Green);
        text2.setFont(defaultFont);
        text2.setCharacterSize = 12;
        text2.position(Vector2f(52, 11));
        texture.draw(text2);
        texture.display();
    }

    override string toString() {
        import std.conv;
        return name ~ "("~ (registered != -1 ? "=":"") ~ priority.to!string ~ ")";
    }

    override void draw(RenderTarget target, RenderStates states) {
        if(!texture)initTexture();
        if(!sprite) {
            sprite = new Sprite();
            sprite.setTexture(texture.getTexture);
        }
        sprite.position = position;
        sprite.draw(target,states);
    }
}
