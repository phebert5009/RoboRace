module robo_race.tile;

import dsfml.graphics;

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

class Tile : Drawable {
    Vector2f position;
    RenderTexture texture;
    void delegate(MoveInfo) onEnter // called when player moves into the tile
    void delegate(MoveInfo) onExit // called when player moves off the tile
    void delegate(MoveInfo,int) onLand // called when player is on the tile the in parameter is for things such as conveyor priority

    override void draw(RenderTarget target, RenderStates states) {
        Sprite sprite = new Sprite();
        sprite.setTexture(texture.getTexture);
        sprite.position = position;
        sprite.draw(target,states);
    }
}

struct Tiles {
    static:
    private enum string path = "tiles/";
    private mixin template conveyorNorm() {
        enum string downFromLeft = path ~ "DfL.png",
        downFromRight = path ~ "DfR.png",
        leftFromDown = path ~ "LfD.png",
        leftFromUp = path ~ "LfU.png",
        rightFromDown = path ~ "RfD.png",
        rightFromUp = path ~ "RfU.png",
        upFromLeft = path ~ "UfL.png",
        upFromRight = path ~ "UfR.png";
    }
    struct Basic {
        private enum string path = Tiles.path ~ "Basic/";
        enum string base = path ~ "Base.png",
        option = path ~ "OptionTile.png",
        option2 = path ~ "Option2Tile.png";
    }
    struct Conveyor {
        private enum string path = Tiles.path ~ "Conveyor/";
        static struct ThreeWay {
            private enum string path = Conveyor.path ~ "3P/";
            mixin conveyorNorm;
            enum string tDown = path ~ "tD.png",
            tLeft = path ~ "tL.png",
            tRight = path ~ "tR.png",
            tUp = path ~ "tU.png";
        }
        mixin conveyorNorm;
        enum string down = path ~ "D.png",
        left = path ~ "L.png",
        right = path ~ "R.png",
        up = path ~ "U.png";
    }
    struct DoubleConveyor {
        private enum string path = Tiles.path ~ "DConveyor/";
        static struct ThreeWay {
            private enum string path = Conveyor.path ~ "3P/";
            mixin conveyorNorm;
            enum string tDown = path ~ "tD.png",
            tLeft = path ~ "tL.png",
            tRight = path ~ "tR.png",
            tUp = path ~ "tU.png";
        }
        mixin conveyorNorm;
        enum string down = path ~ "D.png",
        left = path ~ "L.png",
        right = path ~ "R.png",
        up = path ~ "U.png";
    }
    struct Gears {
        private enum string path = Tiles.path ~ "Gears/";
        enum string counterClockwise = path ~ "cc.png",
        clockwise = path ~ "c.png";
    }
    struct Holes {
        enum string path = Tiles.path ~ "Holes/";
        // not private for automation
        // the holes are named such that they can be 
        // automatically generated by the grid
        
    }
}

class TileGenerator {
    import std.meta;
    private enum wallPath = "tiles/walls/";
    static Texture[string] textures;
    static RenderTexture[Walls][string] memo;
    
    enum string[Walls] wallImg = [
        Walls.none:wallPath ~"none.png",
        Walls.north:wallPath~"North.png",
        Walls.east:wallPath~"East.png",
        Walls.northeast:wallPath~"NE.png",
        Walls.south:wallPath~"South.png",
        Walls.northsouth:wallPath~"NS.png",
        Walls.southeast:wallPath~"SE.png",
        Walls.northsoutheast:wallPath~"NSE.png",
        Walls.west:wallPath~"West.png",
        Walls.northwest:wallPath~"NW.png",
        Walls.eastwest:wallPath~"EW.png",
        Walls.northeastwest:wallPath~"NEW.png",
        Walls.southwest:wallPath~"SW.png",
        Walls.northsouthwest:wallPath~"NSW.png",
        Walls.southeastwest:wallPath~"SEW.png",
        Walls.all:wallPath~"All.png",
    ];

    static this() {
        
    }
    
    
    static Tile generate(string tileFile,Walls walls = Walls.none) {
        import std.stdio;
        if(tileFile in memo && walls in memo[tileFile]) {
            Tile ans = new Tile();
            ans.texture = memo[tileFile][walls];
            return ans;
        } else {
            auto rTexture = new RenderTexture();
            rTexture.create(40,40);
            Texture tb,tw; // b for background, w for walls
            if(tileFile in textures) tb = textures[tileFile];
            else {
                tb = new Texture();
                if(!tb.loadFromFile(tileFile)) throw new Exception("could not load Texture: " ~ tileFile);
                textures[tileFile] = tb;
            }
            if(walls != walls.none) {
                if(wallImg[walls] in textures) tw = textures[wallImg[walls]];
                else {
                    tw = new Texture();
                    if(!tw.loadFromFile(wallImg[walls])) throw new Exception("could not load Texture: " ~ wallImg[walls]);
                    textures[wallImg[walls]] = tw;
                }
            }
            Sprite sb = new Sprite();
            sb.setTexture(tb);
            rTexture.draw(sb);
            if(walls != walls.none) {
                Sprite sw = new Sprite();
                sw.setTexture(tw);
                rTexture.draw(sw);
            }
            rTexture.display();
            memo[tileFile][walls] = rTexture;
            Tile ans = new Tile();
            ans.texture = rTexture;
            return ans;
        }
    }
}
