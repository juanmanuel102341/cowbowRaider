package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
/**
 * ...
 * @author ...
 */
class Level_trampaElectrica extends FlxSprite
{
		public var muerteTrampaElectrica:Bool = false;
		public var timer_cicloTrampa:FlxTimer;
		public var trampactiva_bool:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.Trap_01__png, true, 48, 16, true);
		animation.add("idle", [0], 6);
		animation.add("activa", [1, 2], 6, false);
		animation.play("idle");
	trampactiva_bool = false;
	timer_cicloTrampa = new FlxTimer();	
	}
	override public function update(elapsed:Float):Void
	{		
		super.update(elapsed);
	
		if(trampactiva_bool==false){
			
		}else{
			TrampaActiva();
		}
	}
	
	public function TrampaActiva(){
		trampactiva_bool = true;
		animation.play("activa");
	}
	
	public function TrampaOff(t:FlxTimer){
	trampactiva_bool = false;
		animation.stop();
		animation.play("idle");
	}
	public function DestruirTelectrica(){
		FlxG.sound.play(AssetPaths.enemiMuerto);
		timer_cicloTrampa.destroy();
		muerteTrampaElectrica = true;
		destroy();
	}
}