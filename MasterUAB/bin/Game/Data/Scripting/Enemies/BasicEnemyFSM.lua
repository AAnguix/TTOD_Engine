--Idle_State
function OnEnter_Idle_BasicEnemy(Enemy)
	Enemy:ResetTime()
	g_LogManager:Log(Enemy.m_RObject:GetName().." enters idle")	
end

function OnUpdate_Idle_BasicEnemy(Enemy, ElapsedTime)
	local l_AnimatorController = Enemy.m_RObject:GetAnimatorController()
	
	if Enemy:IsPlayerInsideVisionRange(GetPlayer():GetPosition()) then   
		l_AnimatorController:SetBool("IsPlayerInsideVisionRange", true)  --LLeva a MoveToAttack_State
	else
		Enemy:AddTime(ElapsedTime)
	end
	
	if Enemy.m_ElapsedTime > Enemy.m_DelayToPatrol then
		l_AnimatorController:SetBool("DelayToPatrol", true)
	end
end

function OnExit_Idle_BasicEnemy(Enemy)
	g_LogManager:Log(Enemy.m_RObject:GetName().." exits idle")	
end


--Patrol_State
function OnEnter_Patrol_BasicEnemy(Enemy)
	g_LogManager:Log(Enemy.m_RObject:GetName().." enters Patrol")
	Enemy:ResetTime()
end

function OnUpdate_Patrol_BasicEnemy(Enemy, ElapsedTime)
	Enemy:AddTime(ElapsedTime)
	Enemy:FollowTriangleWayPoints(ElapsedTime)
	local l_AnimatorController = Enemy.m_RObject:GetAnimatorController()
	if Enemy:IsPlayerInsideVisionRange(GetPlayer():GetPosition()) then   
		l_AnimatorController:SetBool("IsPlayerInsideVisionRange", true)
	end
end

function OnExit_Patrol_BasicEnemy(Enemy)
	g_LogManager:Log(Enemy.m_RObject:GetName().." exits Patrol")		
end


--MoveToAttack_State
function OnEnter_MoveToAttack_BasicEnemy(Enemy)
	Enemy:ResetTime()
	g_LogManager:Log(Enemy.m_RObject:GetName().." enters MoveToAttack")
end

function OnUpdate_MoveToAttack_BasicEnemy(Enemy, ElapsedTime)
	Enemy:AddTime(ElapsedTime)
	local l_AnimatorController = Enemy.m_RObject:GetAnimatorController()
	local l_PlayerPos = GetPlayer():GetPosition()
	local l_Pos = Enemy.m_RObject:GetPosition()
	if Enemy:IsPlayerInsideVisionRange(l_PlayerPos) then   
		if CTTODMathUtils.PointInsideCircle(l_PlayerPos, l_Pos, Enemy.m_AttackRange) then
			l_AnimatorController:SetBool("AttackPlayer",true)
		else
			Enemy:MoveToPlayerNearestPoint(l_PlayerPos)
		end
	else
		l_AnimatorController:SetBool("IsPlayerInsideVisionRange", false) --Goes to Idle
	end
end

function OnExit_MoveToAttack_BasicEnemy(Enemy)
	g_LogManager:Log(Enemy.m_RObject:GetName().." exits MoveToAttack")	
end

--Attack_State
function OnEnter_Attack_BasicEnemy(Enemy)
	Enemy:ResetTime()
	--g_LogManager:Log(Enemy.m_RObject:GetName().." enters Attack")	
end

function OnUpdate_Attack_BasicEnemy(Enemy, ElapsedTime)
	
end

function OnExit_Attack_BasicEnemy(Enemy)
	--g_LogManager:Log(Enemy.m_RObject:GetName().." exits Attack")	
end
