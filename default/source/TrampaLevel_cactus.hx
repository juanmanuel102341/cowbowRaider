package;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class TrampaLevel_cactus extends FlxSprite
{
	public var muerteKactus:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Cactus__png);
	
		muerteKactus = false;
	}
	
	override public function update(elapsed:Float):Void
	{		
		super.update(elapsed);
	
		
	}
	
	public function MuerteCactus_01(){
		FlxG.sound.play(AssetPaths.enemiMuerto);
		muerteKactus = true;
		destroy();
	}
}