# elm-learnItGood

You know what to do --> elm make src/Main.elm

I might as well start off with something really simple and just make an user input in the view and have the runtime give it to my update function which updates the empty model with the string from the union Msg type variants' associated data.  The init function of the program just puts an empty string in the model and no commands for the runtime.  The neat thing happens when the view pattern matches an implicit Maybe from the attempted conversion to Int from the model containing the input data.  I am going to simply reverse the string and capitalize it if not converted.  I will simply mult the Int by 42. 
	
	Now I am going to refactor the code to accept Commands to the runtime via tuple with the model.  Also local storage is neat so I added a button and will set up a port to Javascript to save a value.