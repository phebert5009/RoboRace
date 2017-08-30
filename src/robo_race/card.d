module robo_race.card;

import dsfml.graphics;

//private int factor = 6
//private int maxCard = 14 * factor;
//private string ratio = "1:3:3:1:3:2:1" // met ceci dans deck.d, comme fonction pour créer un deck

struct Card (int cardNum){
  /*Card Attributes:
	- priority
    - image
    - name
	Card Methods
	- getPriority ()
	- displayImage (x,y)
	- getName ()
	- setName (cardNumber)
  */
  
  
    private uint priority;
    private string name;
    
    uint priority() @property {
	    return _priority;
    }
  
    string name()  @property {
	    return Card.name;
    }
  
    this(string name, uint priority) {
        _name = name;
        _priority = priority;
    }
    
  /* pas besoin
  void setName (int cardNum) { 
	if (cardNum <= factor) Card.name = "U-Turn";
	else if (factor < cardNum && cardNum <= factor * 7) {
	  if (cardNum % 2 = 1) Card.name = "Left";
	  else Card.Name = "Right"
	}
	else if (factor * 7 < cardNum && cardNum <= factor * 8) Card.name = "Back Up"
	else if (factor * 8 < cardNum && cardNum <= factor * 11) Card.name = "Move 1"
	else if (factor * 11 < cardNum && cardNum <= factor * 13) Card.name = "Move 2"
	else if (factor * 13 < cardNum && cardNum <= factor * 14) Card.name = "Move 3" 
  }*/
}
