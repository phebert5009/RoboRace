import dsfml.graphics;
import robo_race;
import std.stdio;
immutable Color ItemBlank = Color(27,130,95);

int main(string[] args) {
    auto window = new RenderWindow(VideoMode(40*12+5*7+90*5,40*12+120),"RoboRace");
    window.setFramerateLimit(30);
    Grid grid = new Grid();
    Clock clock = new Clock();
    while(window.isOpen) {
        Event event;
        while(window.pollEvent(event)) {
            if(event.type == Event.EventType.Closed) {
                window.close();
            }
        }
        window.clear(Color(67,175,125));
        window.draw(grid);
        window.display();
        write("\r",clock.restart,"            ");
    }
    writeln();
    return 0;
}
