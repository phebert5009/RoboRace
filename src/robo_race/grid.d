module robo_race.grid;

import dsfml.graphics;

class Grid : Drawable {
    Sprite[][] board;
    enum int[2] tileSize = [40,40];
    static Texture blank;
    static this() {
        blank = new Texture();
        if(!blank.loadFromFile("tiles/Basic/Base.png")) throw new Exception("texture unloadable");
    }
    
    this(size_t width = 12, size_t height = 12) {
        board.reserve(width);
        for(size_t x = 0; x < width; x++) {
            Sprite[] row;
            row.reserve(height);
            for(size_t y = 0; y < height; y++) {
                Sprite sp = new Sprite();
                sp.setTexture(blank);
                sp.position(Vector2f(x*tileSize[0],y*tileSize[1]));
                row ~= sp;
            }
            board ~= row;
        }
    }
    
    override void draw(RenderTarget target, RenderStates states) {
        foreach(row; board) foreach(tile; row) tile.draw(target,states);
    }
}
