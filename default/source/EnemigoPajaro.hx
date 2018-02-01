package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
 /* ...
 * @author ...
 */
class EnemigoPajaro extends FlxSprite
{
	private var movX:Float =1.5;//achato parabola 
	private var movY:Float =5.0;//subo parabola
	public var posInicialY:Float;
	private var acumulativoGravedad:Float = 0.0;
	private var gravedad:Float = 0.3;
	public var muerte:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
	
		super(X, Y, SimpleGraphic);
	
		//makeGraphic(20, 20, FlxColor.CYAN);
		loadGraphic(AssetPaths.Enemy1__png,true,28,25);
		animation.add("movimiento", [1, 2, 3, 4], 6);
			animation.play("movimiento");
	   muerte = false;
	   
		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		acumulativoGravedad += gravedad;
		
		Mover();
		Destruccion();
		
		if (this.y >= posInicialY)
		{
		
		acumulativoGravedad = 0;
		
		}
	}
	private function Mover(){
		animation.play("movimiento");
		this.x -= movX;
		this.y -= movY;
		this.y += acumulativoGravedad;
	
			
	}
	private function Destruccion(){
		
		if (this.x < 0){
		//	trace("muerte pajaro");
		
			Muerte_Pajaro();
		}
	
		
	}

	public function Muerte_Pajaro(){
	muerte = true;//para q no reviva posteriormente
	FlxG.sound.play(AssetPaths.enemiMuerto);
	
	destroy();
	}
	
}