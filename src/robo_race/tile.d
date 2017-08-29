module robo_race.tile;

import dsfml.graphics

enum Walls : byte {
    none           = 0b0000,
    north          = 0b0001,
    east           = 0b0010,
    northeast      = 0b0011,
    south          = 0b0100,
    northsouth     = 0b0101,
    southeast      = 0b0110,
    northsoutheast = 0b0111,
    west           = 0b1000,
    northwest      = 0b1001,
    eastwest       = 0b1010,
    northeastwest  = 0b1011,
    southwest      = 0b1100,
    northsouthwest = 0b1101,
    southeastwest  = 0b1110,
    all            = 0b1111
}

struct Tile : Drawable, Transformable {
    RenderTexture texture;
    

    override void draw(RenderTarget target, RenderStates states) {
        Sprite sprite = new Sprite();
        sprite.setTexture(texture.getTexture);
        sprite.origin = origin;
        sprite.position = position;
        sprite.rotation = rotation;
        sprite.scale = scale;
        sprite.draw(target,states);
    }
}

class TileGenerator {
    private enum wallPath = "tiles/walls/"
    enum string[Walls] wallImg = [
        Walls.none:wallPath ~"none.png",
        Walls.north:wallPath~"North.png",
        Walls.east:wallPath~"East.png",
        Walls.northeast:wallPath~"NE.png",
        Walls.south:wallPath~"South.png",
        Walls.northsouth:wallPath~"NS.png",
        Walls.southeast:wallPath~"SE.png",
        Walls.northsoutheast:wallPath~"NSE.png",
        west:wallPath~"West.png",
        northwest:wallPath~"NW.png",
        eastwest:wallPath~"EW.png",
        northeastwest:wallPath~"NEW.png",
        southwest:wallPath~"SW.png",
        northsouthwest:wallPath~"NSW.png",
        southeastwest:wallPath~"SEW.png",
        all:wallPath~"All.png",
    ]

    static this() {
        
    }
    
    static void generate(Walls walls) {
    
    }
}
