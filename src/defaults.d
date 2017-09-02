
import dsfml.graphics : Font;

private Font defFont;

Font defaultFont() @property{
    if(defFont) {
        return defFont;
    } else {
        defFont = new Font();
        if(!defFont.loadFromFile(".fonts/Tuffy.ttf")) throw new Exception("could not load tuffy regular");
        return defFont;
    }
}
