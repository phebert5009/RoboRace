module robo_race.player;

import robo_race.mobile;
import dsfml.graphics;

class Player : MobilePiece {
    this() {
        Texture texture = new Texture();
        if(!texture.loadFromFile("objects/Player.png")) throw new Exception("player texture not found");
        super(texture);
    }
}
