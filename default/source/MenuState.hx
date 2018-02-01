package ;

import flash.display.Loader;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.editors.tiled.TiledMap.FlxTiledMapAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
//import flixel.util.FlxColor;

//No me acuerdo para que era este
import flixel.addons.effects.FlxTrail;

class MenuState extends FlxState
{
	public var copiaPajaro:EnemigoPajaro;
	
	public var piso:FlxSprite;
	public var player_1:Personaje;
	public var Boss_1:Boss;
	public var copiaBola2:EnemigoBola_01;
	
	public var nivel_1:FlxTilemap;
	public var nivel_2:FlxTilemap;
	public var nivel_3:FlxTilemap;
	
	public var loader:FlxOgmoLoader;
	
	public var grupoJugador:FlxTypedGroup<Personaje>;
	public var grupo_enemigo_pajaro:FlxTypedGroup<EnemigoPajaro>;
	public var grupo_enemigo_one_eye:FlxTypedGroup<EnemigoBola_01>;
	public var grupo_enemigo_torreta:FlxTypedGroup<EnemigoTorreta>;
	public var grupo_enemigo_saltarin:FlxTypedGroup<EnemigoSaltarin>;
	public var grupoTrampaKactus:FlxTypedGroup<TrampaLevel_cactus>;
	public var grupoTrampa_electrica:FlxTypedGroup<Level_trampaElectrica>;
	public var medidaAlto:Float;
	
	public var copiaEnemigoTorreta:EnemigoTorreta;
	public var distanciaSpawnEnemys:Float;
	public var campoVisual:Float;
	public var spawnEnemyPoint:Float = 50;
	private var posInicialPlayer_x:Float;
	private var posicionFinalLevel:Float = 4500;
	private var finalLevel:Bool = false;
//	public var piso_level:Int = 1;
	//public var distanciaSpawnsY:Float = 240;
	private var loose:Bool = false;
	private var fondoCartelVictoria:FlxSprite;
	private var fondoCartelDerrota:FlxSprite;
	
	private var textoDerrota:FlxText;
	private var finJuego_derrota:Bool = false;
	private var timerLoose:FlxTimer;
		private var textoVictoria:FlxText;
//	private var cartelVictoria:tex
	private var finWin:Bool = false;
	private var timerFonVictoria:FlxTimer;
	override public function create():Void
	{
		
	super.create();
	
		FlxG.debugger.visible=true;
		timerLoose = new FlxTimer();
		timerFonVictoria = new FlxTimer();
		grupoJugador = new FlxTypedGroup<Personaje>();
		grupo_enemigo_pajaro = new FlxTypedGroup<EnemigoPajaro>();
		grupo_enemigo_one_eye = new FlxTypedGroup<EnemigoBola_01>();
		grupo_enemigo_torreta = new FlxTypedGroup<EnemigoTorreta>();
		grupo_enemigo_saltarin = new FlxTypedGroup<EnemigoSaltarin>();
		grupoTrampaKactus = new FlxTypedGroup<TrampaLevel_cactus>();
		grupoTrampa_electrica = new FlxTypedGroup<Level_trampaElectrica>();
		CargaLevel();
		
		//CARGAR LAS ENTIDADES
		loader.loadEntities(entityCreator, "Entities");
	
	
		add(player_1);
		add(grupo_enemigo_pajaro);
		add(grupo_enemigo_one_eye);
		add(grupo_enemigo_torreta);
		add(grupo_enemigo_saltarin);
		add(grupoTrampaKactus);
		add(grupoTrampa_electrica);
		add(Boss_1);
		
		//kill grupos
		MuerteEntidades();
		
		//variables del whorld
		campoVisual = - player_1.x + FlxG.camera.width - player_1.width;
		distanciaSpawnEnemys = campoVisual + spawnEnemyPoint;
		posInicialPlayer_x = player_1.x;
	//trace("pos x " + player_1.x);
	finalLevel = false;
	player_1.posFinalCriticaX = posicionFinalLevel;
	trace("pos player " + player_1.posFinalCriticaX );
	//piso_level = 1;

	loose = false;
		finWin = false;
	FlxG.sound.playMusic(AssetPaths.MierdiTema__wav, 1, true);

	}

	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
	if (player_1.vida < 0){
	if(finJuego_derrota==false){
		trace("PERDISTE");
		Boss_1.MuerteJefe();
		textoDerrota = new FlxText(player_1.x,player_1.y-100,50,"loose",8);
			
			nivel_1.destroy();
			textoDerrota.text = "YOU LOOSE!!!!!!";
			//textoDerrota.setFormat("YOU LOOSE!!!!!!",45,FlxColor.RED);
			add(textoDerrota);
		timerLoose.start(2, FinDerrota_01, 1);
			finJuego_derrota = true;
		
			
	}
			
	}
	if (Boss_1.vidaJefe < 0) {
		if (finWin == false){
			//Boss_1.kill();
		trace("victoria");
			textoVictoria = new FlxText(player_1.x,player_1.y-100,50,"winn!!!"
			,8);
			
			nivel_1.destroy();
			textoVictoria.text = "YOU win!!!!!!";
			//textoDerrota.setFormat("YOU LOOSE!!!!!!",45,FlxColor.RED);
			add(textoVictoria);
			timerFonVictoria.start(2, Finvictoria_01, 1);	
		
			finWin = true;
		}
	}

	
	campoVisual =player_1.x + FlxG.camera.width;//calculo lo q se ve
		distanciaSpawnEnemys = campoVisual + spawnEnemyPoint-posInicialPlayer_x;//calculo desde cuando salen los enemigos desde lo q n se ve
	
		FlxG.collide(nivel_3, player_1);
		
		FlxG.camera.follow(player_1);

	
		//**********************************contactos*********************
	
	
	
	
	//*****************danio a jugador**************
		//pajaro con jugador
	if (!player_1.convaleciente){
		
				FlxG.overlap(player_1, grupo_enemigo_pajaro, ContactoJugador_enemigoPajaro);	
				//contacto con eye propiamente dicho
				FlxG.overlap(player_1, grupo_enemigo_one_eye, ContactoEye_player);
				//jugador torreta
				
				FlxG.overlap(player_1, grupo_enemigo_torreta, ContactoJugador_torreta);
				//jugador kactus
				FlxG.overlap(player_1, grupoTrampaKactus, ContactoJugador_kactus);
				//jugador trampa electrica
				FlxG.overlap(player_1, grupoTrampa_electrica, Contacto_jugadorTrampaElectrica);
				//balas torreta jugador
				for(i in 0...grupo_enemigo_torreta.length){
					
					var aux:FlxTypedGroup<Disparo>;
				
					aux = grupo_enemigo_torreta.members[i].grupoBalas;
						
					FlxG.overlap(player_1, aux, ContactoBalasTorreta_player);
					
				}
				
				//balas saltarin /player
				for(i in 0...grupo_enemigo_saltarin.length){
					var auxS:FlxTypedGroup<Disparo>;
					auxS = grupo_enemigo_saltarin.members[i].grupoBalasSaltarin;
					FlxG.overlap(player_1, auxS, ContactoBalas_saltarin_jugador);
					
				}
				// contacto saltarin player
				
				
				
				FlxG.overlap(player_1, grupo_enemigo_saltarin, Contacto_saltarin_jugador);
				//balas eye con jugador
					
				for (i in 0...grupo_enemigo_one_eye.length){
				//por si hay mas de un enemigo bola, estudia contactos
				var auX_GrupoBalasEye:FlxTypedGroup<Disparo>;
				
				auX_GrupoBalasEye = grupo_enemigo_one_eye.members[i].grupoBalas;
				FlxG.overlap(player_1, auX_GrupoBalasEye,ContactoBalas_eye);
				 
				
					}
	
					
	}else{
		//trace("convaleciendo "+player_1.vida);
	}
	//***danio del jugador
	
	//balas player saltarin
	FlxG.overlap(player_1.coleccionBalas, grupo_enemigo_saltarin, ContactoBalasPlayer_Saltarin);
	//balas jugador con pajaro	
	FlxG.overlap(player_1.coleccionBalas, grupo_enemigo_pajaro, ContactoBalasPlayer_EnemigoPajaro);

	
	//balas jugador con eye
	FlxG.overlap(player_1.coleccionBalas, grupo_enemigo_one_eye, ContadorJugador_enemigo_eye);
	
	
	//balas jugador torreta
	FlxG.overlap(player_1.coleccionBalas, grupo_enemigo_torreta, contactoBalasPlayer_torreta);
	FlxG.overlap(player_1.coleccionBalas, grupoTrampa_electrica, Conctacto_player_trampaElectrica);
	FlxG.overlap(player_1.coleccionBalas, grupoTrampaKactus, Contacto_jugador_kactus);
	
	
	
	//*********************************level**************************
	if(!finalLevel){
	grupo_enemigo_pajaro.forEachDead(DespiertaEntidad_pajaro, false);
	grupo_enemigo_one_eye.forEachDead(DespiertaEntidad_Eye, false);
	grupo_enemigo_torreta.forEachDead(DespiertaEntidad_torreta, false);
	grupo_enemigo_saltarin.forEachDead(DespiertaEntidadSaltarin, false);
	grupoTrampa_electrica.forEachDead(DespiertaEntidad_trampaElectrica, false);
	grupoTrampaKactus.forEachDead(DespiertaEntidadKactus, false);
	
		trace("player pos x " + player_1.x);
	trace("player pos y " + player_1.y);
		//trace("ancho stage " + FlxG.width);
	}else{
		
		
	}
	//trace ("cv " + campoVisual);
	//trace("sp" + distanciaSpawnEnemys);
	CondicionFinalLevel();
	
	
		if (finalLevel){
		//player jefe
		FlxG.overlap(player_1.coleccionBalas, Boss_1, ContactoBalas_heroe_boss);
		
		//balas jefe player
		if(!player_1.convaleciente){
		FlxG.overlap(player_1, Boss_1.grupoBalas_boss, Contacto_balas_boss_player);
		//jefe player
		FlxG.overlap(player_1,Boss_1,ContactoJefe_player);
			}
		
		
		
			
			}
	
	
			
				
	}

	public function CargaLevel()
	{
	
		loader = new FlxOgmoLoader(AssetPaths.Level1__oel);
		
		nivel_1 = loader.loadTilemap(AssetPaths.Background__png, 16, 16, "Fondo");
		
		nivel_3 = loader.loadTilemap(AssetPaths.Tiles__png, 16, 16, "Tiles");
		
		FlxG.worldBounds.set(0,0, 5120,720);
		
		//SETEAR LAS PROPIEDADES DE LAS COLISIONES
		nivel_1.setTileProperties(0, FlxObject.NONE);
		
		nivel_3.setTileProperties(1, FlxObject.ANY,50);
		
		
		add(nivel_1);
		
		add(nivel_3);	
		
		
	}
	
	
	
	
	// CARGAR LAS ENTIDADES, LLAMADO CON EL "loadentities"
	private function entityCreator(entityName:String, entityData:Xml):Void
	{
		//	Parseo la X y la Y de cada entidad en el nivel de OGMO
		var entityStartX:Float = Std.parseFloat(entityData.get("x"));
		var entityStartY:Float = Std.parseFloat(entityData.get("y"));
		
		//	Me fijo qué tipo de entidad tengo que inicializar...
		switch(entityName)
		{
			//	...y creo la entidad y seteo sus cosillas.
			case "Player":
				player_1 = new Personaje(entityStartX, entityStartY);
			case "Enemy1":
			//	trace("e1");
			var enemyPajaro:EnemigoPajaro = new EnemigoPajaro(entityStartX,entityStartY);			
			enemyPajaro.posInicialY = entityStartY;	
			
			grupo_enemigo_pajaro.add(enemyPajaro);
			
			case "Enemy2":
			//trace("e2");	
			var e2:EnemigoBola_01 = new EnemigoBola_01(entityStartX, entityStartY);
				grupo_enemigo_one_eye.add(e2);
			
			case "Enemy3":
				//trace("e3");
				entityStartY -= 25;//la subo un poco asi la podemos matar
				var et:EnemigoTorreta = new EnemigoTorreta(entityStartX, entityStartY);
				grupo_enemigo_torreta.add(et);
			case "Enemy4":
				//trace("e4");
				entityStartY -= 25;//la subo un poco asi lo podemos matar
				var es:EnemigoSaltarin = new EnemigoSaltarin(entityStartX, entityStartY);
				grupo_enemigo_saltarin.add(es);
			case "Boss":
				entityStartY -= 37;
				Boss_1 = new Boss(entityStartX, entityStartY);
				
				trace("boss");
			case "Cactus":
					entityStartY -= 10;
				var aux:TrampaLevel_cactus = new TrampaLevel_cactus(entityStartX, entityStartY);
				grupoTrampaKactus.add(aux);
			case "Trampa":
				trace("trampa e");
				var aux:Level_trampaElectrica = new Level_trampaElectrica(entityStartX, entityStartY);
				grupoTrampa_electrica.add(aux);
				
				
				
		}
	}
	//*******************************contactos***************************
	//**********8contacto jugador
		private function ContactoBalasPlayer_EnemigoPajaro(objBala:FlxObject, objEnemigoP:EnemigoPajaro){
		//muerte pajaro
		
		//trace("contacto pajaro");
		objBala.kill();
		objEnemigoP.Muerte_Pajaro();
		}
		private function ContadorJugador_enemigo_eye(objBala:FlxObject, objEye:EnemigoBola_01){
		trace("contacto eye");	
		//muerte eye
		objBala.kill();
		
		objEye.MuerteBola_01();//lo mato adentro para q n reviva
		
		}
		
		
	
		private function contactoBalasPlayer_torreta(obj_bala_jugador:FlxObject, obj_torreta:EnemigoTorreta){
			//trace("contacto con torreta");
			obj_bala_jugador.kill();
			obj_torreta.MuerteTorreta_01();
		
			
		}
		private function ContactoBalasPlayer_Saltarin(objBala:FlxObject, obj_saltarin:EnemigoSaltarin){
			//muerte saltarin
			objBala.kill();
			obj_saltarin.MuerteSaltarin_01();
		
			
		}
		private function ContactoBalas_heroe_boss(obj_bala_player:Disparo, obj_jefe:Boss){
		//danio jefe
	//	trace("contacto jefe");	
			obj_bala_player.kill();
			obj_jefe.vidaJefe-= Reg.danioBalasBoss;
		
		trace("vida jefe " + obj_jefe.vidaJefe);
		}
		private function Conctacto_player_trampaElectrica(objBala:Disparo,obj_trampa:Level_trampaElectrica){
			objBala.kill();
			obj_trampa.DestruirTelectrica();
		}
		private function Contacto_jugador_kactus(objBala:Disparo, obj_kactus:TrampaLevel_cactus){
			objBala.kill();
			obj_kactus.MuerteCactus_01();
		}
		
		//************************contactos a jugador*************************
		
		private function ContactoJugador_enemigoPajaro(objJugador:Personaje, objEnemigo:EnemigoPajaro){
			trace("contacto pajaro ");
			//danio heroe
			//muerte pajaro
			
			//objEnemigo.Muerte_Pajaro();
			objJugador.convaleciente = true;
			objJugador.timerConvaleciente.start(objJugador.tiempoConvaleciente, objJugador.Convaleciente_01, 1);	
			
			objJugador.vida -= Reg.danioPajaro;
			trace("vida2 " + objJugador.vida);
			
		}
		private function ContactoJugador_kactus(obj_personaje:Personaje,objKactus:TrampaLevel_cactus){
			obj_personaje.convaleciente = true;
			obj_personaje.timerConvaleciente.start(obj_personaje.tiempoConvaleciente, obj_personaje.Convaleciente_01, 1);
			
			obj_personaje.vida -= Reg.danioKactus;
				trace("vida2 " + obj_personaje.vida);
		}
		private function Contacto_jugadorTrampaElectrica(obj_personaje:Personaje,objTrampa:Level_trampaElectrica){
		trace("contacto trampa electrica");	
		obj_personaje.convaleciente = true;
		obj_personaje.timerConvaleciente.start(obj_personaje.tiempoConvaleciente, obj_personaje.Convaleciente_01, 1);
		
		obj_personaje.vida -= Reg.danioTrampa;
		objTrampa.trampactiva_bool = true;
		objTrampa.timer_cicloTrampa.start(2, objTrampa.TrampaOff, 1);
		
		}
		private function ContactoJugador_torreta(obj:Personaje,objTorreta:EnemigoTorreta){
			trace("contacto torreta");
			//danio jugador
			//muerte torreta
			obj.convaleciente = true;
			obj.timerConvaleciente.start(obj.tiempoConvaleciente, obj.Convaleciente_01, 1);	
			
			
			
			obj.vida -= Reg.danioTorreta;
			//objTorreta.MuerteTorreta_01();
			trace("vida player "+obj.vida);
		}
		
		private function ContactoBalas_eye(obj_jugador:Personaje, obj_bala_eye:Disparo){
		trace("contacto a jugador eye");
		//danio jugador
		
		obj_bala_eye.kill();
		
		obj_jugador.convaleciente = true;
		obj_jugador.timerConvaleciente.start(obj_jugador.tiempoConvaleciente, obj_jugador.Convaleciente_01, 1);	
				
		obj_jugador.vida -= Reg.danioEnemigoBola;
		trace("vida2 " + obj_jugador.vida);
		
		}
		private function ContactoEye_player(obj_jugador:Personaje, obj_eye:EnemigoBola_01){
		//danio jugador
		//muerte eye
			trace("contacto con masa eye");
			//obj_eye.MuerteBola_01();
		obj_jugador.convaleciente = true;
		obj_jugador.timerConvaleciente.start(obj_jugador.tiempoConvaleciente, obj_jugador.Convaleciente_01, 1);	
		
		obj_jugador.vida -= Reg.danioEnemigoBola;
		trace("vida2 " + obj_jugador.vida);
			
		}
		
		private function ContactoBalasTorreta_player(obj_player:Personaje, objbala:Disparo){
		trace("contacto torreta");
			//danio jugador
		obj_player.convaleciente = true;	
		obj_player.timerConvaleciente.start(obj_player.tiempoConvaleciente, obj_player.Convaleciente_01, 1);	
		
			
		obj_player.vida -= Reg.danioBalaTorreta;
		
		objbala.kill();
		
		trace("vida player "+obj_player.vida);
		
			
		}
		
		
		private function ContactoBalas_saltarin_jugador(obj_jugador:Personaje, objBalaSaltarin:Disparo){
			trace("saltarin");
	//danio jugador		
	obj_jugador.convaleciente = true;		
	obj_jugador.timerConvaleciente.start(obj_jugador.tiempoConvaleciente, obj_jugador.Convaleciente_01, 1);	
			
	
		obj_jugador.vida -= Reg.danioBala_saltarin;
		
		
		objBalaSaltarin.kill();	
		
		trace("vida player "+obj_jugador.vida);
		
		}
		private function Contacto_saltarin_jugador(obj_jugador:Personaje,obj_saltarin:EnemigoSaltarin){
		//danio jugador
		//muerte saltarin
			trace("contacto saltarin");
			obj_jugador.convaleciente = true;
			obj_jugador.timerConvaleciente.start(obj_jugador.tiempoConvaleciente, obj_jugador.Convaleciente_01, 1);	
				
			
			obj_jugador.vida-= Reg.danio_saltarin;
		
			trace("vida player "+obj_jugador.vida);
		
		}
		//*******contacto boss-player
		
		private function Contacto_balas_boss_player(obj_jugador:Personaje,objJefe:Boss){
		trace("contacto boss jefe");	
		//danio jugador 
		obj_jugador.convaleciente = true;
		obj_jugador.timerConvaleciente.start(obj_jugador.tiempoConvaleciente, obj_jugador.Convaleciente_01, 1);
		obj_jugador.vida -= Reg.danioBalasBoss;
			trace("vida player "+obj_jugador.vida);
		
		}
		private function ContactoJefe_player(obj_jugador:Personaje,objJefe:Boss){
			trace("contacto masas player jugador");
		obj_jugador.convaleciente = true;
		obj_jugador.timerConvaleciente.start(obj_jugador.tiempoConvaleciente, obj_jugador.Convaleciente_01, 1);
		obj_jugador.vida -= Reg.danioBalasBoss;
			trace("vida player "+obj_jugador.vida);
		
		}
		//******************************level****************************
//muertes
		public function MuerteEntidad_pajaro(obj:EnemigoPajaro){
			
		obj.kill();
			
		if(finalLevel){
			obj.muerte = true;
		
			}
		
		}
		public function MuerteBalasEye(obj:Disparo){
			obj.destroy();
			
		}
		public function MuerteBalasTorreta(obj:Disparo){
			obj.destroy();
		}
		
		
		
		
		public function MuerteEntidad_eye(obj:EnemigoBola_01){
			
		
				obj.kill();
			if (finalLevel){
					obj.grupoBalas.forEachAlive(MuerteBalasEye, false);
				obj.muerteBola = true;
			}
		
		
			
		}
			public function MuerteEntidadTorreta(obj:EnemigoTorreta){
		
			obj.kill();
		if (finalLevel){
			obj.grupoBalas.forEachAlive(MuerteBalasTorreta, false);
			obj.muerteTorreta = true;
		}
		
		
		}
		public function MuerteEntidadSaltarin(obj:EnemigoSaltarin){
			
			obj.kill();
		if(finalLevel){
			obj.muerteSaltarin = true;
		}
			
		}
		public function MuerteEntidadTrampaElectrica(obj:Level_trampaElectrica){
			
				obj.kill();
			if(finalLevel){
				obj.DestruirTelectrica();
				
			
				
			}
		}
		public function MuerteEntidadKactus(obj:TrampaLevel_cactus){
			obj.kill();
			
			if(finalLevel){
				obj.MuerteCactus_01();
				
			}
		}
		
		//despertar
		public function DespiertaEntidad_pajaro(obj:EnemigoPajaro){
			if(!obj.muerte&&obj.x<=distanciaSpawnEnemys){
//			trace("entidad despiesrta " + obj.x);
				obj.revive();		
		
			}
		}
		
		public function DespiertaEntidad_Eye(obj:EnemigoBola_01){
			if (!obj.muerteBola && obj.x <= distanciaSpawnEnemys){
				//trace("entidad ojo");
				obj.revive();
			
				obj.timer_fire_01.start(4, obj.CicloDisparo, 3);//4 segundos /metodo/3 ciclos
				
			}
			
		}
	
		public function DespiertaEntidad_torreta(obj:EnemigoTorreta){
			if(!obj.muerteTorreta&&obj.x<=distanciaSpawnEnemys){
//			trace("entidad despiesrta " + obj.x);
				obj.revive();		
				obj.timer_fire_01.start(Reg.fireRateTorreta, obj.cicloDisparo, 0);//para q n me dispare antes
			}
		
		}
		
		
		public function DespiertaEntidadSaltarin(obj:EnemigoSaltarin){
			if(!obj.muerteSaltarin&&obj.x<=distanciaSpawnEnemys){
//			trace("entidad despiesrta " + obj.x);
				obj.revive();		
			
			//	obj.timeActivacion.start(o.tiem   , Activacion_01, 1);
			obj.timeActivacion.start(obj.tiempoActivo, obj.Activacion_01);//se activa disparo en clase enemigo saltarin
			
			}
		
		}
		
		
		
		public function DespiertaEntidad_trampaElectrica(obj:Level_trampaElectrica){
			if (!obj.muerteTrampaElectrica && obj.x <= distanciaSpawnEnemys){
			
				obj.revive();
				
			}
			
		}
		public function DespiertaEntidadKactus(obj:TrampaLevel_cactus){
			if (!obj.muerteKactus && obj.x <= distanciaSpawnEnemys){
			
				obj.revive();
				
			}
			
		}
		
		public function CondicionFinalLevel(){
			if(finalLevel==false){
		
					if (player_1.x > posicionFinalLevel){
						
						finalLevel = true;
					trace("jefe fuera los demas");
						Boss_1.revive();
						Boss_1.timeActivacion_boss.start(Boss_1.tiempoActivo_boss, Boss_1.Activacion_boss, 1);
						MuerteEntidades();
						
				
						
				
					}
				}
		}
		
		public function MuerteEntidades(){
			grupo_enemigo_pajaro.forEachAlive(MuerteEntidad_pajaro, false);
		grupo_enemigo_one_eye.forEachAlive(MuerteEntidad_eye, false);
		grupo_enemigo_torreta.forEachAlive(MuerteEntidadTorreta, false);
		grupo_enemigo_saltarin.forEachAlive(MuerteEntidadSaltarin, false);
		grupoTrampa_electrica.forEachAlive(MuerteEntidadTrampaElectrica, false);
		grupoTrampaKactus.forEachAlive(MuerteEntidadKactus, false);
		
		}
		private function FinDerrota_01(t:FlxTimer){
			
			Sys.exit(0);
		}
		private function Finvictoria_01(t:FlxTimer){
			Sys.exit(0);
		}
		
}