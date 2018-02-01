package;

/**
 * ...
 * @author ...
 */
class Reg
{
	//presonaje 140
	
	static public var VelocidadH: Float = 140;
	static public var ReferenciaContador : Float = 0.5;
	static public var VelocidadV : Float= 300;
	static public var AceleracionV : Float = 800;
	static public var Deslis: Float = 30;
	static public var fireRatePlayer:Float = 1;
	static public var velocidadBalaJugador:Int = 300;
	
	
	//enemigo bola
	
	static public var velocidadE_BOLA:Float=50;
	static public var timeBolaFire:Float = 4.5;
	static public var velocidadBalaTorretaOjo:Int =50;
	static public var danioEnemigoBola:Int = 20;

	//enemigo pajaro
	static public var danioPajaro:Int = 10;
	
	//enemigo torreta
	static public var fireRateTorreta:Float =6.5;
	static public var velocidadBalaTorreta:Int = 50;
	static public var danioBalaTorreta:Int = 20;
	static public var danioTorreta:Int = 15;
	
	//enemigo saltarin
	static public var fireRateSaltarin:Float = 4.5;
	static public var danioBala_saltarin:Int = 20;
	static public var danio_saltarin:Int = 15;
	static public var velocidadBala_saltarin:Int = 65;
	
	
	//trampa kactus
	static public var danioKactus:Int = 10;
	static public var danioTrampa:Int = 25;
	//boss
	static public var velocidadBalaBoss:Int = 150;
	static public var danioBalasBoss:Int = 30;
	
	//player
	static public var danioBalasHeroe:Int = 25;
	public function new() 
	{
		
	}
	
}