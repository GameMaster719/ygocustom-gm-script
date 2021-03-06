--Jellyfish (DOR)
--scripted by GameMaster (GM)
function c335599181.initial_effect(c)
--atk down thunder monsters
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(-500)
	e1:SetTarget(c335599181.tg)
	e1:SetCondition(c335599181.con)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end

function c335599181.tg(e,c)
    return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_THUNDER)
end


function c335599181.con(e)
	return e:GetHandler():IsDefensePos()
end