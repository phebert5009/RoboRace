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
	player.move(3);
	player.turnLeft();
	player.move(2);
	player.turnRight();
	player.move(1);
	player.uTurn();
	player.move(-1);
	Deck deck = Deck(7); 
	Hand hand;
	hand.drawCards(deck);
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
		hand.drawOn(window);
		window.display();
		write("\r",clock.restart,"            "); // display frame time
	}
	writeln();
	return 0;
}
