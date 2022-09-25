function onEvent()
	if n == spawnguys then
		makeAnimatedLuaSprite('bgGuys', 'week7/bgGuys', getProperty('gf.x') +50, 300);
		scaleObject('bgGuys', 1, 1);
		addLuaSprite('bgGuys', false);
		addAnimationByPrefix('bgGuys', 'jump', 'jumpHigh instance', 24, true);
		addAnimationByPrefix('bgGuys2', 'idle', '0idle instance', 24, true);

		makeAnimatedLuaSprite('bgGuys2', 'week7/bgGuys', getProperty('gf.x') -50, 300);
		setProperty('bgGuys2.flipX', true)
		scaleObject('bgGuys2', 1, 1);
		addLuaSprite('bgGuys2', false);
		addAnimationByPrefix('bgGuys2', 'jump', 'jumpLow instance', 24, true);
		addAnimationByPrefix('bgGuys2', 'idle', '1idle instance', 24, true);
	end
end