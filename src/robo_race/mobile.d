module robo_race.mobile;

import dsfml.graphics;

enum Direction {
    up,
    down,
    right,
    left
}

/// pieces that can move, such as players or goals
class MobilePiece : Drawable {
    struct State {
        float rotation;
        Vector2f position;
    }
    protected Vector2i _position;
    protected Texture texture;
    protected State current, target;
    protected Sprite sprite;
    
    this(string imageFile) {
        texture = new Texture();
        if(!texture.loadFromFile(imageFile)) throw new Exception("unable to load texture: " ~ imageFile);
        sprite = new Sprite();
        sprite.setTexture(texture);
        auto lob = sprite.getLocalBounds;
        sprite.origin = Vector2f(lob.width/2,lob.height/2);
    }
    
    Vector2f position() @property {
        Vector2f ans = Vector2f(0.0f,0.0f);
        // first center on tile.
        ans += Vector2f(20,20);
        // then place on specific tile
        ans += _position * 40;
        return ans;
    }
    
    void turnRight() {
        sprite.rotation = sprite.rotation + 90;
        sprite.rotation = sprite.rotation % 360;
    }
    
    void turnLeft() {
        sprite.rotation = sprite.rotation - 90;
        sprite.rotation = (sprite.rotation + 360) % 360;
    }
    
    void uTurn() {
        sprite.rotation = sprite.rotation + 180;
        sprite.rotation = sprite.rotation % 360;
    }
    
    void move(int n = 1) {
        if(sprite.rotation == 0) {
            _position += Vector2i(0,n);
        } else if(sprite.rotation == 90) {
            _position += Vector2i(-n,0);
        } else if(sprite.rotation == 180) {
            _position += Vector2i(0,-n);
        } else if(sprite.rotation == 270) {
            _position += Vector2i(n,0);
        }
    }
    
    void moveLeft(int n = 1) { // for crabLegs
        if(sprite.rotation == 0) {
            _position += Vector2i(n,0);
        } else if(sprite.rotation == 90) {
            _position += Vector2i(0,-n);
        } else if(sprite.rotation == 180) {
            _position += Vector2i(-n,0);
        } else if(sprite.rotation == 270) {
            _position += Vector2i(0,n);
        }
    }
    
    void moveGlobal(Direction direction, int n = 1) {
        if(direction%2) n = -n;
        if(direction/2) { //horizontal
            _position += Vector2i(n,0);
        } else { //vertical
            _position += Vector2i(0,n);
        }
    }
    
    void draw(RenderTarget target, RenderStates states) {
        sprite.position = position;
        sprite.draw(target, states);
    }
}
