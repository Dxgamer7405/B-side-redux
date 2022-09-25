function onCreatePost()
	addHaxeLibrary('Paths')
	addHaxeLibrary('ColorSwap')
	addHaxeLibrary('BGSprite')
	addHaxeLibrary('Conductor')
	
	runHaxeCode([[
	fgGuys = new ColorSwap();
	ground = new ColorSwap();
	sky = new ColorSwap();
	{
		game.getLuaObject('fgGuys').shader = fgGuys.shader;
		game.getLuaObject('tankGround').shader = ground.shader;
		game.getLuaObject('tankSky').shader = sky.shader;

	}
				]])

	runHaxeCode([[
	sky.saturation += 0.1;
	ground.saturation += 0.25;
	ground.brightness -= 0.25;
	fgGuys.saturation += 0.25;
				]])
end