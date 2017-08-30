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
    protected Vector2i _position;
    protected Texture texture;
    protected Sprite sprite;
    
    this(Texture txt) {
        texture = txt;
        sprite = new Sprite();
        sprite.setTexture(txt);
        auto lob = sprite.getLocalBounds;
        sprite.origin = Vector2f(lob.width/2,lob.height/2);
    }
    
    Vector2f position() @property {
        Vector2f ans;
        // first center on tile.
        auto glob = sprite.getGlobalBounds;
        auto hCenter = glob.width / 2;
        auto vCenter = glob.height / 2;
        ans += Vector2f(20-hCenter,20-vCenter);
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
            _position += Vector2i(n,0);
        } else if(sprite.rotation == 180) {
            _position += Vector2i(0,-n);
        } else if(sprite.rotation == 270) {
            _position += Vector2i(-n,0);
        }
        sprite.position = position;
    }
    
    void moveLeft(int n = 1) { // for crabLegs
        if(sprite.rotation == 0) {
            _position += Vector2i(n,0);
        } else if(sprite.rotation == 90) {
            _position += Vector2i(0,n);
        } else if(sprite.rotation == 180) {
            _position += Vector2i(-n,0);
        } else if(sprite.rotation == 270) {
            _position += Vector2i(0,-n);
        }
        sprite.position = position;
    }
    
    void moveGlobal(Direction direction, int n = 1) {
        if(direction%2) n = -n;
        if(direction/2) { //horizontal
            _position += Vector2i(n,0);
        } else { //vertical
            _position += Vector2i(0,n);
        }
        sprite.position = position;
    }
    
    void draw(RenderTarget target, RenderStates states) {
        sprite.draw(target, states);
    }
}
