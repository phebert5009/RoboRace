module boardbuilder.selection;

import dsfml.graphics;
import robo_race.tile;
//since the tile selection is hardcoded in tiles.d, it will be hard coded here;
class Selection : Drawable {
    enum int xspacing = 5, yspacing = 5;
    TileGroup[] groups;

    struct TileGroup {
        Tile!false[] tiles;
        Vector2!float position;

        this(Tile[] init) {
            foreach(tile;init) {
                
            }
        }
    }

    override void draw(RenderTarget target, RenderStates states) {
        foreach(group;groups) foreach(tile;group.tiles) tile.draw(target,states);
    }
}
