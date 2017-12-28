module robo_race.grid;

import dsfml.graphics;
import robo_race.tile;



alias Grid = TileGrid!true;

class TileGrid(bool preds) : Drawable {
    Tile!preds[][] board;
    Vector2!size_t size;
    
    this(Vector2!size_t size = Vector2!size_t(12,12)) {
        this.size = size;
        board.reserve(size.x);
        for(size_t x = 0; x < size.x; x++) { 
            Tile!preds[] row;
            row.reserve(size.y);
            for(size_t y = 0; y < size.y; y++) {
                Tile!preds tile = TileGenerator!preds.generate(Tiles.Basic.base);
                tile.position = Vector2f(x*tileSize.x,y*tileSize.y);
                row ~= tile;
            }
            board ~= row;
        }
    }

    override void draw(RenderTarget target, RenderStates states) {
        foreach(row; board) foreach(tile; row) tile.draw(target,states);
    }
}
