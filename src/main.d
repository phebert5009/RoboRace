import dsfml.graphics;
import std.stdio;
import scene;
import mainscene;
//immutable Color ItemBlank = Color(27,130,95);

int main(string[] args) {
	auto window = new RenderWindow(VideoMode(40*12+5*7+90*5,40*12+120),"RoboRace");
	window.setFramerateLimit(30);
	
	Clock clock = new Clock();
	
	SceneManager manager = new SceneManager(MainScene.instance);
	MainScene.instance.manager = manager;
	
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
		
		write("\r",dur!"seconds"(1)/clock.restart," "); // display frame time
		stdout.flush();
	}
	writeln();
	return 0;
}

