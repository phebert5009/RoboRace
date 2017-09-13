module menuscene;

import scene;
import gui.button;
import dsfml.graphics;

class MenuScene : Scene {
    Button playbtn, boardBuilderBtn;

    static MenuScene instance;

    static this() {
        instance = new MenuScene();
        manager.manage(instance,"Menu");
    }

    this() {
        playbtn = new Button(120,50);
        playbtn.position = Vector2f(120,50);
        playbtn.text = "play";
        playbtn.characterSize = 19;
        boardBuilderBtn = new Button(120,50);
        boardBuilderBtn.position = Vector2f(120,150);
        boardBuilderBtn.text = "board builder";
        boardBuilderBtn.characterSize = 19;
    }

    override bool init() {
        return true;
    }

    override bool close() {
        return true;
    }

    override void draw(RenderTarget target, RenderStates states) {
        playbtn.draw(target,states);
        boardBuilderBtn.draw(target,states);
    }

    override void handleEvent(Event event) {
        if(event.type == Event.EventType.MouseButtonReleased) {
            if(event.mouseButton.button == Mouse.Button.Left) {
                if(playbtn.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    manager.changeScene("Main");
                }
                if(boardBuilderBtn.clicked(event.mouseButton.x,event.mouseButton.y)) {
                    manager.changeScene("Builder");
                }
            }
        }
    }
}
