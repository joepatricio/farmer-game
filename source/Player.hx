package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxVelocity;

/**
 * ...
 * @author Patricio Jose Najeal
 */
// Class overview: FlxSprite, can be controlled.
class Player extends FlxSprite
{
	public var HEALTH:Int = 3;

	public var speed:Float = 150;

	static inline var DRAG:Float = 1600;

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.player__png, true, 16, 16);

		setFacingFlip(FlxObject.LEFT, false, false); // flip horizontal false, vertical false
		setFacingFlip(FlxObject.RIGHT, true, false); // graphic is already facing left, only flip horizontal if right
		animation.add("h", [4, 3, 5, 3], 6, false); // define animation cycle; horizontal movement
		animation.add("u", [7, 6, 8, 6], 6, false); // up movement
		animation.add("d", [1, 0, 2, 0], 6, false); // down movement

		drag.x = drag.y = DRAG; // player properties; drag is for deceleration of player
		width = 8;
		height = 8; // "hitbox"
		offset.x = 4;
		offset.y = 8; // hitbox offset
	}

	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = FlxG.keys.pressed.UP; // check button press
		down = FlxG.keys.pressed.DOWN;
		left = FlxG.keys.pressed.LEFT;
		right = FlxG.keys.pressed.RIGHT;

		if (up && down) // sanitize inputs (no opposite directions simultaneously)
			up = down = false;
		if (left && right)
			left = right = false;

		if (left || right || up || down) // if movement key is pressed
		{
			var newAngle:Float = 0;

			if (up) // Series of checks to identify velocity angle and facing state
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;

				facing = FlxObject.UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = FlxObject.DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = FlxObject.LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = FlxObject.RIGHT;
			}

			velocity = FlxVelocity.velocityFromAngle(newAngle, speed);

			playAnimation(facing);
		}
	}

	function playAnimation(facing:Int)
	{
		switch (facing) // play animation dependent of object facing state
		{
			case FlxObject.LEFT, FlxObject.RIGHT:
				animation.play("h");
			case FlxObject.UP:
				animation.play("u");
			case FlxObject.DOWN:
				animation.play("d");
		}
	}

	override public function update(elapsed:Float):Void
	{
		updateMovement();
		super.update(elapsed);
	}
}
