module robo_race.grid;

import dsfml.graphics;
import robo_race.tile;

alias Grid = BoardGrid!true;

class BoardGrid(bool preds) : Drawable {
    Tile!preds[][] board;

    this(size_t width = 12, size_t height = 12) {
        board.reserve(width);
        for(size_t x = 0; x < width; x++) { 
            Tile!preds[] row;
            row.reserve(height);
            for(size_t y = 0; y < height; y++) {
                Tile!preds tile = TileGenerator!preds.generate(Tiles.Basic.base);
                tile.position = Vector2f(x*tileSize[0],y*tileSize[1]);
                row ~= tile;
            }
            board ~= row;
        }
    }
    
    override void draw(RenderTarget target, RenderStates states) {
        foreach(row; board) foreach(tile; row) tile.draw(target,states);
    }
}
