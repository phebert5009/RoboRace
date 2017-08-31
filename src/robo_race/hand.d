module robo_race.hand;

import robo_race;
import robo_race.deck
import std.algorithm : sort;

struct Hand {
    Card[] cards;
	int size = 9
	
	void drawCards () {
		for (i = 0; i < size; i++) {
			cards ~= deck.cards[0]
			
		}
	}
}
