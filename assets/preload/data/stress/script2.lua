function onCreate()
	makeChart()
end

chartTankman = {}
maxTankman = 0;

function makeChart()
	len = getProperty('eventNotes.length')-1;
	for i = 0, len do
		if getPropertyFromGroup('eventNotes', i, 'event') == 'Tankman Note' then
			isRight = true;
			if getPropertyFromGroup('eventNotes', i, 'value1') == 'left' then
				isRight = false;
			end
			pushTankman({time = getPropertyFromGroup('eventNotes', i, 'strumTime'), right = isRight});
		end
	end
	
	for i = 0, len do
		if getPropertyFromGroup('eventNotes', len-i, 'event') == 'Tankman Note' then
			removeFromGroup('eventNotes', len-i);
		end
	end
end

function pushTankman(data)
	chartTankman[maxTankman] = data;
	maxTankman = maxTankman + 1;
end

readingChartNumber = 0;
spawnedChartTankman = {};

tankmenDisappeared = 0;
curTankman = 0;
curSpawnedTankman = 0;

curPicoNote = 0;

function onUpdatePost(elapsed)
	if getProperty('dad.curCharacter') == 'tankman' then
		if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
			setProperty('dad.holdTimer', 0); --Huh... Pretty Good!
		end
	end

	if readingChartNumber < maxTankman and getSongPosition() >= (chartTankman[readingChartNumber].time - 1500) then
		--debugPrint(chartTankman[readingChartNumber].time);
		makeTankman(chartTankman[readingChartNumber].right);
	end
	
	if curTankman < curSpawnedTankman and spawnedChartTankman[curTankman].time <= getSongPosition() then
		tag = 'tankmanRun'..curTankman;
		luaSpritePlayAnimation(tag, 'shot', true);
		if spawnedChartTankman[curTankman].right then
			animToPlay = 3;
			setProperty(tag..'.offset.x', 300);
			setProperty(tag..'.offset.y', 50);
		end
		curTankman = curTankman + 1;
	end

	if curPicoNote < maxTankman and chartTankman[curPicoNote].time <= getSongPosition() then
		animToPlay = 1;
		if chartTankman[curPicoNote].right then
			animToPlay = 3;
		end

		animToPlay = animToPlay + math.random(0, 1);
		playAnim('gf', 'shoot'..animToPlay, true);
		curPicoNote = curPicoNote + 1;
	end

	if curTankman < curSpawnedTankman then
		for i = curTankman, curSpawnedTankman-1 do
			tag = 'tankmanRun'..i;
			if getProperty(tag..'.animation.curAnim.name') == 'run' then
				speed = (getSongPosition() - spawnedChartTankman[i].time) * spawnedChartTankman[i].speed;
				if spawnedChartTankman[i].right then
					setProperty(tag..'.x', (0.02 * screenWidth - spawnedChartTankman[i].offset) + speed);
				else
					setProperty(tag..'.x', (0.74 * screenWidth + spawnedChartTankman[i].offset) - speed);
				end
			end
		end
	end

	if tankmenDisappeared < curTankman then
		for i = tankmenDisappeared, curTankman-1 do
			tag = 'tankmanRun'..i;
			if getProperty(tag..'.animation.curAnim.finished') then
				removeLuaSprite(tag);
				tankmenDisappeared = tankmenDisappeared + 1;
			end
		end
	end
	-- debugPrint(curTankman, ' ', curSpawnedTankman,' ', tankmenDisappeared);
end

function makeTankman(facingRight)
	chance = 24;
	if lowQuality then
		chance = 8;
	end

      math.randomseed(getSongPosition() / 100);
	if getRandomInt(0, 99) < chance then
		-- Prepare sprite
            if not inGameOver then
		tag = 'tankmanRun'..curSpawnedTankman;
		makeAnimatedLuaSprite(tag, 'week7/tankmanKilled1', 500, 200 + getRandomInt(50, 100));
		luaSpriteAddAnimationByPrefix(tag, 'run', 'tankman running', 24, true);
		luaSpriteAddAnimationByPrefix(tag, 'shot', 'John Shot '..getRandomInt(1, 2), 24, false);
		scaleObject(tag, 1, 1);
		
		-- Random animation frame
		prop = tag..'.animation.curAnim.curFrame';
		leng = getProperty(tag..'.animation.curAnim.frames.length');
		numGenerated = getRandomInt(0, leng - 1);
		setProperty(prop, numGenerated);
		setProperty(tag..'.flipX', facingRight);

		-- Set some properties
		spawnedChartTankman[curSpawnedTankman] = chartTankman[readingChartNumber];
		spawnedChartTankman[curSpawnedTankman].offset = getRandomInt(50, 200);
		spawnedChartTankman[curSpawnedTankman].speed = randomFloat(0.6, 1);

		-- Finally add sprite
		addLuaSprite(tag, false);
		setObjectOrder(tag, getObjectOrder('bikeGuyLeft') - 1);
		curSpawnedTankman = curSpawnedTankman + 1;
            end
	end
	readingChartNumber = readingChartNumber + 1
end

function randomFloat(lower, greater)
    return lower + getRandomFloat() * (greater - lower);
end