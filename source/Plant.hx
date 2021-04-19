package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Patricio Jose Najeal
 */
class Plant extends FlxSprite
{
	public var type:Int = 1;

	var tween:FlxTween;

	public function new(?X:Float = 0, ?Y:Float = 0, type:Int)
	{
		super(X, Y);
		this.type = type;

		super.immovable = true;
		var graphic;

		switch (type)
		{
			case 1:
				graphic = AssetPaths.sapling__png;
				health = 2;
			case 2:
				graphic = AssetPaths.palm__png;
				health = 5;
			case 3:
				graphic = AssetPaths.grass__png;
			default:
				graphic = AssetPaths.sapling__png;
		}

		loadGraphic(graphic, false, 16, 16);
	}

	public function onKill()
	{
		alive = false;
		tween = FlxTween.tween(this, {alpha: 0}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill});
	}

	function finishKill(_)
	{
		exists = false;
	}
}
