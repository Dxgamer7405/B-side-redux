function onCreate()
	makeLuaSprite('wall', 'week1/wall', -600, -300);
	makeLuaSprite('floor', 'week1/floor', -650, 600);

	if not lowQuality then
		makeLuaSprite('curtains', 'week1/curtains', -400, -400);
		makeLuaSprite('lights', 'week1/lights', -250, -150);
		--makeLuaSprite('lightBeams', 'week1/lightBeams', 33, -5);
	end

	addLuaSprite('wall', false);
	addLuaSprite('floor', false);
	addLuaSprite('curtains', true);
	addLuaSprite('lights', true);
	--addLuaSprite('lightBeams', true);

	setScrollFactor('wall', 1, 1);
	setScrollFactor('floor', 1, 1);
	setScrollFactor('curtains', 1.3, 1.3);
	setScrollFactor('lights', 1.1, 1.1);
	--setScrollFactor('lightBeams', 1, 1);

	scaleObject('curtains', 0.9, 0.9);
	scaleObject('floor', 1.1, 1.1);

end
