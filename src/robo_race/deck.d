module deck;

struct Deck {
    string[] cards = [
        "left:10",
        "right:20",
    ];
    alias cards this;
    this() {
        import std.random;
        cards.randomShuffle();
    }
}
