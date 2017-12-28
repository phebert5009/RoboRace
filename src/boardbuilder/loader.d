module boardbuilder.loader;

debug import std.stdio;

import boardbuilder.selection;
import robo_race.tile;
alias TileGroup = Tile!false[];
struct Loader {
    @disable this();
    // TODO
    /// This will load all the tiles into selection
    static void into(Selection selection) {
        import std.file;
        import std.container;
        auto entries = dirEntries("tiles",SpanMode.shallow);
        DList!DirEntry stack = DList!DirEntry(entries);
        while(!stack.empty) {
            auto entry = stack.front;
            stack.removeFront;
            if(entry.isDir) {
                stack.insertBack(dirEntries(entry.name,SpanMode.shallow));
            } else {
                stderr.writeln(entry.name);
                TileGenerator!false.generate(entry.name);
            }
        }
    }
    unittest {
        Selection selection = new Selection;
        Loader.into(selection);
    }
}
