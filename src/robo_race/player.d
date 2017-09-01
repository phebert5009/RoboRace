module robo_race.player;

import robo_race.mobile;
import dsfml.graphics;

class Player : MobilePiece {
    this(string imageFile, Vector2f position = Vector2f(0,0)) {
        current.position = position;
        super(imageFile);
    }
}
