package;

/**
 * ...
 * @author Patricio Jose Najeal
 */

//Finite-state Machine; used in enemy AI
class FSM 
{
	public var activeState:Float->Void;
	
	public function new(initialState:Float->Void) 
	{
		activeState = initialState;
	}
	
	public function update(elapsed:Float)
	{
		activeState(elapsed);
	}
}