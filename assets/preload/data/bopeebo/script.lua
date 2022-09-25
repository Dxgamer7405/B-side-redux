function onStepHit()
	if curStep == 68 then
		doTweenZoom('zoomIn', 'camGame', '1.2', '6.75', 'linear')
	elseif curStep == 128 then
		doTweenZoom('zoomOut', 'camGame', '0.8', '0.5', 'circInOut')
	end
end