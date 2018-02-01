package ;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flash.utils.Timer;
import flixel.ui.FlxBar;
import flixel.util.FlxTimer;
//import Boss;

/**
 * ...
 * @author ...
 */
class Personaje extends FlxSprite
{
	private var contador : Float = 0;
	private var tieneQueContar:Bool = false;
	private var contador2 : Float = 0;
	private var tieneQueContar2:Bool = false;
	public var coleccionBalas:FlxTypedGroup<Disparo>;
	private var timer:FlxTimer;
	private var disparoActivo:Bool = false;
	private var saltaDoble: Bool = false;
	public var vida:Int = 1000;
	
	public var convaleciente:Bool = false; 
	public var timerConvaleciente:FlxTimer;
	public var tiempoConvaleciente:Float = 3;
	public var healthBar:FlxBar; 
	public var posFinalCriticaX:Float;
	public var posFinalLevel_bool:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		
		loadGraphic(AssetPaths.PlayerSprites__png, true, 31 , 42);
		acceleration.y = Reg.AceleracionV;
		animation.add("idle", [4], 4);
		animation.add("walk", [5, 6, 7], 6);
		animation.add("jump", [1], 4);
		animation.add("fall", [3], 4);
		
		animation.add("shoot", [11], 2);
		
		animation.add("shootyjump", [5], 4);
		animation.add("trepar", [2], 4);
		animation.add("shootywalk", [8, 9, 10], 6);
			scale.set(0.8, 0.8);
		height *= 0.7;
		width *= 0.7;
		centerOffsets();
		trace("alto p " + this.height);
		trace("pos y " + this.y);
		healthBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 20, 2, this, "vida", 0, vida, false);
		healthBar.y =100;
		healthBar.x = this.x+72;
		
//			healthBar.alpha = 0;
					
		healthBar.scrollFactor.set(0,0);
		
		
		
		timer = new FlxTimer();
			timerConvaleciente = new FlxTimer();
			
			coleccionBalas = new FlxTypedGroup<Disparo>();
			convaleciente = false;
		FlxG.state.add(healthBar);
		
	
		
	}
	
	override public function update(elapsed:Float):Void
	{		
		
		//trace(contador2);
		//dash();

		
		movimiento();
		trepar();
		Disparo_jugador();
		saltoDoble();
		Convaleciente_Grafica();
		
		
		
		if (tieneQueContar)
		{
			
			contador += elapsed;
		}
		else					
			contador2 += elapsed;
		
		
		
		if (contador >= Reg.ReferenciaContador)
		{
			contador = 0;
			tieneQueContar = false;
		}
		
		
		super.update(elapsed);
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
		
	}
	
	private function saltoDoble():Void	
	{
		
		if (FlxG.keys.justPressed.UP && saltaDoble == true && velocity.y > 0)
		{
			
			velocity.y = -Reg.VelocidadV;
			saltaDoble = false;
			
		}
			
		
	
	}
	
	
	private function trepar(): Void
	{
		acceleration.y = Reg.AceleracionV;
		if (FlxG.keys.pressed.RIGHT && isTouching(FlxObject.RIGHT))
			{
				
				velocity.y = 0;
				acceleration.y = -Reg.Deslis;
				
				if (isTouching(FlxObject.RIGHT))
				{
					acceleration.y = 0;	
					
					if (isTouching(FlxObject.RIGHT) && !isTouching(FlxObject.FLOOR)) 
					{
						if (velocity.x > 0)
						{
							flipX = false;
							
						}
						
						animation.play("trepar");
					}
		
					
				}
				
			}
			
			if (FlxG.keys.pressed.LEFT && isTouching(FlxObject.LEFT))
			{
				
				velocity.y = 0;
				acceleration.y = -Reg.Deslis;
				
				if (isTouching(FlxObject.LEFT))
				{
					acceleration.y = 0;	
					
					if (isTouching(FlxObject.LEFT) && !isTouching(FlxObject.FLOOR)) 
					{
						if (velocity.x < 0)
						{
							flipX = true;
							
						}
						
						animation.play("trepar");
					}
					
				}
				
			}
	}
	
	private function dash():Void
	{
		if (FlxG.keys.justPressed.RIGHT)
		{
			if (!tieneQueContar)
			{
				tieneQueContar = true;	
				
				
			}
			else if (contador2 >= 2) //el dos es el tiempo a esperar para hacer el dash
			{
				x += 30;
				tieneQueContar = false;
				contador = 0;
				contador2 = 0;
			}				
		}
		
		if (FlxG.keys.justPressed.LEFT)
		{
			if (!tieneQueContar)
			{
				tieneQueContar = true;	
				
				
			}
			else if (contador2>=2)//el dos es el tiempo a esperar para hacer el dash
			{
				x -= 30;
				tieneQueContar = false;
				contador = 0;
				contador2 = 0;
			}				
		}
	}
	
	private function movimiento():Void
	{	velocity.x = 0;
	
		//if (FlxG.keys.justPressed.RIGHT)
		//{
		//	if (tieneQueContar == false)
		//tieneQueContar = true;
		//	else
		//		velocity.x += (Reg.VelocidadH + 1300);
		//}
	
	if (FlxG.keys.pressed.RIGHT&&this.x<5110-this.width)
			{
				velocity.x += Reg.VelocidadH;
			}
		if (FlxG.keys.pressed.LEFT&&this.x>0)
			{
				if(!posFinalLevel_bool){
				velocity.x -= Reg.VelocidadH;
				}else{
					if(this.x>posFinalCriticaX){
						velocity.x -= Reg.VelocidadH;//para q no pueda huir o no enfrentar el level el jugador
					}
				{
					
				}
					
				}
				
				}
			
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR)) 
			{
				velocity.y = -Reg.VelocidadV;
				saltaDoble = true;	
			healthBar.y -= 10;	
			}
			
		if (velocity.y > 0)
			{
				animation.play("fall");
			}
		else if (velocity.y < 0)
			{
				animation.play("jump");
			}
		else if (isTouching(FlxObject.FLOOR))
		{healthBar.y =100;
			if (velocity.x > 0)
			{
				if (!FlxG.keys.pressed.SPACE) 
				{
					animation.play("walk");
					flipX = false;
				}
				
				
				if (FlxG.keys.pressed.SPACE) 
				{
					animation.play("shootywalk");
					flipX = false;
				}
			}
			else if (velocity.x < 0)
			{
				if (FlxG.keys.pressed.SPACE) 
				{
					animation.play("shootywalk");
					flipX = true;
				}
				if (!FlxG.keys.pressed.SPACE) 
				{
					animation.play("walk");
					flipX = true;
				}
				
							
			}
			
			
			else
				animation.play("idle");
		}
		
		
	
	}
	private function Disparo_jugador():Void{
		
		
		
		if (FlxG.keys.justPressed.SPACE && disparoActivo == false)
		{FlxG.sound.play(AssetPaths.Laser_Shoot);

	
		switch flipX{
			
			case false:
				var auxBala:Disparo;
				auxBala = new Disparo(0, 0, null, 1, 0, Reg.velocidadBalaJugador,1,0);
				auxBala.x = this.x;
				auxBala.y = this.y + height / 2;
				animation.play("shoot");
				flipX = false;
			
				coleccionBalas.add(auxBala);
				FlxG.state.add(coleccionBalas);
				disparoActivo = true;
			timer.start(Reg.fireRatePlayer, TimerDisparoJugador, 1);
				case true:
			var auxBala:Disparo;
				auxBala = new Disparo(0, 0, null,-1, 0, Reg.velocidadBalaJugador,1,0);
				auxBala.x = this.x;
				auxBala.y = this.y + height / 2;
				animation.play("shoot");
				flipX = true;
			
				coleccionBalas.add(auxBala);
				FlxG.state.add(coleccionBalas);
				disparoActivo = true;
				timer.start(Reg.fireRatePlayer, TimerDisparoJugador, 1);
			}
			
		} 
			
			
		
		
	 
	}

	private function TimerDisparoJugador(t:FlxTimer){
		
		
	//trace("entrando");
	disparoActivo = false;
		
	}
	public function Convaleciente_01(t:FlxTimer){
		trace("libre para recibir ");
		convaleciente = false;
		
		
	}
	private function Convaleciente_Grafica(){
		
		if (convaleciente){
		//trace("timer convaleciente " + timerConvaleciente.elapsedTime);	
		if(timerConvaleciente.elapsedTime<0.5||timerConvaleciente.elapsedTime>1&&timerConvaleciente.elapsedTime<1.5||timerConvaleciente.elapsedTime>2&&timerConvaleciente.elapsedTime<2.5){
			this.visible = false;
			//trace("no visible");
		}else {
			this.visible = true;
			//trace("visible");
			}
		}
	}
	
	}
