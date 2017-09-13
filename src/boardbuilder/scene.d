module boardbuilder.scene;

import scene;
import dsfml.graphics;

class BuilderScene : Scene {
    static BuilderScene instance;
    
    RectangleShape rect = new RectangleShape(Vector2f(50,50));
    
    static this() {
        instance = new BuilderScene();
        manager.manage(instance,"Builder");
    }
    
    private this() {
    
    }
    
    bool init() {
        return false;
    }
    
    bool close() {
        return false;
    }
    
    void handleEvent(Event event) {
    
    }
    
    void draw(RenderTarget target, RenderStates states) {
        rect.fillColor = Color.Black;
        rect.draw(target,states);
    }
}
