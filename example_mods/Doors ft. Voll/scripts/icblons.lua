local icos = {'', ''}
local testr = {'boyfriend', 'dad'}

local rayman = {x = 0,  y = 0} -- icons origins I suppose
local origins = {x = 150,  y = 0}

local bopEvery = 1
local hpBounce = false

-- gf section stuff
local toReplace = ''
local thre = 0
gfP1 = false
gfP2 = false

threePieceIcon1 = false
threePieceIcon2 = false

function onCreatePost()
    icos[1] = getProperty('boyfriend.healthIcon')
    icos[2] = getProperty('dad.healthIcon')

    screenCenter('healthBar', 'x')
    screenCenter('healthBarBG', 'x')

    setObjectOrder('healthBar', getObjectOrder('strumLineNotes') - 1)
    setObjectOrder('healthBarBG', getObjectOrder('strumLineNotes') - 2)

    setProperty('iconP1.visible', false) -- because iconP1 killed my grandmother, ok?!
    setProperty('iconP2.visible', false)

    for i = 1, #icos do -- assumes that the icon is named "icon-bf" none of that "bf-icon" or "bf" shit
        makeAnimatedLuaSprite('iconP'..i..'F', nil, getProperty('healthBar.x'), getProperty('iconP'..i..'.y'))
        loadGraphic('iconP'..i..'F', 'icons/icon-' .. icos[i])

        if getProperty('iconP'..i..'F.width') >= 450 then -- if you like that sort of thing I guess
            loadGraphic('iconP'..i..'F', 'icons/icon-' .. icos[i], getProperty('iconP'..i..'F.width') / 3)
            _G['threePieceIcon'..i] = true 
            addAnimation('iconP'..i..'F', 'icons/icon-' .. icos[i], {0, 1, 2}, 0, true)
        else
            loadGraphic('iconP'..i..'F', 'icons/icon-' .. icos[i], getProperty('iconP'..i..'F.width') / 2)
            addAnimation('iconP'..i..'F', 'icons/icon-' .. icos[i], {0, 1}, 0, true)
        end

        setObjectCamera('iconP'..i..'F', 'hud')

        if stringEndsWith(icos[i], '-pixel') then setProperty('iconP'..i..'F.antialiasing', false) end
        setObjectOrder('iconP'..i..'F', getObjectOrder('healthBar') + i)

        if i == 1 then setProperty('iconP'..i..'F.flipX', true) end

        addLuaSprite('iconP'..i..'F')
    end
end

local shit = {'iconP1F', 'iconP2F', 'healthBar', 'healthBarBG'}
function onUpdate(elapsed)
    pbr = getProperty('playbackRate')
    for i = 1, #shit do    
        setProperty(shit[i]..'.scale.x', math.lerp(1, getProperty(shit[i]..'.scale.x'), fakeBoundTo(1 - (elapsed * 9 * pbr), 0, 1)))
        setProperty(shit[i]..'.scale.y', math.lerp(1, getProperty(shit[i]..'.scale.y'), fakeBoundTo(1 - (elapsed * 9 * pbr), 0, 1)))
        --doTweenX('iconPFX'..i, 'iconP'..i..'F.scale', 1, 0.2, 'elasticOut') -- fuck
        --doTweenY('iconPFY'..i, 'iconP'..i..'F.scale', 1, 0.2, 'elasticOut')
    end

    if curStep <= 1 then
        setProperty('iconP1F.x', getProperty('iconP1.x'))
        setProperty('iconP2F.x', getProperty('iconP2.x'))
    end

    doTweenX('weee1', 'iconP1F', getProperty('iconP1.x'), 0.1, 'linear')
    doTweenX('weee2', 'iconP2F', getProperty('iconP2.x'), 0.1, 'linear')

    setProperty('iconP1F.y', getProperty('iconP1.y'))
    setProperty('iconP2F.y', getProperty('iconP2.y'))

    hp = getProperty('healthBar.percent')
    
    if hp > 80 then
        setProperty('iconP2F.animation.curAnim.curFrame', 1)
    elseif hp < 20 and threePieceIcon2 then
        setProperty('iconP2F.animation.curAnim.curFrame', 2)
    else
        setProperty('iconP2F.animation.curAnim.curFrame', 0)
    end

    if hp > 80 and threePieceIcon1 then
        setProperty('iconP1F.animation.curAnim.curFrame', 2)
    elseif hp < 20 then
        setProperty('iconP1F.animation.curAnim.curFrame', 1)
    else
        setProperty('iconP1F.animation.curAnim.curFrame', 0)
    end
end

function onUpdatePost() end

function onBeatHit()
    scaleObject('iconP1', 1, 1) -- the scaling messes with the icon's x
    scaleObject('iconP2', 1, 1)

    if hpBounce and curBeat % bopEvery == 0 then
        setProperty('healthBar.scale.x', 1.1)
        setProperty('healthBar.scale.y', 1.1)

        setProperty('healthBarBG.scale.x', 1.1)
        setProperty('healthBarBG.scale.y', 1.1)
    end

    if curBeat % bopEvery == 0 then
        setProperty('iconP1F.origin.x', rayman.x)
        setProperty('iconP1F.origin.y', rayman.y)
        setProperty('iconP1F.scale.x', 1.2)
        setProperty('iconP1F.scale.y', 1.2)
  
        setProperty('iconP2F.origin.x', origins.x)
        setProperty('iconP2F.origin.y', origins.y)
        setProperty('iconP2F.scale.x', 1.2)
        setProperty('iconP2F.scale.y', 1.2)
    end
end

function onStepHit() -- only checks every step if there is a new character icon
    check = {getProperty('boyfriend.healthIcon'), getProperty('dad.healthIcon')}
    if not gfSection then
        for i = 1, #icos do
            if check[i] ~= icos[i] then
                if check[i] == testr[i]..'.healthIcon' then table.remove(icos, i) return 
                else icos[i] = check[i] end

                loadGraphic('iconP'..i..'F', 'icons/icon-' .. icos[i])

                if getProperty('iconP'..i..'F.width') >= 450 then
                    loadGraphic('iconP'..i..'F', 'icons/icon-' .. icos[i], getProperty('iconP'..i..'F.width') / 3)
                    _G['threePieceIcon'..i] = true 
                    addAnimation('iconP'..i..'F', 'icons/icon-' .. icos[i], {0, 1, 2}, 0, true)
                else
                    loadGraphic('iconP'..i..'F', 'icons/icon-' .. icos[i], getProperty('iconP'..i..'F.width') / 2)
                    _G['threePieceIcon'..i] = false 
                    addAnimation('iconP'..i..'F', 'icons/icon-' .. icos[i], {0, 1}, 0, true)
                end

                if stringEndsWith(icos[i], '-pixel') then setProperty('iconP'..i..'F.antialiasing', false) end
                setObjectOrder('iconP'..i..'F', getObjectOrder('healthBar') + i)

                if i == 1 then setProperty('iconP'..i..'F.flipX', true) end

                _G['gfP'..i] = false
            end
        end
    end    
end

function onSectionHit()
    if gfSection and not (gfP1 or gfP2) then
        if mustHitSection then
            toReplace = 'iconP1F'
            thre = 1
        else
            toReplace = 'iconP2F'
            thre = 2
        end

        if getProperty('gf.healthIcon') == 'gf.healthIcon' then 
            return -- maybe? idk
        else
            icos[thre] = getProperty('gf.healthIcon')
        end

        loadGraphic(toReplace, 'icons/icon-' .. icos[thre])

        if getProperty(toReplace..'.width') >= 450 then
            loadGraphic(toReplace, 'icons/icon-' .. icos[thre], getProperty(toReplace..'.width') / 3)
            _G['threePieceIcon'..thre] = true 
            addAnimation(toReplace, 'icons/icon-' .. icos[thre], {0, 1, 2}, 0, true)
        else
            loadGraphic(toReplace, 'icons/icon-' .. icos[thre], getProperty(toReplace..'.width') / 2)
            _G['threePieceIcon'..thre] = false 
            addAnimation(toReplace, 'icons/icon-' .. icos[thre], {0, 1}, 0, true)
        end

        if stringEndsWith(icos[thre], '-pixel') then setProperty(toReplace ..'.antialiasing', false) end
        setObjectOrder(toReplace, getObjectOrder('healthBar') + thre)

        setProperty(toReplace ..'.flipX', mustHitSection)

        setProperty(toReplace..'.origin.x', (thre == 1 and rayman.x or origins.x))
        setProperty(toReplace..'.origin.y', (thre == 1 and rayman.y or origins.y))

        _G['gfP'..thre] = true
    end
end

function math.lerp(a, b, t)
    return (b - a) * t + a;
end

function fakeBoundTo(v, min, max)
    return math.max(min, math.min(max, v))
end