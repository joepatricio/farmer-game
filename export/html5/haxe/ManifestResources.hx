package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR0y29:assets%2Fdata%2Froom-001.jsonR2i6137R3R4R5R7R6tgoR0y32:assets%2Fdata%2Fsample-room.jsonR2i5896R3R4R5R8R6tgoR0y33:assets%2Fdata%2Fsample-room2.jsonR2i6275R3R4R5R9R6tgoR0y33:assets%2Fdata%2Fsample-room3.jsonR2i6001R3R4R5R10R6tgoR0y33:assets%2Fdata%2FturnBasedRPG.ogmoR2i13410R3R4R5R11R6tgoR0y26:assets%2Fimages%2Fboss.pngR2i2558R3y5:IMAGER5R12R6tgoR0y32:assets%2Fimages%2Fbosshealth.pngR2i6021R3R13R5R14R6tgoR0y26:assets%2Fimages%2Fcoin.pngR2i984R3R13R5R15R6tgoR0y27:assets%2Fimages%2Fenemy.pngR2i2405R3R13R5R16R6tgoR0y26:assets%2Fimages%2Ffarm.jpgR2i428391R3R13R5R17R6tgoR0y26:assets%2Fimages%2Ffarm.pngR2i1218713R3R13R5R18R6tgoR0y27:assets%2Fimages%2Fgrass.pngR2i1603R3R13R5R19R6tgoR0y28:assets%2Fimages%2Fhealth.pngR2i984R3R13R5R20R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R21R6tgoR0y34:assets%2Fimages%2Flikert_scale.pdfR2i432385R3R4R5R22R6tgoR0y26:assets%2Fimages%2Fpalm.pngR2i1603R3R13R5R23R6tgoR0y28:assets%2Fimages%2Fplayer.pngR2i1876R3R13R5R24R6tgoR0y29:assets%2Fimages%2Fpointer.pngR2i992R3R13R5R25R6tgoR0y29:assets%2Fimages%2Fsapling.pngR2i2920R3R13R5R26R6tgoR0y27:assets%2Fimages%2Ftiles.pngR2i1056R3R13R5R27R6tgoR0y28:assets%2Fimages%2Ftiles2.pngR2i4692R3R13R5R28R6tgoR2i1011928R3y5:SOUNDR5y26:assets%2Fmusic%2Falert.wavy9:pathGroupaR30hR6tgoR2i1418028R3R29R5y27:assets%2Fmusic%2Falert2.wavR31aR32hR6tgoR2i23978R3R29R5y25:assets%2Fmusic%2Fcoin.wavR31aR33hR6tgoR2i39300R3R29R5y27:assets%2Fmusic%2Fcombat.wavR31aR34hR6tgoR2i34298R3R29R5y25:assets%2Fmusic%2Ffled.wavR31aR35hR6tgoR2i20012R3R29R5y25:assets%2Fmusic%2Fhurt.wavR31aR36hR6tgoR2i33516R3R29R5y25:assets%2Fmusic%2Flose.wavR31aR37hR6tgoR2i24158R3R29R5y25:assets%2Fmusic%2Fmiss.wavR31aR38hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R39R6tgoR2i10518R3R29R5y27:assets%2Fmusic%2Fselect.wavR31aR40hR6tgoR2i10188R3R29R5y25:assets%2Fmusic%2Fstep.wavR31aR41hR6tgoR2i54320R3R29R5y24:assets%2Fmusic%2Fwin.wavR31aR42hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R43R6tgoR0y32:assets%2Fxml%2FGameOverState.xmlR2zR3R4R5R44R6tgoR0y28:assets%2Fxml%2FMenuState.xmlR2zR3R4R5R45R6tgoR0y31:assets%2Fxml%2FUpgradeState.xmlR2zR3R4R5R46R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R31aR48y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R47R5y28:flixel%2Fsounds%2Fflixel.mp3R31aR50y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R29R5R49R31aR48R49hgoR2i33629R3R29R5R51R31aR50R51hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R52R53y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R13R5R58R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R13R5R59R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_001_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_sample_room_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_sample_room2_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_sample_room3_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_turnbasedrpg_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boss_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bosshealth_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_enemy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_farm_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_farm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_grass_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_health_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_likert_scale_pdf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_palm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sapling_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_alert_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_alert2_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_coin_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_combat_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_fled_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_hurt_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_lose_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_miss_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_select_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_step_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_win_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_xml_gameoverstate_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_xml_menustate_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_xml_upgradestate_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/room-001.json") @:noCompletion #if display private #end class __ASSET__assets_data_room_001_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/sample-room.json") @:noCompletion #if display private #end class __ASSET__assets_data_sample_room_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/sample-room2.json") @:noCompletion #if display private #end class __ASSET__assets_data_sample_room2_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/sample-room3.json") @:noCompletion #if display private #end class __ASSET__assets_data_sample_room3_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/turnBasedRPG.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_turnbasedrpg_ogmo extends haxe.io.Bytes {}
@:keep @:image("assets/images/boss.png") @:noCompletion #if display private #end class __ASSET__assets_images_boss_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bosshealth.png") @:noCompletion #if display private #end class __ASSET__assets_images_bosshealth_png extends lime.graphics.Image {}
@:keep @:image("assets/images/coin.png") @:noCompletion #if display private #end class __ASSET__assets_images_coin_png extends lime.graphics.Image {}
@:keep @:image("assets/images/enemy.png") @:noCompletion #if display private #end class __ASSET__assets_images_enemy_png extends lime.graphics.Image {}
@:keep @:image("assets/images/farm.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_farm_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/farm.png") @:noCompletion #if display private #end class __ASSET__assets_images_farm_png extends lime.graphics.Image {}
@:keep @:image("assets/images/grass.png") @:noCompletion #if display private #end class __ASSET__assets_images_grass_png extends lime.graphics.Image {}
@:keep @:image("assets/images/health.png") @:noCompletion #if display private #end class __ASSET__assets_images_health_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/images/likert_scale.pdf") @:noCompletion #if display private #end class __ASSET__assets_images_likert_scale_pdf extends haxe.io.Bytes {}
@:keep @:image("assets/images/palm.png") @:noCompletion #if display private #end class __ASSET__assets_images_palm_png extends lime.graphics.Image {}
@:keep @:image("assets/images/player.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pointer.png") @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sapling.png") @:noCompletion #if display private #end class __ASSET__assets_images_sapling_png extends lime.graphics.Image {}
@:keep @:image("assets/images/tiles.png") @:noCompletion #if display private #end class __ASSET__assets_images_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/tiles2.png") @:noCompletion #if display private #end class __ASSET__assets_images_tiles2_png extends lime.graphics.Image {}
@:keep @:file("assets/music/alert.wav") @:noCompletion #if display private #end class __ASSET__assets_music_alert_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/alert2.wav") @:noCompletion #if display private #end class __ASSET__assets_music_alert2_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/coin.wav") @:noCompletion #if display private #end class __ASSET__assets_music_coin_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/combat.wav") @:noCompletion #if display private #end class __ASSET__assets_music_combat_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/fled.wav") @:noCompletion #if display private #end class __ASSET__assets_music_fled_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/hurt.wav") @:noCompletion #if display private #end class __ASSET__assets_music_hurt_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/lose.wav") @:noCompletion #if display private #end class __ASSET__assets_music_lose_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/miss.wav") @:noCompletion #if display private #end class __ASSET__assets_music_miss_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/select.wav") @:noCompletion #if display private #end class __ASSET__assets_music_select_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/step.wav") @:noCompletion #if display private #end class __ASSET__assets_music_step_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/win.wav") @:noCompletion #if display private #end class __ASSET__assets_music_win_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/xml/GameOverState.xml") @:noCompletion #if display private #end class __ASSET__assets_xml_gameoverstate_xml extends haxe.io.Bytes {}
@:keep @:file("assets/xml/MenuState.xml") @:noCompletion #if display private #end class __ASSET__assets_xml_menustate_xml extends haxe.io.Bytes {}
@:keep @:file("assets/xml/UpgradeState.xml") @:noCompletion #if display private #end class __ASSET__assets_xml_upgradestate_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
