package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
/**
 * ...
 * @author ...
 */
class EnemigoTorreta extends FlxSprite
{
	public var timer_fire_01:FlxTimer;
	
	
	public var grupoBalas:FlxTypedGroup<Disparo>;
	
	public var muerteTorreta:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
	loadGraphic(AssetPaths.EnemyTower__png, true, 32, 45);
	
	animation.add("idle", [0]);
	timer_fire_01 = new FlxTimer();
	
	

	grupoBalas = new FlxTypedGroup<Disparo>();
	muerteTorreta = false;
	
	animation.play("idle");
	}
	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);

	
	}

	
	

	private function CreacionDisparo(){
		
		for (i in 0...3){
			switch i{
			
			case 0:
	//		trace("disparo entrando");
			var d:Disparo = new Disparo(0, 0, null, -1, -1, Reg.velocidadBalaTorreta,0.5,0.5);
			d.set_angle(-140);
			d.x = this.x+this.width/2-2;
			d.y = this.y+30;
			grupoBalas.add(d);
		
			
			
			case 1:
			var d:Disparo = new Disparo(0, 0, null, 0, -1, Reg.velocidadBalaTorreta,0,1);
			d.set_angle(90);
			d.x = this.x+this.width/2-1;
			d.y = this.y+30;
			grupoBalas.add(d);
			
			case 2:
			var d:Disparo = new Disparo(0, 0, null, 1, -1, Reg.velocidadBalaTorreta,0.5,0.5);
			d.set_angle(-40);
			d.x = this.x+this.width/2;
			d.y = this.y+30;
			grupoBalas.add(d);
			
			
			
			}
				
		}
	
			FlxG.state.add(grupoBalas);

	}
	public function cicloDisparo(Timer:FlxTimer):Void{
		
	//trace("disparo torreta "+Timer.elapsedLoops);
	//trace("activa");
	//sostenTorreta.visible = true;

	if(!muerteTorreta){
	
	CreacionDisparo();
	}
		
	}

	public function MuerteTorreta_01(){
		
		FlxG.sound.play(AssetPaths.enemiMuerto);
		muerteTorreta = true;
		timer_fire_01.destroy();
		
		kill();
	}

	
}