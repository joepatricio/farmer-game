package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author Patricio Jose Najeal
 */
class UpgradeState extends FlxState //TODO: upon level complete, call this state, level++
{
	var background:FlxSprite;
	var PlayButton:FlxButton;
	var titleText:FlxText;
	var level:Int;

	function clickPlay()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new GameState(++level));
		});
	}

	public function new(level:Int)
	{
		super();
		this.level = level;
	}
	
	override public function create()
	{
		background = new FlxSprite(0, 0).loadGraphic(AssetPaths.farm__png, false);
		background.scale.x = 0.5;
		background.scale.y = 0.5;
		background.updateHitbox();
		background.setPosition(3, 0);
		add(background); //It Just WorksTM
		
		titleText = new FlxText(20, 0, 0, "Level Complete", 22);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);
		
		PlayButton = new FlxButton(0, 0, "Play", clickPlay); // define button
		add(PlayButton); // display button
		PlayButton.screenCenter(); // center button

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
