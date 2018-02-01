package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Disparo extends FlxSprite
{
	private var velocidadBala:Int;
	private var direccionX:Int;
	private var direccionY:Int;
	
	private var proporcionX:Float;
	private var proporcionY:Float;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset,_direccionX:Int,_direccionY:Int,_velocidadBala:Int,_proporcionX:Float,_proporcionY:Float) 
	{	super(X, Y, SimpleGraphic);
	
		velocidadBala = _velocidadBala;
		direccionX = _direccionX;
		direccionY = _direccionY;
		proporcionX = _proporcionX;
		proporcionY = _proporcionY;
		
		makeGraphic(5, 2, FlxColor.PINK);
		MoverBala();
		
	}
	
     override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
		DestruccionBala();		
	}
	
	
	public function MoverBala(){    
		this.velocity.x= velocidadBala*direccionX*proporcionX;
		this.velocity.y=velocidadBala * proporcionY*direccionY;
		
		 
		
		
	}
	private function DestruccionBala(){
		
		if (this.x >5140||this.x<0||this.y<480||this.y+this.height>720){
			//	trace("muerte bala");
			
			destroy();
			//		auxB.destroy();
				
			}
	
		
	}
	
}