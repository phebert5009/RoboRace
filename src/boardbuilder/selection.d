module boardbuilder.selection;

import dsfml.graphics;
import robo_race.tile;
//since the tile selection is hardcoded in tiles.d, it will be hard coded here;
class Selection : Drawable {
    private Tile!false selected;
    package enum Vector2!int spacing = Vector2i(5,5);
    Vector2f topLeft;
    float scroll;
    private TileGroup[] groups;

    bool computed;

    void addGroup(Tile!false[] tiles...) {
        TileGroup tmp;
        tmp.tiles = tiles;
    }

    struct TileGroup {
        Tile!false[] tiles;
    }

    override void draw(RenderTarget target, RenderStates states) {
        Vector2f position = topLeft;
        foreach(group;groups) {
            foreach(tile;group.tiles) {
                if(position.x + tileSize.x < target.getSize.x) {
                    tile.position = position;
                    position.x += tileSize.x + spacing.x;
                } else {
                    position = Vector2f(topLeft.x,position.y + tileSize.y + spacing.y - scroll);
                }
                target.draw(tile,states);
            }
        }
    }
}
