package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Patricio Jose Najeal
 */
enum EnemyType
{
	REGULAR;
	BOSS;
}

// Class overview: Like Player class, but cannnot be controlled, and updateFacing based on velocity (Player based on input), among other differences
class Enemy extends FlxSprite
{
	var speed:Float = 150;
	var speed_roam:Float;
	var speed_chase:Float;

	static inline var DRAG = 160;

	var ai:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	public var type:EnemyType;
	public var seesPlayer:Bool;
	public var playerLocation:FlxPoint;

	var dying = false;

	public function new(?X:Float = 0, ?Y:Float = 0, type:EnemyType)
	{
		super(X, Y);
		this.type = type;

		switchType(type);

		speed_chase = speed * 0.7;
		speed_roam = speed * 0.5;

		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		animation.add("d", [0, 1, 0, 2], 6, false);
		animation.add("h", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);

		drag.x = drag.y = DRAG; // define enemy drag
		width = 8;
		height = 8;
		offset.x = 4;
		offset.y = 8;

		ai = new FSM(idle);
		idleTimer = 0;
		playerLocation = FlxPoint.get();
	}

	function idle(elapsed:Float)
	{
		if (seesPlayer)
		{
			ai.activeState = chase;
		}
		else if (idleTimer <= 0)
		{
			moveDirection = FlxG.random.int(0, 8) * 45;
			velocity = FlxVelocity.velocityFromAngle(moveDirection, speed_roam); // define roam speed
			idleTimer = FlxG.random.int(1, 4);
		}
		else
		{
			idleTimer -= elapsed;
		}
	}

	function chase(elapsed:Float)
	{
		if (!seesPlayer)
		{
			ai.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerLocation, Std.int(speed_chase)); // define chase speed
		}
	}

	function updateFacing()
	{
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
		{
			if (Math.abs(velocity.x) > Math.abs(velocity.y))
			{
				if (velocity.x < 0)
					facing = FlxObject.LEFT;
				else
					facing = FlxObject.RIGHT;
			}
			else
			{
				if (velocity.y < 0)
					facing = FlxObject.UP;
				else
					facing = FlxObject.DOWN;
			}
		}

		playAnimation(facing);
	}

	function playAnimation(facing:Int)
	{
		switch (facing)
		{
			case FlxObject.LEFT, FlxObject.RIGHT:
				animation.play("h");
			case FlxObject.UP:
				animation.play("u");
			case FlxObject.DOWN:
				animation.play("d");
		}
	}

	public function onKill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill});
	}

	function finishKill(_) // '_' in parameter means to ignore/no parameters
	{
		exists = false;
	}

	public function changeType(type:EnemyType) 
	{
		if (this.type != type)
		{
			this.type = type;
			
			switchType(type);
		}
	}

	function switchType(type:EnemyType)
	{
		var graphic;
		
		switch (type)
		{
			case REGULAR:
				health = 3;
				graphic = AssetPaths.enemy__png;
				speed = 125;
			case BOSS:
				graphic = AssetPaths.boss__png;
				speed = 100;
			default:
				health = 3;
				graphic = AssetPaths.enemy__png;
				speed = 125;
		}
		
		loadGraphic(graphic, true, 16, 16);
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (alive)
		{
			ai.update(elapsed);
			updateFacing();
		}
	}
}
