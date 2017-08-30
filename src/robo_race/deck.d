module robo_race.deck;

import robo_race.card;

//private int factor = 60;
//private int maxCard = 14 * 10 * factor;
//private string ratio = "1:3:3:1:3:2:1"

struct Deck {
    Card[] cards;
	
	this(int factor) {
	    int maxCard = 14 * factor * 10;
	    cards.reserve((14*factor)-1);
	    for(uint i = 10; i <= maxCard; i += 10) cards ~= Card(i, factor);
	    shuffle();
	}
	
    //alias cards this; // pas certain si on a besoin
    void shuffle() {
        import std.random;
        cards.randomShuffle();
    }
    
    string toString() {
        import std.conv;
        string ans = "";
        foreach(card; cards) {
            ans ~= card.to!string;
            ans ~= '\n';
        }
        return ans;
    }
}
