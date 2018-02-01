package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
//import flash.utils.Timer;
import flixel.util.FlxTimer;

import flixel.group.FlxGroup.FlxTypedGroup;
/**
 * ...
 * @author ...
 */
class EnemigoBola_01 extends FlxSprite
{
	
	
	public var timer_fire_01:FlxTimer;
	private var timer_pasivo_01:FlxTimer;
	private var timer_animacionActivo:FlxTimer;
	private var timer_animacionDe_Activo:FlxTimer;
	
	private var timeAnimacion_activo:Float = 2.2;
	private var timeAnimacion_de_activo:Float = 1;
	
	
	public var grupoBalas:FlxTypedGroup<Disparo>;
	public var muerteBola:Bool=false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		timer_fire_01 = new FlxTimer();
		timer_pasivo_01 = new FlxTimer();
		timer_animacionActivo = new FlxTimer();
		timer_animacionDe_Activo = new FlxTimer();
		//makeGraphic(14, 14, FlxColor.GREEN);
			
		loadGraphic(AssetPaths.EnemyEye__png, true, 24, 24);
		animation.add("idle", [10, 9], 4);
		animation.add("active", [8, 7, 6, 5, 4, 3, 2, 1], 8);
		animation.add("de_active", [1, 2, 3, 4, 5, 6, 7, 16], 8);
		
		this.velocity.x = -Reg.velocidadE_BOLA;
		
		grupoBalas = new FlxTypedGroup<Disparo>();
				
		//timer_fire_01.start(4, CicloDisparo, 3);//lo saco porque sino dispaara entes
	animation.play("idle");
		muerteBola = false;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if(this.x<0){
			
			timer_fire_01.destroy();
			timer_pasivo_01.destroy();
			MuerteBola_01();
			
		}
		
	}
	private function CreacionDisparo(){
		
		for (i in 0...6){
			switch i{
			
			case 0:
			//trace("disparo entrando");
				var d:Disparo = new Disparo(0, 0, null, -1, 0, Reg.velocidadBalaTorretaOjo,1,0);
			d.x = this.x+this.width/2+d.width/2;
			d.y = this.y+this.height/2;
			grupoBalas.add(d);
		
			
			
			case 1:
			var d:Disparo = new Disparo(0, 0, null, 1, 0, Reg.velocidadBalaTorretaOjo,1,0);
			d.x = this.x+this.width/2+d.width/2;
			d.y = this.y+this.height/2;
			grupoBalas.add(d);
			
			case 2:
			var d:Disparo = new Disparo(0, 0, null, 0, 1, Reg.velocidadBalaTorretaOjo,0,1);
			d.set_angle(90);
			d.x = this.x+this.width/2+d.width/2;
			d.y = this.y+this.height/2;
			grupoBalas.add(d);
			
			case 3:
			var d:Disparo = new Disparo(0, 0, null, 0, -1, Reg.velocidadBalaTorretaOjo,0,1);
			d.set_angle(90);
			d.x = this.x+this.width/2+d.width/2;
			d.y = this.y+this.height/2;
			grupoBalas.add(d);
			
			case 4:
			var d:Disparo = new Disparo(0, 0, null, 1, -1, Reg.velocidadBalaTorretaOjo,0.5,0.5);
			d.set_angle(-45);
			d.x = this.x+this.width/2+d.width/2;
			d.y = this.y+this.height/2;
			grupoBalas.add(d);
			case 5:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaTorretaOjo,0.5,0.5);
			d.set_angle(-45);
			d.x = this.x+this.width/2+d.width/2;
			d.y = this.y+this.height/2;
			grupoBalas.add(d);
			
			
			}
				
		}
	
			FlxG.state.add(grupoBalas);

	}
	public function CicloDisparo(Timer:FlxTimer):Void{

			timer_fire_01.active = false;
		this.velocity.x = 0;
	
		trace("disparo");
		animation.stop();
	
		animation.play("active");
		if(!muerteBola){
		CreacionDisparo();
		}
		timer_animacionActivo.start(timeAnimacion_activo, Animacion_deactive, 1);
		timer_pasivo_01.start(3, CicloMover, 1);
		
	}
	public function CicloMover(Timer:FlxTimer):Void{
		
		timer_fire_01.active = true;	
	//	animation.stop();
		
		
		this.velocity.x =-Reg.velocidadE_BOLA;
		
		
	}
	private function Animacion_deactive(t:FlxTimer){
		animation.stop();
		animation.play("de_active");
		timer_animacionDe_Activo.start(timeAnimacion_de_activo, Anim_Idle);
	}
	public function MuerteBola_01(){
		FlxG.sound.play(AssetPaths.enemiMuerto);
		muerteBola = true;
		timer_fire_01.destroy();
		timer_pasivo_01.destroy();
		timer_animacionActivo.destroy();
		timer_animacionDe_Activo.destroy();
	
		kill();// utilizo kill en parte para q las balas puedan seguir su curso
	}
	private function Anim_Idle(t:FlxTimer){
	
		animation.stop();
		animation.play("idle");
	}

	
	
	
}