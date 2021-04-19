package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Patricio Jose Najeal
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	
	var healthCounter:FlxText;
	var moneyCounter:FlxText;
	var bossCounter:FlxText;
	var moneyTween:FlxTween;
	
	var healthIcon:FlxSprite;
	var bossIcon:FlxSprite;
	var plantIcon:FlxSprite;
	var moneyIcon:FlxSprite;
	var plant:Int = 1;
	
	var bossMax: Int;
	
	public function new(boss:Int)
	{
		super();
		this.bossMax = boss;
		
		background = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
		background.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);

		healthIcon = new FlxSprite(4, 5, AssetPaths.health__png);
		bossIcon = new FlxSprite((FlxG.width*0.33), 5, AssetPaths.bosshealth__png);
		plantIcon = new FlxSprite((FlxG.width - 20), 2, AssetPaths.sapling__png);
		moneyIcon = new FlxSprite((FlxG.width*0.66), 5, AssetPaths.coin__png);
		
		healthCounter = new FlxText(16, 2, 0, "5 / 5", 8);
		healthCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		bossCounter = new FlxText(bossIcon.x + 12, 2, 0, boss + " / " + boss, 8);
		bossCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		moneyCounter = new FlxText(moneyIcon.x + 8, 2, 0, "0", 8);
		moneyCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		
		add(background);
		add(healthIcon);
		add(bossIcon);
		add(moneyIcon);
		add(plantIcon);
		
		add(healthCounter);
		add(moneyCounter);
		add(bossCounter);

		forEach(function(sprite)
		{
			sprite.scrollFactor.set(0, 0);
		});
	}

	public function updateMoney(money:Int)
	{
		moneyCounter.text = Std.string(money);
	}
	
	public function updateHealth(health:Int)
	{
		healthCounter.text = health + " / 5";
	}
	
	public function updateBoss(boss:Int)
	{
		bossCounter.text = boss + " / " + bossMax;
	}
	
	public function updatePlant(type:Int) //TODO
	{
		if (plant != type) 
		{
			plant = type;
			var graphic = AssetPaths.sapling__png;
			switch (type) 
			{
				case 1:
					graphic = AssetPaths.sapling__png;
				case 2:
					graphic = AssetPaths.palm__png;
				case 3:
					graphic = AssetPaths.grass__png;
			}
			plantIcon.loadGraphic(graphic, false, 16, 16);
		}
	}
	
	public function warnMoney()
	{
		moneyCounter.color = FlxColor.RED;
		moneyTween = FlxTween.tween(moneyCounter, {"color":FlxColor.WHITE}, 0.3);
	}
}