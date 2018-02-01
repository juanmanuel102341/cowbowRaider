package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Ascensor extends FlxSprite
{	
	

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.Ascensor__png, true, 64, 20,false);
		animation.add("idle", [0], 6);
		animation.play("idle");
		
		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	
		
	}
	
}