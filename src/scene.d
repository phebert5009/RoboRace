module scene;

import dsfml.graphics;
/**
 * Construct representing an in-game scene.
 * It is recommended that every scene has a referende to the manager
 */
interface Scene : Drawable {
    /**
     * Do when the scene is opened.
     * Returns: true if initialization was successful
     */
    bool init();
    /// Do when the scene is closed
    bool close();
    /// allows for handling events
    void handleEvent(Event event);
}

class SceneManager : Drawable {
    private Scene currScene;
    
    this(Scene initialScene) {
        currScene = initialScene;
        currScene.init();
    }
    
    bool changeScene(Scene scene) {
        if(scene == currScene) return false;
        currScene.close();
        currScene = scene;
        return currScene.init();
    }
    
    void handleEvent(Event event) {
        if(event.type == Event.EventType.Closed) {
            currScene.close();
        }
        currScene.handleEvent(event);
    }
    
    void draw(RenderTarget target, RenderStates states) {
        currScene.draw(target,states);
    }
}
