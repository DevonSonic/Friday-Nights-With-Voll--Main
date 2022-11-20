function onStepHit()--Bueno Este Metodo Es Muy Facil De Usar, Lo Cree En Un Dia Si me Dan creditos Por El Esfuerso Se Los Agradeceria Soy Perez Sen Y Eso Es TODO :)
	if curStep == 15 then

		makeLuaSprite('box', 'box', 433, -1200);
		scaleObject('box', 1.0, 1.0);
		addLuaSprite('box', false);
		setProperty('box.visible', true);
		setObjectCamera('box', 'other');

		makeLuaText('Text', "PORT A PC/ANDROID Nickobelit y BF Myt\n\nVídeos a Sprites por Pérez-Sen y BF Myt\n\nOptimización\nNickobelit\n\nÍconos\nB_Fezz\n\nLua de Créditos\nPérez-Sen", 299, 487, -800); 
		setTextSize('Text', 29);
		setObjectCamera('Text', 'other');
		addLuaText('Text', true);

		doTweenY("box", "box", -0, 0.5, "linear")	
		doTweenY("Text", "Text", 200, 0.6, "linear")	
	end
	if curStep == 74 then
		doTweenY("box", "box", -780, 0.5, "linear")	
		doTweenY("Text", "Text", -420, 0.4, "linear")
	end
	end

--Aqui Nickobelit, el que lo Borre es fan de Kunno xd (Tabien espantaviejas 3000 ya sabes no borramos tus creditos xdxd pd: soy alexwey ekizde)
--el que notó que esto va más rápido es un capo..
--(y me lo dice en comentarios xd)