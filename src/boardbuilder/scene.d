module boardbuilder.scene;

import scene;
import dsfml.graphics;
import boardbuilder.board;

class BuilderScene : Scene {
    static BuilderScene instance;

    Board board;

    static this() {
        instance = new BuilderScene();
        manager.manage(instance,"Builder");
    }

    private this() {
    
    }

    bool init() {
        board = new Board();
        return false;
    }

    bool close() {
        return false;
    }

    void handleEvent(Event event) {
    
    }

    void draw(RenderTarget target, RenderStates states) {
        board.draw(target,states);
    }
}
