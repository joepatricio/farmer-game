package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Patricio Jose Najeal
 */
class GameState extends FlxState
{
	var player:Player;
	var enemies:FlxTypedGroup<Enemy>;
	var coins:FlxTypedGroup<Coin>;
	var plants:FlxTypedGroup<Plant>;

	var map:FlxOgmo3Loader; // Ogmo 3 Data
	var walls:FlxTilemap; // Tilemap

	var spawn:Array<FlxPoint>;
	var spawnTimer:FlxTimer;

	var hud:HUD;
	var health:Int = 5;
	var money:Int = 0;
	var plantType:Int = 1;

	var bossTimer:FlxTimer;
	var bossDrain:Int = 0;
	var bossHealth:Int;
	var drain:Int = 1;

	// TODO Music
	var level:Int;
	var ending:Bool; // variables to handle end state

	public function new(level)
	{
		super();
		this.level = level;
	}

	override public function create()
	{
		loadMapData();
		
		super.create();
	}

	public function loadMapData()
	{
		var levelData;
		
		switch (level)
			{
				case 0:
					levelData = AssetPaths.room_001__json;
					bossHealth = 10;
				case 1:
					levelData = AssetPaths.sample_room__json;
					bossHealth = 20;
				case 2:
					levelData = AssetPaths.sample_room2__json;
					bossHealth = 30;
				case 3:
					levelData = AssetPaths.sample_room3__json;
					bossHealth = 40;
				default:
					levelData = AssetPaths.room_001__json;
					bossHealth = 10;
			}

		map = new FlxOgmo3Loader(AssetPaths.turnBasedRPG__ogmo, levelData);
		hud = new HUD(bossHealth);
		walls = map.loadTilemap(AssetPaths.tiles2__png, "walls");
		spawn = walls.getTileCoords(3, false);

		walls.follow(); // edit tilemap properties; lock camera on tile edges
		walls.setTileProperties(1, FlxObject.NONE); // floor tile properties
		walls.setTileProperties(2, FlxObject.ANY); // wall tile properties (collision in ANY direction)
		walls.setTileProperties(3, FlxObject.NONE);
		add(walls);

		player = new Player(); // define player
		coins = new FlxTypedGroup<Coin>();
		enemies = new FlxTypedGroup<Enemy>(); // Declare with a limit size of 11 (10 REGULAR, 1 BOSS)
		plants = new FlxTypedGroup<Plant>();
		map.loadEntities(placeEntities, "entities"); // loop through "entities" with callback to placeEntities

		add(coins);
		add(player); // display player
		add(enemies); // display enemies heheheh
		add(plants);
		add(hud);

		bossTimer = new FlxTimer().start(2, drainBoss, 0); //Execute drainBoss every 2 seconds; 0 argument = no limits to iteration
		spawnTimer = new FlxTimer().start(1, spawnEnemies, 0);
	}
	
	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x + 4, y + 8);
			case "coins":
				coins.add(new Coin(x + 4, y + 4));
			case "enemy":
				enemies.add(new Enemy(x + 4, y + 8, REGULAR));
			case "boss":
				enemies.add(new Enemy(x + 4, y + 8, BOSS));
			case "plant":
				plants.add(new Plant(x, y, 3));
		}
	}

	function collectCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.onPickup();
			money++;
			hud.updateMoney(money);
		}
	}

	function checkEnemyVision(enemy:Enemy)
	{
		if (walls.ray(enemy.getMidpoint(), player.getMidpoint())) // Returns true if ray does not overlap with wall
		{
			enemy.playerLocation = player.getMidpoint();
			enemy.seesPlayer = true;
		}
		else // Returns false and stores the point of intersection
		{
			enemy.seesPlayer = false;
		}
	}

	function plant(pLocation:FlxPoint, type:Int) // responsible for adding new plants
	{
		if (money > 0 && !(FlxG.overlap(player, plants))) //Do not plant if player is overlapped with plant (avoid "dual layered" planting), 
		{ //or if player has no money
			money--; // Subtract money
			hud.updateMoney(money);
			if (type == 1)
			{
				bossDrain += drain;
			}
			plants.add(new Plant(pLocation.x - 8, pLocation.y - 12, type));
		}
		else
		{
			hud.warnMoney();
		}
	}

	function plantFX(enemy:Enemy, plant:Plant) // Handle enemy/plant contact logic
	{
		if (plant.alive) 
		{
			switch (plant.type)
			{
				case 1:
					if (!plant.isFlickering())
					{
						damagePlant(plant, 2);
					}
				case 2:
					if (enemy.type != BOSS)
					{
						FlxObject.separate(enemy, plant);
						if (!plant.isFlickering())
						{
							damagePlant(plant, 1);
						}
					}
				case 3:
					if (!enemy.isFlickering() && (enemy.type != BOSS) && enemy.alive)
					{ // If flickering, not alive, and BOSS type, do nothing, otherwise...
						enemy.health--; // Subtract enemy health

						if (enemy.health <= 0) // Kill the enemy once health reaches 0, also drop coin
						{
							enemy.onKill();
							coins.add(new Coin((enemy.x - 4), (enemy.y - 4)));
						}
						else // proceed with game if enemy health is above 0
						{
							enemy.flicker(.5);
						}
					}
			}
		}
	}

	function damagePlant(plant:Plant, iframe:Int)
	{
		plant.health--;
		if (plant.health <= 0)
		{
			plant.onKill();
			if (plant.type == 1) {
				bossDrain -= drain;
			}
		}
		else
		{
			plant.flicker(iframe); // Flicker duration depends of argument
			plant.alpha -= 0.15; // Reduce alpha value to indicate damage;
		}
	}

	function playerControls() // Player controls
	{
		if (FlxG.keys.justPressed.A)
		{
			plantType = 1;
			hud.updatePlant(plantType);
		}
		if (FlxG.keys.justPressed.S)
		{
			plantType = 2;
			hud.updatePlant(plantType);
		}
		if (FlxG.keys.justPressed.D)
		{
			plantType = 3;
			hud.updatePlant(plantType);
		}
		if (FlxG.keys.anyJustPressed([SHIFT, SPACE]))
		{
			plant(player.getMidpoint(), plantType);
		}
	}

	function checkOverlap()
	{
		FlxG.collide(player, walls); // equivalent to FlxG.overlap(player, walls, FlxG.separate) with logic to separate objects
		FlxG.collide(enemies, walls); // Checks collision between walls and all entities of enemies:FlxTypedGroup<Enemy>
		FlxG.overlap(player, coins, collectCoin); // Check player overlap with all entities of coins:FlxTypedGroup<Coin>

		FlxG.overlap(enemies, plants, plantFX);
	}

	function drainBoss(timer:FlxTimer):Void // functions and variables relating to boss health drain behavior
	{
		if (bossDrain != 0) 
		{
			bossHealth -= bossDrain;
			hud.updateBoss(bossHealth);
			if (bossHealth <= 0)
			{
				ending = true;
				FlxG.timeScale = 0.1;
				if (level == 3) 
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.1, false, winGame);
				}
				else 
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.1, false, levelComplete);
				}
			}	
		}
	}

	function spawnEnemies(timer:FlxTimer) // Can be optimized with recycling
	{
		if (!(enemies.countLiving() >= 11) && FlxG.random.bool(25)) // If 11 enemies are alive, skip
		{
			var point = spawn[FlxG.random.int(0, spawn.length - 1)];
			enemies.add(new Enemy(point.x, point.y, REGULAR));
		}
	}
	
	function loseGame()
	{
		FlxG.timeScale = 1;
		FlxG.switchState(new GameOverState(false, money));
	}

	function winGame()
	{
		FlxG.timeScale = 1;
		FlxG.switchState(new GameOverState(true, money));
	}

	function levelComplete()
	{
		FlxG.timeScale = 1;
		FlxG.switchState(new UpgradeState(level));
	}

	override public function update(elapsed:Float) // executes every game cycle (60 frames per second)
	{
		super.update(elapsed);

		enemies.forEachAlive(checkEnemyVision); // All alive enemies call CheckEnemyVision() function
		FlxG.camera.follow(player, TOPDOWN, 1);

		checkOverlap();

		playerControls(); // Player controls

		if (FlxG.overlap(player, enemies)) // Logic relating to player contact to enemy
		{
			if (!player.isFlickering() && !ending)
			{ // If flickering, or game is ending, do nothing, otherwise...
				health--; // Subtract player health

				if (health <= 0) // End the game if player health reaches 0
				{
					hud.updateHealth(health);
					FlxG.timeScale = 0.1;
					ending = true;
					FlxG.camera.fade(FlxColor.BLACK, 0.1, false, loseGame);
				}
				else // proceed with game if player health is above 0
				{
					player.flicker(2);
					hud.updateHealth(health); // also calls to update hud
				}
			}
		}
	}
}
