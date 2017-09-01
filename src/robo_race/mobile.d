module robo_race.mobile;

import dsfml.graphics;
import std.container : DList;

enum Direction {
	up,
	down,
	right,
	left
}

/// pieces that can move, such as players or goals
class MobilePiece : Drawable {
	struct State {
		float rotation = 0;
		Vector2f position = Vector2f(0,0);
		float travelPt;
	}
	protected enum float velocity = 0.03f;
	protected Texture texture;
	protected State current = State(0,Vector2f(0,0),0), delta = State(0,Vector2f(0,0),velocity);
	protected DList!State box;
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
		ans += current.position * 40;
		return ans;
	}
	
	void turnRight() {
	    State tmp;
		tmp.rotation = 90;
		box ~= tmp;
	}
	
	void turnLeft() {
		State tmp;
		tmp.rotation = -90;
		box ~= tmp;
	}
	
	void uTurn() {
		State tmp;
		tmp.rotation = 180;
		box ~= tmp;
	}
	
	void move(int n = 1) {
	    State tmp;
		tmp.position = Vector2f(0,n);
		box ~= tmp;
	}
	
	void moveLeft(int n = 1) { // for crabLegs
		State tmp;
		tmp.position = Vector2f(n,0);
		box ~= tmp;
	}
	
	void moveGlobal(Direction direction, int n = 1) {
	    State tmp;
		if(direction%2) n = -n;
		if(direction/2) { //horizontal
			tmp.position = Vector2f(n,0);
		} else { //vertical
			tmp.position = Vector2f(0,n);
		}
		box ~= tmp;
	}

	void update() {
	    import std.math;
	    if(immobile) {
	        if(box.empty) return;
	        delta = box.front;
	        delta.travelPt = velocity;
	        if(current.rotation == 90) {
			    delta.position = Vector2f(-delta.position.y,-delta.position.x);
		    } else if(current.rotation == 180) {
			    delta.position = Vector2f(-delta.position.x,-delta.position.y);
		    } else if(current.rotation == 270) {
			    delta.position = Vector2f(delta.position.y,delta.position.x);
		    }
	        box.removeFront();
	    }
		if(current.travelPt >= 1.0f) {
		    current.position.x = current.position.x.round();
		    current.position.y = current.position.y.round();
		    current.rotation = roundRotation(current.rotation);
		    current.travelPt = 0;
		    delta = State.init;
		    delta.travelPt = velocity;
		} else {
	        current.position += delta.position * delta.travelPt;
		    current.rotation += delta.rotation * delta.travelPt;
		    current.travelPt += delta.travelPt;
		}
	}
	
	bool immobile() @property {
	    if(delta.position == Vector2f(0,0) && delta.rotation == 0.0f) return true;
	    return false;
	}
	

	void draw(RenderTarget target, RenderStates states) {
		update();
		sprite.position = position;
		sprite.rotation = current.rotation;
		sprite.draw(target, states);
	}
}

struct MoveInfo {
	MobilePiece movingPiece;
	Direction travelDir;
}

/// gets the angle to the nearest 0,90,180, or 270 degrees
float roundRotation(float rotation) {
    while(true) {
        if(rotation < 45 && -45 < rotation) return rotation = 0;
        if(rotation < 135 && 45 <= rotation) return rotation = 90;
        if(rotation < 225 && 135 <= rotation) return rotation = 180;
        if(rotation < 315 && 225 <= rotation) return rotation = 270;
        if(315 <= rotation) {
            rotation -= 360;
        }
        if(rotation <= -45) {
            rotation += 360;
        }
    }
}
