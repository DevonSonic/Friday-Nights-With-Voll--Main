function onCreate()
	-- background shit
	makeLuaSprite('doors', 'bg1', -500, -500);
	setScrollFactor('doors', 1, 1);

	addLuaSprite('doors', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end