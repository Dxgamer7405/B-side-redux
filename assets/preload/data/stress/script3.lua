h = 0

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'GF Sing' or gfSection then
		cancelTimer('holdTimer'..h,0.35,1)
		h = h + 1
		runTimer('holdTimer'..h,0.35,1)
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if gfSection then
		cancelTimer('holdTimer'..h,0.35,1)
		h = h + 1
		runTimer('holdTimer'..h,0.35,1)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'holdTimer'..h then
		playAnim('gf', 'shoot1-loop', true);
	end
end

function onBeatHit()
	if getProperty('gf.animation.curAnim.name') == 'Idle' and curBeat % 2 == 1 then
		playAnim('gf','idle',true)
	end
	if curBeat == 352 or curBeat == 353 or curBeat == 354 then
		cancelTimer('holdTimer'..h)
	end
end