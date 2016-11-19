--Crush Card Virus (GM)
function c33559908.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c33559908.condition)
	e1:SetTarget(c33559908.target)
	e1:SetOperation(c33559908.activate)
	c:RegisterEffect(e1)
end
function c33559908.cfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_FIRE) and c:IsAttackBelow(1000) and c:GetPreviousControler()==tp
end
function c33559908.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33559908.cfilter,1,nil,tp)
end
function c33559908.tgfilter(c)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:IsDestructable()
end
function c33559908.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c33559908.tgfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c33559908.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttackAbove(1500)
end
function c33559908.activate(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,0,LOCATION_MZONE+LOCATION_HAND+LOCATION_DECK)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
		local dg=conf:Filter(c33559908.filter,nil)
		Duel.Destroy(dg,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
		dg:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTargetRange(1,1)
		e1:SetLabelObject(dg)
		e1:SetCondition(aux.nfbdncon)
		e1:SetTarget(c33559908.sumlimit)
		e1:SetReset(RESET_EVENT+0x17a0000)
		e:GetHandler():RegisterEffect(e1)
	end
end
function c33559908.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return e:GetLabelObject():IsContains(c) and c:IsLocation(LOCATION_GRAVE)
end