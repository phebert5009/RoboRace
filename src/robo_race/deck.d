module robo_race.deck;

//private int factor = 60;
//private int maxCard = 14 * 10 * factor;
//private string ratio = "1:3:3:1:3:2:1"

struct Deck {
    Card[] cards;
	
	this(int factor = 6) {
	  int maxCard = 14 * factor * 10
	  for(i = 10; i <= maxCard; i += 10) cards ~= Card(i, factor);
	}
	
    //alias cards this; // pas certain si on a besoin
    void shuffle() {
        import std.random;
        cards.randomShuffle();
    }
}
