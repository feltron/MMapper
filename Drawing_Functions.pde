
// - - - - - - - - - - - - - - - - - - - - - - - 
// DRAWING FUNCTIONS
// - - - - - - - - - - - - - - - - - - - - - - - 

// Add Elements as necessary to Moves hashmap
// elements in hashmap that shouldn't be shown won't be called in display function
// - - - - - - - - - - - - - - - - - - - - - - - 
void makeMoves() {
  for (int i=0; i<movesDates.length; i++) {
    if ( !moves.containsKey(str(movesDates[i])) ) { 
      moves.put( str(movesDates[i]), new Move(str(movesDates[i])) );
    } 
  }
  for (String k : moves.keySet()) {
    moves.get(k).mapPaths();
  }
}

