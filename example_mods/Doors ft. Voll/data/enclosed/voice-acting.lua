local seenDaEnd = false
function onCreate()

addLuaScript('dialogue')

end
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
	speak(count+1)
end

function onSkipDialogue(count)
	stopSound('sound')
	stopSound('sound1')
	stopSound('sound2')
	stopSound('sound3')
	stopSound('sound4')
end

function speak(shit)
	stopSound('sound')
	stopSound('sound1')
	stopSound('sound2')
	stopSound('sound3')
	stopSound('sound4')
	playSound('folder goes here/' ..shit,1,'your sound')
	playSound('folder goes here/' .. shit,1,'your sound1')
	playSound('folder goes here/' .. shit,1,'your sound2')
	playSound('folder goes here/' .. shit,1,'your sound4')-- you can add more here 
	playSound('folder goes here/' .. shit,1,'your sound3')--just to make this shit loud i don't feel like audio editing
end



function onEvent(n,v1,v2)

	if n == 'startDia' then
		
		speak(1)
	end

end