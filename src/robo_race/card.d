module robo_race.card;

import dsfml.graphics;

//private string ratio = "1:3:3:1:3:2:1" // met ceci dans deck.d, comme fonction pour créer un deck

struct Card {
  /*Card Attributes:
	- priority
    - image
    - name
	Card Methods
	- getPriority ()
	- displayImage (x,y)
	- getName ()
  */
  
  
    private uint _priority;
    private string _name;
	private RenderTexture texture;
	
    uint priority() @property {
	    return _priority;
    }
  
    string name()  @property {
	    return _name;
    }
  
    this(uint priority, int factor) {
        _priority = priority;
		setName(factor);
    }
    
    void setName (int factor) {
        factor *= 10;
	    if (priority <= factor) _name = "U-Turn";
	    else if (factor < priority && priority <= factor * 7) {
	        if (priority % 20 == 10) _name = "Left";
	        else _name = "Right";
	    }
	    else if (factor * 7 < priority && priority <= factor * 8) _name = "Back Up";
	    else if (factor * 8 < priority && priority <= factor * 11) _name = "Move 1";
	    else if (factor * 11 < priority && priority <= factor * 13) _name = "Move 2";
	    else if (factor * 13 < priority && priority <= factor * 14) _name = "Move 3";
	    else _name = "unknown"; // if this happens: Error
    }
    
    int opCmp(Card other) {
        if(priority < other.priority) return -1;
        else if(priority > other.priority) return 1;
        else return 0;
    }
}
