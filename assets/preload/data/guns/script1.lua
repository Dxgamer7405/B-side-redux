local BatAllowed = false
local biker1 = alive
local biker2 = alive

function onCreatePost()
	BatAllowed = false
	makeAnimatedLuaSprite('secondbiker', 'week7/bgGuys', getProperty('gf.x') -100, 275);
	setProperty('secondbiker.flipX', true)
	addAnimationByPrefix('secondbiker', '0idle', '0idle instance', 24, false)
	addAnimationByPrefix('secondbiker', '1idle', '1idle instance', 24, false)
	addAnimationByPrefix('secondbiker', '2idle', '2idle instance', 24, false)
	addAnimationByPrefix('secondbiker', '3idle', '3idle instance', 24, false)
	addAnimationByPrefix('secondbiker', 'hit', 'die instance', 24, false)
	addAnimationByPrefix('secondbiker', 'appear', 'jumpHigh instance', 24, false)
	addLuaSprite('secondbiker', false);

	makeAnimatedLuaSprite('firstbiker', 'week7/bgGuys', getProperty('gf.x') +450, 300);
	addAnimationByPrefix('firstbiker', '0idle', '0idle instance', 24, false)
	addAnimationByPrefix('firstbiker', '1idle', '1idle instance', 24, false)
	addAnimationByPrefix('firstbiker', '2idle', '2idle instance', 24, false)
	addAnimationByPrefix('firstbiker', '3idle', '3idle instance', 24, false)
	addAnimationByPrefix('firstbiker', 'hit', 'die instance', 24, false)
	addAnimationByPrefix('firstbiker', 'appear', 'jumpHigh instance', 24, false)
	addLuaSprite('firstbiker', false);

	setProperty('firstbiker.visible', false)
	setProperty('secondbiker.visible', false)
end

function BikerRecalc()
	bikeridle = getRandomInt(0, 3)
	bikeridle2 = getRandomInt(0, 3)
end

function onBeatHit()
	if curBeat % 2 == 0 and getRandomBool(25) and BatAllowed then
		Biker()

	elseif curBeat == 16 then
		BikerRecalc()
		for i = 0, 7 do
            noteTweenAlpha('fadeout'..i, i, 0, 0.5, 'linear')
        end
		triggerEvent('Camera Follow Pos', 700, 500)
		doTweenZoom('zoomIn', 'camGame', 1, 0.25, 'circInOut')
		setProperty('firstbiker.visible', true)
		setProperty('secondbiker.visible', true)
		runTimer('respawnbiker1', 0.1)
		runTimer('respawnbiker2', 0.1)
		setProperty('gf.stunned', true)
		playAnim('gf', 'scared', true)

	elseif curBeat == 18 then
		playAnim('gf', 'getBat', true)

	elseif curBeat == 24 then
		biker2 = dead
		playAnim('gf', 'swingLEFT', true)
		playAnim('secondbiker', 'hit', false)

	elseif curBeat == 26 then
		biker1 = dead
		playAnim('gf', 'swingRIGHT', true)
		playAnim('firstbiker', 'hit', false)
		for i = 0, 7 do
            noteTweenAlpha('fadeout'..i, i, 1, 0.25, 'linear')
        end
		doTweenZoom('zoomOut', 'camGame', 0.75, 0.5, 'circInOut')
		triggerEvent('Camera Follow Pos')

	elseif curBeat == 28 then
		BatAllowed = true
		triggerEvent('Alt Idle Animation', 'gf', 'Bat') 
		setProperty('gf.stunned', false)
		runTimer('respawnbiker1', 1)
		runTimer('respawnbiker2', 3)
	end

	if getProperty('firstbiker.animation.curAnim.name') ~= 'hit' and getProperty('firstbiker.animation.curAnim.name') ~= 'appear' then
		playAnim('firstbiker', bikeridle..'idle', true)
	end

	if getProperty('secondbiker.animation.curAnim.name') ~= 'hit' and getProperty('secondbiker.animation.curAnim.name') ~= 'appear' then
		playAnim('secondbiker', bikeridle2..'idle', true)
	end
end

function Biker()
	if (biker1 == alive and biker2 == alive) or (biker1 == alive and biker2 == dead) or (biker1 == dead and biker2 == alive) then
	-- LETS ROCK
		if getProperty('firstbiker.animation.curAnim.name') ~= 'hit' then
			biker1 = dead
			playAnim('gf', 'swingRIGHT', false)
			playAnim('firstbiker', 'hit', false);
			runTimer('respawnbiker1', getRandomInt(5, 15))
		elseif getProperty('secondbiker.animation.curAnim.name') ~= 'hit' then
			biker2 = dead
			playAnim('gf', 'swingLEFT', false)
			playAnim('secondbiker', 'hit', false);
     		runTimer('respawnbiker2', getRandomInt(5, 15))
		end
	end
end

function onTimerCompleted(n)
	if n == 'respawnbiker2' then
		BikerRecalc()
		playAnim('secondbiker', 'appear', false)
		runTimer('idlereturn2', 0.25)

	elseif n == 'idlereturn2' then
		playAnim('secondbiker', bikeridle2..'idle')
		runTimer('biker2alive', 0.25)

	elseif n == 'biker2alive' then
		biker2 = alive

	elseif n == 'respawnbiker1' then
		BikerRecalc()
		playAnim('firstbiker', 'appear', false)
		runTimer('idlereturn1', 0.25)

	elseif n == 'idlereturn1' then
		playAnim('firstbiker', bikeridle..'idle')
		runTimer('biker1alive', 0.25)

	elseif n == 'biker1alive' then
		biker1 = alive
		
  	end
end