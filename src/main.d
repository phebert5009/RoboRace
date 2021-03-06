import dsfml.graphics;
import std.stdio;
import scene;
import menuscene;
import robo_race.tile : tileSize;
//immutable Color ItemBlank = Color(27,130,95);

int main(string[] args) {
    auto window = new RenderWindow(VideoMode(tileSize.x*12+5*7+90*5,tileSize.x*12+120),"RoboRace");

    Image icon = new Image();
    icon.loadFromFile("objects/Player1.png");
    window.setIcon(24,30,icon.getPixelArray);

    window.setFramerateLimit(30);

    debug {
        Clock clock = new Clock();
    }

    manager = new SceneManager(MenuScene.instance);

    while(window.isOpen) {
        Event event;
        while(window.pollEvent(event)) {
            manager.handleEvent(event);
            if(event.type == Event.EventType.Closed) {
                window.close();
            }
        }

        window.clear(Color(67,175,125));
        window.draw(manager);
        window.display();
        debug {
            write("\r",dur!"seconds"(1)/clock.restart," "); // display frame time
            stdout.flush();
        }
    }
    writeln();
    return 0;
}
