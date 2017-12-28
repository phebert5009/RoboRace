module boardbuilder.loader;

import boardbuilder.selection;
import robo_race.tile;
alias TileGroup = Tile!false[];
struct Loader {
    @disable this();
    // TODO
    /// This will load all the tiles into selection
    static void into(Selection selection) {
    }

    //gets all the simple conveyors
    TileGroup conveyors() @property {
        string path = Tiles.Conveyor.path;
        
    }
}
