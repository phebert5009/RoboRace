module robo_race.hand;

import robo_race.card;
import robo_race.deck;
import robo_race.player;
import std.algorithm : sort;
import dsfml.graphics;

struct Hand {
    Card[] cards;
    int size = 9;
    private bool used = false;
    private int registered = 0;

    private bool wasUsed() @property {
        return used;
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
        if(cards[index].registered == -1) {
            if(registered == 5) return;
            cards[index].registered = registered++;
        } else {
            foreach(card; cards) {
                if(card.registered > cards[index].registered) card.registered--;
            }
            cards[index].registered = -1;
            registered--;
        }
    }

    void register(int x, int y) {
        if(y > 40*12) {
            if(x < (size-registered)*90) {
                int regNum = x / 90;
                int i = -1, r = 0;
                while(i < regNum) {
                    if(cards[i+r+1].registered != -1) {
                        r++;
                    } else {
                        i++;
                    }
                }
                import std.stdio;
                writeln("register ",cards[i+r]);
                register(i+r);
            }
        }
    }

    void act(Player player) {
        if(used || registered != 5) return;
        for(int i = 0; i < registered;i++)
            foreach(card; cards)
                if(card.registered == i) card.act(player);
        used = true;
    }

    void discardAll(Deck deck) {
        foreach(card; cards) card.registered = -1;
        registered = 0;
        cards = cards[0..0];
        deck.shuffle();
        used = false;
    }
}
