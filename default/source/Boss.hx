package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
//import flash.utils.Timer;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite
{	private var timerSalto:FlxTimer;
	
	public var timeActivacion_boss:FlxTimer;
	public var time_de_Activacion_boss:FlxTimer;
	private var timeFireRate:FlxTimer;
	private var tiempoSalto:Float=1.5;
	public var tiempoActivo_boss:Float=7.5;

	public var grupoBalas_boss:FlxTypedGroup<Disparo>;
	public var muerte_boss:Bool = false;
	
	
	private var posInicialY:Float;
		private var posInicialX:Float;
	private var acumulativoGravedad:Float=0;
	private var gravedad:Float = 0.6;
	private var salto_activo_bool:Bool = false;
	private var movX:Float =4.5;//achato parabola 
	private var movY:Float= 6.5;//subo parabola
	
	
	private var timer_patronDisparo_1:FlxTimer;
	private var timer_patronDisparo_2:FlxTimer;
	private var timer_patronDisparo_3:FlxTimer;
	private var timer_patronDisparo_4:FlxTimer;
	private var timer_patronDisparo_5:FlxTimer;
	private var timer_salto_disparo:FlxTimer;
	private var timer_patronDisparo_vueltaCiclo:FlxTimer;
	private var tiempo_patron_1:Float = 2.5;
	private var tiempo_patron_2:Float = 2.5;
	private var tiempo_patron_3:Float = 2.5;
	private var tiempo_patron_4:Float = 2.5;
	private var tiempo_patron_salto_disparo:Float = 0.5;
	private var timerFonVictoria:FlxTimer;
	public var vidaJefe:Int = 600;
	private var healthBar_boss:FlxBar;
	private var momentoCritico:Int ;
	private var posicionFlip:Float;
	private var direccion:Int = 1;
	private var desplazamientoHorizontal:Int = 7;
	private var desplazamientoVertical:Int = 6;
	private var patronHorizontal:Bool = false;
	private var cantidadCiclosHorizontal:Int = 0;
	private var patronDisparoSalto:Bool = false;
	private var finDisparoSalto:Bool = false;
	public var win:Bool = false;
	private var limiteYpatronSalto:Float;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.EnemyTower__png, true, 32, 45);
		
		
		animation.add("idle", [0]);
		animation.add("active", [1, 2, 3, 4],4,false);
		
		animation.add("de_active", [4, 3, 2, 1], 4,false);
		
	grupoBalas_boss = new FlxTypedGroup<Disparo>();
		timeActivacion_boss = new FlxTimer();
		timerSalto = new FlxTimer();
		timeFireRate = new FlxTimer();
		time_de_Activacion_boss = new FlxTimer();
		timer_patronDisparo_1 = new FlxTimer();
		timer_patronDisparo_2=new FlxTimer();
		timer_patronDisparo_3=new FlxTimer();
		timer_patronDisparo_4 = new FlxTimer();
		timer_patronDisparo_5 = new FlxTimer();
		timer_patronDisparo_vueltaCiclo = new FlxTimer();
		timer_salto_disparo = new FlxTimer();
		
		
		this.kill();
	
		healthBar_boss = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 40, 2, this, "vidaJefe", 0, vidaJefe, false);
		healthBar_boss.y =this.y-15;
		healthBar_boss.x = this.x -5;
		healthBar_boss.scrollFactor.set(1,1);
		salto_activo_bool = false;	
		FlxG.state.add(healthBar_boss);
	
		posInicialY = this.y-10;
		posInicialX = this.x;
		trace("posInicial" + posInicialX);
		posicionFlip = this.x - 200;
		scale.set(1.5, 1.5);
		direccion = 1;
	momentoCritico = Math.round(vidaJefe * 0.25);
	trace("momento critico " + momentoCritico);
		patronHorizontal = false;
		patronDisparoSalto = false;
	finDisparoSalto = false;
		limiteYpatronSalto = this.y - 120;
	win = false;
	camera.y += 140;
	camera.x -= 70;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	
		
	
		 EjecucionSaltoDisparo();
		MovimientoHorizontal();
		BajandoDisparoSaltoJefe(); 
		
		MuerteJefe();
		
	}
	public function Activacion_boss(t:FlxTimer){
		
		animation.play("active");
	
		
//	

timer_patronDisparo_1.start(tiempo_patron_1,CreacionDisparo_1,3);
	
	
	
	}
	
	private  function CreacionDisparo_1(t:FlxTimer){
	
		
		for (i in 0...5){
			switch i{
			
			case 0:
	//		trace("disparo entrando");
			var d:Disparo = new Disparo(0, 0, null, -1, -1, Reg.velocidadBalaBoss,0.5,0.5);
			d.set_angle(-140);
			d.x = this.x;
			d.y = this.y + this.height / 2;
			grupoBalas_boss.add(d);
		
			
			
			case 1:
			var d:Disparo = new Disparo(0, 0, null, -1, -1, Reg.velocidadBalaBoss,0.6,0.4);
			d.set_angle(-140);
			d.x = this.x;
			d.y = this.y+this.height/2;
			grupoBalas_boss.add(d);
			
			case 2:
			var d:Disparo = new Disparo(0, 0, null, -1, -1,Reg.velocidadBalaBoss,0.4,0.6);
			d.set_angle(-140);
			d.x = this.x;
			d.y = this.y+this.health/2;
			grupoBalas_boss.add(d);
			case 3:
			var d:Disparo = new Disparo(0, 0, null, -1, -1, Reg.velocidadBalaBoss,0.7,0.3);
			d.set_angle(-140);
			d.x = this.x;
			d.y = this.y+this.height/2;
			grupoBalas_boss.add(d);
			case 4:
			var d:Disparo = new Disparo(0, 0, null, -1, -1, Reg.velocidadBalaBoss,0.3,0.7);
			d.set_angle(-140);
			d.x = this.x;
			d.y = this.y+this.height/2;
			grupoBalas_boss.add(d);
			
				
				}
		
				
		}
	
		FlxG.state.add(grupoBalas_boss);
	if (t.elapsedLoops >= 3){
		trace("entrando 2do patron");
		timer_patronDisparo_2.start(tiempo_patron_2, CreacionDisparo_2, 3);
	
	}
	}
	private  function CreacionDisparo_2(t:FlxTimer){
		
		
		for (i in 0...5){
			switch i{
			
			case 0:
	//		trace("disparo entrando");
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,1,0);
			//d.set_angle(-140);
			d.x = this.x+this.width/2-15;
			d.y = this.y+20;
			grupoBalas_boss.add(d);
		
			
			
			case 1:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.9,0.1);
			//d.set_angle(-170);
			d.x = this.x+this.width/2-15;
			d.y = this.y+20;
			grupoBalas_boss.add(d);
			
			case 2:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.8,0.2);
			//d.set_angle(-160);
			d.x = this.x+this.width/2-15;
			d.y = this.y+20;
			grupoBalas_boss.add(d);
			case 3:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.7,0.3);
			//d.set_angle(-150);
			d.x = this.x+this.width/2-15;
			d.y = this.y+20;
			grupoBalas_boss.add(d);
			case 4:
			var d:Disparo = new Disparo(0, 0, null, -1, 1,Reg.velocidadBalaBoss,0.6,0.4);
		//	d.set_angle(-140);
			d.x = this.x+this.width/2-15;
			d.y = this.y+20;
			grupoBalas_boss.add(d);
			
				
				}
		
				
		}
		
		FlxG.state.add(grupoBalas_boss);
	
		if(t.elapsedLoops>=3){
			timer_patronDisparo_3.start(tiempo_patron_3, CreacionDisparo_3, 3);
		}
	}
		private  function CreacionDisparo_3(t:FlxTimer){
		
			var d:Disparo = new Disparo(0, 0, null, -1, 1, 450,1,0);
			//d.set_angle(-140);
			d.makeGraphic(10, 3, FlxColor.ORANGE);
			
			d.x = this.x+this.width/2-15;
			d.y = this.y+30;
			
			grupoBalas_boss.add(d);
			FlxG.state.add(grupoBalas_boss);
		
			if(t.elapsedLoops>=3){
			timer_patronDisparo_4.start(tiempo_patron_4, PatronHorizontal_01, 1);
			}
		}
		
		private function PatronHorizontal_01(t:FlxTimer){
			
			patronHorizontal = true;
			this.set_angle(-90);
		}
		private function MovimientoHorizontal(){
				if(patronHorizontal){
			this.x -= desplazamientoHorizontal * direccion;
				
			healthBar_boss.x = this.x-5;
			
			healthBar_boss.y = this.y-15;
			if(this.x<posicionFlip){
			
				direccion *=-1;
			flipY= true;
			}else if(this.x>posInicialX){
				
			direccion *=-1;
			flipY = false;
			trace("pos x base");
			cantidadCiclosHorizontal += 1;
			trace("cantidadCiclos " + cantidadCiclosHorizontal);
			
				}
		
			if(cantidadCiclosHorizontal==2){
				trace("ciclos fin ");
				flipY = true;
				patronHorizontal = false;
				this.set_angle( 180);
				flipX = true;
				
				patronDisparoSalto = true;
				direccion = 1;
				//timer_salto_disparo.start(tiempo_patron_salto_disparo, PatronSaltoDisparo_01, 1);
					}
				
				}
		
			
		}
		
		private function PatronSaltoDisparo_01(t:FlxTimer){
			//patronDisparoSalto = true;
		}
		private function EjecucionSaltoDisparo(){
			if(patronDisparoSalto){
			//trace("salto disparo");
		//	trace("pos y " + y);
			healthBar_boss.x = this.x-5;
			healthBar_boss.y = this.y-15;
			this.y -= desplazamientoVertical*direccion;
			if(this.y<limiteYpatronSalto){
			set_angle( 120);
				trace("limite y alzanzo ");
			direccion = 0;
			
			timer_patronDisparo_5.start(0.5, CreacionDisparoPatronSalto, 4);	
			
			patronDisparoSalto = false;
			
			
			}
			
			
			}
		}
		private function CreacionDisparoPatronSalto(t:FlxTimer){
			trace("entrando patron VUELTAS "+t.elapsedLoops);
			patronDisparoSalto = false;
			//this.y += desplazamientoVertical*direccion;
			if(t.elapsedLoops>=3){
			direccion = 1;
				finDisparoSalto = true;
				
					trace("fuera patron disparo salto");
			
					
			}
			//direccion = 1;
			
			//patronDisparoSalto = true;
			EjecucionPatronSaltoDisparo();
		}
		private function BajandoDisparoSaltoJefe(){
			if(finDisparoSalto){
			this.y += desplazamientoVertical*direccion;
			healthBar_boss.x = this.x-5;
			healthBar_boss.y = this.y-15;
			if(this.y>posInicialY){
				trace("entrando posicio incial y");
				direccion = 0;
				set_angle(180);
				timer_patronDisparo_vueltaCiclo.start(1,VueltaCiclo,1);
				finDisparoSalto = false;
			}
			
			}
			
			}
		private function EjecucionPatronSaltoDisparo(){
			
			for (i in 0...5){
			switch i{
			
			case 0:
			trace("disparo entrando");
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.5,0.5);
			d.set_angle(-120);
			d.x = this.x;
			d.y = this.y + this.height / 2;
			grupoBalas_boss.add(d);
		
			
			
			case 1:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.6,0.5);
			d.set_angle(-120);
			d.x = this.x;
			d.y = this.y+this.height/2;
			grupoBalas_boss.add(d);
			
			case 2:
			var d:Disparo = new Disparo(0, 0, null, -1, 1,Reg.velocidadBalaBoss,0.7,0.5);
			d.set_angle(-120);
			d.x = this.x;
			d.y = this.y+this.health/2;
			grupoBalas_boss.add(d);
			case 3:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.8,0.5);
			d.set_angle(-120);
			d.x = this.x;
			d.y = this.y+this.height/2;
			grupoBalas_boss.add(d);
			case 4:
			var d:Disparo = new Disparo(0, 0, null, -1, 1, Reg.velocidadBalaBoss,0.9,0.5);
			d.set_angle(-120);
			d.x = this.x;
			d.y = this.y+this.height/2;
			grupoBalas_boss.add(d);
			
				
				}
			
			} 
		FlxG.state.add(grupoBalas_boss);
			
		}

		private function VueltaCiclo(t:FlxTimer){
			timer_patronDisparo_1.start(tiempo_patron_1,CreacionDisparo_1,3);
		
				direccion = 1;
		
				cantidadCiclosHorizontal = 0;
		
					//flipX = true;
		}
		
		
		
		
		public function MuerteJefe(){
			if(vidaJefe <0){
				FlxG.sound.play(AssetPaths.enemiMuerto);
		timerSalto.destroy();
		timeFireRate.destroy();
		timeActivacion_boss.destroy();
	    
		muerte_boss = true;
		healthBar_boss.destroy();
		//this.kill();
		win = true;
		grupoBalas_boss.forEachAlive(destruccionBalas, false);	
		
			
			
			//finWin = true;	
		
			}
		
			}
		
	
		private function destruccionBalas(obj:Disparo){
			obj.destroy();
		}
		
		
}