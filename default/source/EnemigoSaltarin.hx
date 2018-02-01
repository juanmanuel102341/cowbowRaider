//import flash.utils.Timer;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;


import flixel.group.FlxGroup.FlxTypedGroup;
/**
/**
 * ...
 * @author ...
 */
class EnemigoSaltarin extends FlxSprite
{
	private var timerSalto:FlxTimer;
	public var timeActivacion:FlxTimer;
	public var time_de_Activacion:FlxTimer;
	private var timeFireRate:FlxTimer;
	
	private var tiempoSalto:Float=1.5;
	public var tiempoActivo:Float=3;

	public var grupoBalasSaltarin:FlxTypedGroup<Disparo>;
	public var muerteSaltarin:Bool = false;
	
	private var posInicial:Float;
	private var acumulativoGravedad:Float=0;
	private var gravedad:Float = 0.3;
	private var salto_activo_bool:Bool = false;
	private var movX:Float =1.5;//achato parabola 
	private var movY:Float =5.0;//subo parabola
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.EnemyTower__png, true, 32, 45);
		animation.add("idle", [0]);
		animation.add("active", [1, 2, 3, 4],4,false);
		animation.add("de_active", [4, 3, 2, 1], 4,false);
		grupoBalasSaltarin = new FlxTypedGroup<Disparo>();
		timeActivacion = new FlxTimer();
		timerSalto = new FlxTimer();
		timeFireRate = new FlxTimer();
		time_de_Activacion = new FlxTimer();
		muerteSaltarin = false;
		salto_activo_bool = false;
		animation.play("idle");
	
		posInicial = this.y;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(salto_activo_bool){
		EjecutandoSalto();
		}
	}
	public function Activacion_01(t:FlxTimer){
		
		animation.play("active");
	
		
	timeFireRate.start(0,CreacionDisparo, 1);
	
	
	}
	
	private function CreacionDisparo(t:FlxTimer){
		
		var auxB:Disparo = new Disparo(0, 0, null, -1, 0, Reg.velocidadBala_saltarin, 1, 0);
		auxB.x = this.x;
		auxB.y = this.y+this.height/2+auxB.height/2+5;
		grupoBalasSaltarin.add(auxB);
		FlxG.state.add(grupoBalasSaltarin);
		
		animation.stop();
		animation.play("de_active");
		
		time_de_Activacion.start(1, PreparandoSalto, 1);
		
	}
	private function PreparandoSalto(t:FlxTimer){
		animation.stop();
		animation.play("active");
			timeActivacion.start(tiempoSalto, Saltando, 1);
		//timerSalto.start(tiempoSalto, Salto_activo, 1);
	
	}
	private function Saltando(t:FlxTimer){
	
		salto_activo_bool = true;
		
		
		
	}
	private function EjecutandoSalto(){
		this.x -= movX;
		this.y -= movY;
		this.y += acumulativoGravedad;
		acumulativoGravedad += gravedad;
		if (this.y >= posInicial)
		{
				
		acumulativoGravedad = 0;
		salto_activo_bool = false;		
		timeFireRate.start(Reg.fireRateSaltarin,CreacionDisparo, 1);
		}

	}
	public function MuerteSaltarin_01(){
	FlxG.sound.play(AssetPaths.enemiMuerto);
		timerSalto.destroy();
	timeFireRate.destroy();
	time_de_Activacion.destroy();
	timeActivacion.destroy();
	muerteSaltarin = true;
	kill();
		
		
	}
	
	
}