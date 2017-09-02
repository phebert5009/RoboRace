module gui.button;

import dsfml.graphics;
import defaults;

class Button : Drawable {
    private RenderTexture texture;
    private Sprite sprite;
    Vector2f position;
    private uint width,height;
    private string btnText;
    private uint charSize = 12;
    private Color backgroundColor = Color.White, foregroundColor = Color.Black;
    
    Color BGC() @property {
        return backgroundColor;
    }
    
    Color BGC(Color newCol) @property {
        backgroundColor = newCol;
        refresh();
        return backgroundColor;
    }
    
    Color FGC() @property {
        return foregroundColor;
    }
    
    Color FGC(Color newCol) @property {
        foregroundColor = newCol;
        refresh();
        return foregroundColor;
    }
    
    uint CharacterSize() @property {
        return charSize;
    }
    
    uint CharacterSize(uint newSize) @property {
        charSize = newSize;
        refresh();
        return charSize;
    }
    
    string text() @property {
        return btnText;
    }
    
    string text(string newText) @property {
        btnText = newText;
        refresh();
        return btnText;
    }
    
    this(uint width, uint height) {
        texture = new RenderTexture();
        texture.create(width,height);
        sprite = new Sprite();
        this.width = width;
        this.height = height;
        refresh();
    }
    
    void refresh() {
        texture.clear(backgroundColor);
        Text txt = new Text();
        txt.setFont = defaultFont;
        txt.setString = text;
        txt.setCharacterSize = charSize;
        txt.setColor = foregroundColor;
        txt.origin = Vector2f(txt.getLocalBounds.width/2,txt.getLocalBounds.height/2);
        txt.position = Vector2f(width/2,height/2);
        texture.draw(txt);
        texture.display();
        sprite.setTexture = texture.getTexture;
    }

    void draw(RenderTarget target, RenderStates states) {
        sprite.position = position;
        sprite.draw(target,states);
    }
    
    bool clicked(int x,int y) {
        if(position.x < x && x < position.x+width) {
            if(position.y < x && y < position.x+width) {
                return true;
            }
        }
        return false;
    }
}
