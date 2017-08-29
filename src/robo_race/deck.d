module robo_race.deck;

struct Deck {
    string[] cards = [
        "left:10",
        "right:20",
    ];
    alias cards this;
    void shuffle() {
        import std.random;
        cards.randomShuffle();
    }
}
