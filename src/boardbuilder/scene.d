module boardbuilder.scene;

import scene;
import dsfml.graphics;
import boardbuilder.board;
import boardbuilder.selection;
import robo_race.tile : tileSize;
import defaults;

class BuilderScene : Scene {
    static BuilderScene instance;

    Selection selection;
    Board board;

    static this() {
        instance = new BuilderScene();
        manager.manage(instance,"Builder");
    }

    private this() {
        
    }

    bool init() {
        board = new Board();
        selection = new Selection;
        selection.topLeft = mult(xproj,mult(tileSize,board.size)) + selection.spacing;
        debug {
            import std.stdio;
            writeln("Selection's position: ", selection.topLeft);
        }
        return true;
    }

    bool close() {
        return false;
    }

    void handleEvent(Event event) {
    
    }

    void draw(RenderTarget target, RenderStates states) {
        board.draw(target,states);
        selection.draw(target,states);
        
    }
}
