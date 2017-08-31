module robo_race.hand;

import robo_race;
import std.algorithm : sort;

struct Hand {
    Card[] cards;
	int size = 9;
	
	void drawCards (Deck deck) {
		for (uint i = 0; i < size; i++) {
			cards ~= deck.front;
			deck.popFront();
		}
		cards.sort();
	}
}
