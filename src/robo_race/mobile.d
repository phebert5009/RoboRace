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
		float rotation = 0;
		Vector2f position = Vector2f(0,0);
		float travelPt;
	}
	protected enum float velocity = 0.03f;
	protected Texture texture;
	protected State current = State(0,Vector2f(0,0),0), delta = State(0,Vector2f(0,0),velocity);
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
		sprite.rotation = 90;
	}
	
	void turnLeft() {
		delta.rotation = -90;
	}
	
	void uTurn() {
		delta.rotation = 180;
	}
	
	void move(int n = 1) {
		if(sprite.rotation == 0) {
			delta.position = Vector2i(0,n);
		} else if(sprite.rotation == 90) {
			delta.position = Vector2i(-n,0);
		} else if(sprite.rotation == 180) {
			delta.position = Vector2i(0,-n);
		} else if(sprite.rotation == 270) {
			delta.position = Vector2i(n,0);
		}
	}
	
	void moveLeft(int n = 1) { // for crabLegs
		if(sprite.rotation == 0) {
			delta.position = Vector2f(n,0);
		} else if(sprite.rotation == 90) {
			delta.position = Vector2f(0,-n);
		} else if(sprite.rotation == 180) {
			delta.position = Vector2f(-n,0);
		} else if(sprite.rotation == 270) {
			delta.position = Vector2f(0,n);
		}
	}
	
	void moveGlobal(Direction direction, int n = 1) {
		if(direction%2) n = -n;
		if(direction/2) { //horizontal
			delta.position = Vector2f(n,0);
		} else { //vertical
			delta.position = Vector2f(0,n);
		}
	}

	void update() {
	    import std.math;
	    if(delta.position == Vector2f(0,0) && delta.rotation == 0.0f) return;
		if(current.travelPt >= 1.0f) {
		    import std.stdio;
		    //writeln(current.position);
		    current.position.x = current.position.x.round();
		    current.position.y = current.position.y.round();
		    current.rotation = current.rotation.round();
		    //writeln(current.position);
		    current.travelPt = 0;
		    delta = State.init;
		    delta.travelPt = velocity;
		} else {
	        current.position += delta.position * delta.travelPt;
		    current.rotation += delta.rotation * delta.travelPt;
		    current.travelPt += delta.travelPt;
		}
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
