module robo_race.deck;

import robo_race.card;

//private int factor = 60;
//private int maxCard = 14 * 10 * factor;
//private string ratio = "1:3:3:1:3:2:1"

struct Deck {
    private Card[] cards;
	private size_t index = 0;
	this(int factor) {
	    int maxCard = 14 * factor * 10;
	    cards.reserve((14*factor)-1);
	    for(uint i = 10; i <= maxCard; i += 10) cards ~= new Card(i, factor);
	    shuffle();
	}
	
    void shuffle() {
        import std.random;
        cards.randomShuffle();
        index = 0;
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

    Card front() @property {
        if(!empty) return cards[index];
        else return Card.init; //Card(0,"")
    }
    
    void popFront() {
        if(!empty) index++;
    }
    
    bool empty() @property {
        return cards.length <= index;
    }
    
    Deck save() @property { // allows safe foreach loop iteration
        Deck ans;
        ans.cards = cards.dup;
        return ans;
    }
}
