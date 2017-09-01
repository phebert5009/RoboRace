module robo_race.hand;

import robo_race;
import std.algorithm : sort;
import dsfml.graphics;

struct Hand {
    Card[] cards;
	int size = 9;
	struct Register {
        Card[] registered;
        
        // this might be a little problematic
    }
	void drawCards (Deck deck) {
		for (uint i = 0; i < size; i++) {
			cards ~= deck.front;
			deck.popFront();
		}
		cards.sort();
	}
	
	Card opIndex(size_t index1) {
	    return cards[index1];
	}
	
	void drawOn(RenderWindow window) {
	    for(size_t i = 0; i < cards.length; i++) {
	        auto card = cards[i];
	        card.position = Vector2f(i*90,40*12);
	        window.draw(card);
	    }
	}
	
	void discardAll(Deck deck) {
	    cards = new Card[];
	}
}
