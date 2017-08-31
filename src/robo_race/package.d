module robo_race;

public import robo_race.grid;
public import robo_race.deck;
public import robo_race.card;
public import robo_race.tile;
public import robo_race.mobile;
public import robo_race.player;
public import robo_race.hand;
public import dsfml.graphics : Font;
private Font defFont;

Font defaultFont() @property{
    if(defFont) {
        return defFont;
    } else {
        defFont = new Font();
        if(!defFont.loadFromFile(".fonts/tuffy.ttf")) throw new Exception("could not load tuffy regular");
        return defFont;
    }
}
