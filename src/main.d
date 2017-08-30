import dsfml.graphics;
import robo_race;
import std.stdio;
immutable Color ItemBlank = Color(27,130,95);

int main(string[] args) {
    auto window = new RenderWindow(VideoMode(40*12+5*7+90*5,40*12+120),"RoboRace");
    window.setFramerateLimit(30);
    Grid grid = new Grid();
    Clock clock = new Clock();
    Player player = new Player("objects/Player1.png");
    player.turnLeft();
    player.move();
    Deck deck = Deck(6);
    deck.shuffle();
    writeln(deck);
    while(window.isOpen) {
        Event event;
        while(window.pollEvent(event)) {
            if(event.type == Event.EventType.Closed) {
                window.close();
            }
        }
        window.clear(Color(67,175,125));
        window.draw(grid);
        window.draw(player);
        window.display();
        write("\r",clock.restart,"            "); // display frame time
    }
    writeln();
    return 0;
}
