module defaults;

import dsfml.graphics : Font, Vector2, Vector2f;

private Font defFont;
enum Vector2f xproj = Vector2f(1,0), yproj = Vector2f(0,1);
unittest {
    Vector2f tmp = Vector2f(5,5);
    assert(tmp.mult(xproj) == Vector2f(5,0));
    assert(tmp.mult(yproj) == Vector2f(0,5));
}

Vector2!T1 mult(T1, T2)(Vector2!T1 v1, Vector2!T2 v2) {
    return Vector2!T1(v1.x*cast(T1)v2.x,v1.y*cast(T1)v2.y);
}

Font defaultFont() @property{
    if(defFont) {
        return defFont;
    } else {
        defFont = new Font();
        if(!defFont.loadFromFile(".fonts/Tuffy.ttf")) throw new Exception("could not load tuffy regular");
        return defFont;
    }
}
