function onBeatHit()
    if curBeat == 184 then
        playAnim('dad', 'singDOWN-alt')
        setProperty('dad.stunned', true)
    elseif curBeat == 194 then
        setProperty('dad.stunned', false)
	elseif curBeat == 445 then
		for i = 0, 7 do
            noteTweenAlpha('fadeout'..i, i, 0, 0.5, 'linear')
        end
		triggerEvent('Camera Follow Pos', 700, 500)
		doTweenZoom('zoomIn', 'camGame', 1, 0.25, 'circInOut')
	elseif curBeat == 448 then
		for i = 0, 7 do
            noteTweenAlpha('fadein'..i, i, 1, 0.25, 'linear')
        end
		doTweenZoom('zoomOut', 'camGame', 0.75, 0.5, 'circInOut')
		triggerEvent('Camera Follow Pos')
    elseif curBeat == 572 then
        playAnim('gf', 'catch', true)
        setProperty('gf.stunned', true)
        for i = 0, 7 do
            noteTweenAlpha('fadeout'..i, i, 0, 2, 'linear')
        end
        triggerEvent('Camera Follow Pos', 700, 500)
		doTweenZoom('zoomIn', 'camGame', 1, 0.25, 'circInOut')
    elseif curBeat == 576 then
		playAnim('gf', 'end', true)
	end
end
