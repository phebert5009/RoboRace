module robo_race.hand;

import robo_race.card;
import robo_race.deck;
import robo_race.player;
import std.algorithm : sort;
import dsfml.graphics;

struct Hand {
    Card[] cards;
	int size = 9;
	private int registered = 0;
	
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
	
	void draw(RenderTarget target, RenderStates states) {
	    for(size_t i = 0, r= 0; i + r < cards.length;) {
	        auto card = cards[i+r];
	        if(card.registered >= 0) {
	            card.position = Vector2f(40 * 12 + 95 * card.registered + 5,0);
	            r++;
	        } else {
	            card.position = Vector2f(i*90,40*12);
	            i++;
	        }
	        card.draw(target,states);
	    }
	}
	
	void register(size_t index) {
	    if(cards[index].registered == -1) cards[index].registered = registered++;
	    else {
	        if(registered == 5) return;
	        foreach(card; cards) {
	            if(card.registered > cards[index].registered) card.registered--;
	        }
	        registered--;
	    }
	}
	
	void act(Player player) {
	    for(int i = 0; i < registered;i++)
	        foreach(card; cards)
    	        if(card.registered == i) card.act(player);
	}
	
	void discardAll(Deck deck) {
	    foreach(card; cards) card.registered = -1;
	    cards = cards[0..0];
	    deck.shuffle();
	}
}
