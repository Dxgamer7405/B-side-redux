function onCreate()

--regular--
	makeLuaSprite('bg', 'week2/bg', 0, 0)
	scaleObject('bg', 2, 2)
	setLuaSpriteScrollFactor('bge', 1, 1)
	addLuaSprite('bg', false)

	makeAnimatedLuaSprite('cabinets', 'week2/cabinets', 470, 770)
	scaleObject('cabinets', 1, 1)
	setLuaSpriteScrollFactor('cabinets', 1, 1)
	addAnimationByPrefix('cabinets', 'bop', 'cabinets', 24, true)
	addLuaSprite('cabinets', false)
--other--
	makeLuaSprite('bl', '', 0, 0)
	makeGraphic('bl', 1280, 720, '000000')
	scaleObject('bl', 1, 1)
	setLuaSpriteScrollFactor('bl', 1, 1)
	setObjectCamera('bl', 'other')
	setProperty('bl.alpha', 0)
	addLuaSprite('bl', false)
end