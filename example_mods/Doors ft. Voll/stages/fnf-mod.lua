function onCreate()
	-- background shit
	makeLuaSprite('fnf', 'FNF-mod', -1800, -1000);
	setScrollFactor('fnf', 1, 1);

	addLuaSprite('fnf', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end