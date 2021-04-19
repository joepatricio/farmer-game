package;

import flixel.FlxGame;
import openfl.display.Sprite;

//Farmer Adventure Version 1.01
class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(320, 240, MenuState));
	}
}
