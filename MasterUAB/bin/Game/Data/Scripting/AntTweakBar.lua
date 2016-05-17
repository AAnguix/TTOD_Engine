function AddBackButton()
	CEngine.GetSingleton():GetDebugHelper():RegisterButton("..","BackButtonPressed()")
end

function BackButtonPressed()
	CEngine.GetSingleton():GetDebugHelper():RemoveBar()
	CEngine.GetSingleton():GetDebugHelper():ResetButtons()
	InitializeDebugBar()
end

function ClickOnElement(NewBarName)
	CEngine.GetSingleton():GetDebugHelper():RemoveBar()
	CEngine.GetSingleton():GetDebugHelper():ResetButtons()
	CEngine.GetSingleton():GetDebugHelper():CreateBar(NewBarName)
	AddBackButton()
end

function InitializeDebugBar()
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	l_DebugHelper:CreateBar("Debug Bar")
	l_DebugHelper:RegisterButton("[1]Scene","ReloadScene()")
	l_DebugHelper:RegisterButton("[2]Effects","OpenEffects()")
	-- l_DebugHelper:RegisterButton("[3]ROTechniques","OpenRenderableObjectTechniques()")
	--l_DebugHelper:RegisterButton("[4]Materials","OpenMaterials()")
	l_DebugHelper:RegisterButton("[3]AnimatedModels","OpenAnimatedModels()")
	l_DebugHelper:RegisterButton("[4]StaticMeshes","OpenStaticMeshes()")
	l_DebugHelper:RegisterButton("[5]Layers","OpenLayers()")
	l_DebugHelper:RegisterButton("[6]Lights","OpenLights()")
	-- l_DebugHelper:RegisterButton("[9]Commands","OpenSceneRendererCommands()")
	l_DebugHelper:RegisterButton("[7]Materials","OpenMaterials()")
	l_DebugHelper:RegisterButton("[8]Commands","ReloadSceneRendererCommands()")
	l_DebugHelper:RegisterButton("[9]GUI","ReloadGUI()")
	l_DebugHelper:RegisterButton("Particles","OpenParticles()")
	l_DebugHelper:RegisterButton("Cameras","ReloadCameras()")
end

function OpenEffects()
	ClickOnElement("Effects")
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_Effects=CEngine.GetSingleton():GetEffectManager():GetLUAEffects()
	for l_Effect in l_Effects do
		l_DebugHelper:RegisterButton(l_Effect:GetName(),"ReloadEffectTechnique('"..l_Effect:GetName().."')")
	end
end

function OpenRenderableObjectTechniques()
	ClickOnElement("ROTechniques")
end

function OpenMaterials()
	ClickOnElement("Materials")
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_Materials=CEngine.GetSingleton():GetMaterialManager():GetLUAMaterials()
	for l_Material in l_Materials do
		l_DebugHelper:RegisterButton(l_Material:GetName(),"OpenMaterial('"..l_Material:GetName().."')")
	end
end

function OpenMaterial(MaterialName)
	ClickOnElement(MaterialName)
	local l_Material = CEngine.GetSingleton():GetMaterialManager():GetResource(MaterialName)
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_Parameters = l_Material:GetParameters()
	for l_Param in l_Parameters do
		if l_Param:GetMaterialType() == CMaterialParameter.float then
			l_DebugHelper:RegisterFloatParameter(l_Param:GetName(),l_Param:GetValueLuaAddress(),l_Param:GetDescription())
		elseif l_Param:GetMaterialType() == CMaterialParameter.vect2f then 
			l_DebugHelper:RegisterVect2fParameter(l_Param:GetName(),l_Param:GetValueLuaAddress(),l_Param:GetDescription())
		elseif l_Param:GetMaterialType() == CMaterialParameter.vect3f then 
			l_DebugHelper:RegisterVect3fParameter(l_Param:GetName(),l_Param:GetValueLuaAddress(),l_Param:GetDescription())
		elseif l_Param:GetMaterialType() == CMaterialParameter.vect4f then 
			l_DebugHelper:RegisterVect4fParameter(l_Param:GetName(),l_Param:GetValueLuaAddress(),l_Param:GetDescription())
		end
	end
end

function OpenAnimatedModels()
	ClickOnElement("Animated Models")
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_Models=CEngine.GetSingleton():GetAnimatedModelManager():GetLUAAnimatedModels()
	for l_Model in l_Models do
		l_DebugHelper:RegisterButton(l_Model:GetName(),"")
	end
end

function OpenStaticMeshes()
	ClickOnElement("Static Meshes")
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_SMeshes=CEngine.GetSingleton():GetStaticMeshManager():GetLUAStaticMeshes()
	for l_SMesh in l_SMeshes do
		l_DebugHelper:RegisterButton(l_SMesh:GetName(),"")
	end
end

function OpenLayers()
	ClickOnElement("Layers")
	--CEngine.GetSingleton():GetDebugHelper():RegisterButton("Reload All","ReloadLayers()")
	local l_LayerManager=CEngine.GetSingleton():GetLayerManager()
	local l_ROManagers = l_LayerManager:GetResourcesVector():size()
	for i=0,l_ROManagers-1 do
		local l_ROMan=l_LayerManager:GetResourceById(i)
		AddROManagerButton(l_ROMan)
	end
end

function AddROManagerButton(ROManager)
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	l_DebugHelper:RegisterButton(ROManager:GetName(),"OpenRenderableObjectManager('"..ROManager:GetName().."')")
end

function OpenRenderableObjectManager(ROManagerName)
	ClickOnElement(ROManagerName)
	CEngine.GetSingleton():GetDebugHelper():RegisterButton("Reload","ReloadRenderableObjectManager('"..ROManagerName.."')")
	local l_ROManager=CEngine.GetSingleton():GetLayerManager():GetResource(ROManagerName)	
	local l_RObjects = l_ROManager:GetResourcesVector():size()
	for i=0,l_RObjects-1 do
		local l_RObject=l_ROManager:GetResourceById(i)
		AddRenderableObjectButton(l_RObject)
	end
end

function AddRenderableObjectButton(RenderableObject)
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_Name = RenderableObject:GetName()
	l_DebugHelper:RegisterButton(l_Name,"ReloadRenderableObject()")
end

function ReloadRenderableObjectManager(Name)
	--CEngine.GetSingleton():GetLayerManager():GetResource(Name):Reload()
end

function ReloadRenderableObject()

end

 function OpenLights()
	ClickOnElement("Lights")
	local l_LightManager=CEngine.GetSingleton():GetLightManager()
	local l_Lights = l_LightManager:GetResourcesVector():size()
	for i=0,l_Lights-1 do
		local l_Light=l_LightManager:GetResourceById(i)
		AddLightButton(l_Light)
	end
	
	CEngine.GetSingleton():GetDebugHelper():RegisterFloatParameter("Fog Start", l_LightManager:GetFogStartAddress(),"min=0.0 max=100.0 step=0.01")
	CEngine.GetSingleton():GetDebugHelper():RegisterFloatParameter("Fog End", l_LightManager:GetFogEndAddress(),"min=0.0 max=100.0 step=0.01")
	CEngine.GetSingleton():GetDebugHelper():RegisterFloatParameter("Density", l_LightManager:GetFogDensityAddress(),"min=0.0 max=0.5 step=0.001")
	--CEngine.GetSingleton():GetDebugHelper():RegisterVect4fParameter("Fog parameters", l_LightManager:GetFogParametersAddress(),"")
	CEngine.GetSingleton():GetDebugHelper():RegisterVect4fParameter("Fog color", l_LightManager:GetFogColorAddress(),"")
	
 end
 
 function OpenSceneRendererCommands()
	ClickOnElement("Commands")
 end
 
function AddLightParameters(LightName)
	ClickOnElement(LightName)
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	local l_Light=CEngine.GetSingleton():GetLightManager():GetResource(LightName)

	l_DebugHelper:RegisterBoolParameter("Active", l_Light:GetActiveAddress(), "")
	l_DebugHelper:RegisterFloatParameter("Intensity", l_Light:GetIntensityAddress(), "min=0.0 max=10.0 step=0.01") --"step=0.1 precision=1")
	l_DebugHelper:RegisterPositionOrientationParameter("Pos", l_Light:GetPositionAddress(), "")
	l_DebugHelper:RegisterColorParameter("Color", l_Light:GetColorAddress(), "")
	l_DebugHelper:RegisterFloatParameter("Start Attenuation", l_Light:GetStartRangeAttenuationAddress(), "")
	l_DebugHelper:RegisterFloatParameter("End Attenuation", l_Light:GetEndRangeAttenuationAddress(), "")
	
	if l_Light:get_type() == CLight.directional then
		l_DebugHelper:RegisterVect3fParameter("Direction", l_Light:GetDirectionAddress(),"")
	end
	
	if l_Light:get_type() == CLight.spot then
		l_DebugHelper:RegisterFloatParameter("Angle", l_Light:GetAngleAddress(),"")
		l_DebugHelper:RegisterFloatParameter("FallOff", l_Light:GetFallOffAddress(),"")
	end
end

function AddLightButton(Light)
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	l_DebugHelper:RegisterButton(Light:GetName(),"AddLightParameters('"..Light:GetName().."')")
end

function OpenParticles()
	ClickOnElement("Particles")
	local l_ParticleManager=CEngine.GetSingleton():GetLayerManager():GetResource("particles")
	local l_Particles = l_ParticleManager:GetResourcesVector():size()
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	
	for i=0,l_Particles-1 do
		local l_Particle=l_ParticleManager:GetResourceById(i)
		l_DebugHelper:RegisterButton(l_Particle:GetName(),"OpenParticle('"..l_Particle:GetName().."')")
	end
end

function OpenParticle(ParticleName)
	ClickOnElement(ParticleName)
	local l_ParticleSystem = CEngine.GetSingleton():GetLayerManager():GetResource("particles"):GetResource(ParticleName)
	local l_DebugHelper=CEngine.GetSingleton():GetDebugHelper()
	
	l_DebugHelper:RegisterVect3fParameter("EmissionBoxHalfSize",l_ParticleSystem:GetEmissionBoxHalfSizeLuaAddress(),"")
	l_DebugHelper:RegisterFloatParameter("Yaw",l_ParticleSystem:GetYawLuaAddress(),"min=0.0 max=3.14 step=0.01")
	l_DebugHelper:RegisterFloatParameter("Pitch",l_ParticleSystem:GetPitchLuaAddress(),"min=0.0 max=3.14 step=0.01")
	l_DebugHelper:RegisterFloatParameter("Roll",l_ParticleSystem:GetRollLuaAddress(),"min=0.0 max=3.14 step=0.01")
	
	local l_Type = l_ParticleSystem:GetType()
	
	l_DebugHelper:RegisterInt32Parameter("Num.Frames",l_Type:GetNumFramesLuaAddress(),"min=0 max=100 step=1")
	l_DebugHelper:RegisterFloatParameter("Time/frame",l_Type:GetTimePerFrameLuaAddress(),"min=0.0 max=5.0 step=0.01")
	l_DebugHelper:RegisterBoolParameter("Loop",l_Type:GetLoopLuaAddress(),"")
	l_DebugHelper:RegisterBoolParameter("Emit absolute",l_Type:GetEmitAbsoluteLuaAddress(),"")
	
	l_DebugHelper:RegisterFloatParameter("Starting direction angle",l_Type:GetStartingDirectionAngleLuaAddress(),"min=0 max=100 step=1")
	l_DebugHelper:RegisterFloatParameter("Starting acceleration angle ",l_Type:GetStartingAccelerationAngleLuaAddress(),"min=0 max=100 step=1")
	l_DebugHelper:RegisterVect2fParameter("Size",l_Type:GetSizeLuaAddress(),"")
	
	l_DebugHelper:RegisterVect2fParameter("Emit rate",l_ParticleSystem:GetType():GetEmitRateLuaAddress(),"")
	l_DebugHelper:RegisterVect2fParameter("Awake time",l_ParticleSystem:GetType():GetAwakeTimeLuaAddress(),"")
	l_DebugHelper:RegisterVect2fParameter("Sleep time",l_ParticleSystem:GetType():GetSleepTimeLuaAddress(),"")
	l_DebugHelper:RegisterVect2fParameter("Life",l_ParticleSystem:GetType():GetLifeLuaAddress(),"")
	
	l_DebugHelper:RegisterVect2fParameter("Starting angle",l_ParticleSystem:GetType():GetStartingAngleLuaAddress(),"")
	l_DebugHelper:RegisterVect2fParameter("Starting angular speed",l_ParticleSystem:GetType():GetStartingAngularSpeedLuaAddress(),"")
	l_DebugHelper:RegisterVect2fParameter("Angular acceleration",l_ParticleSystem:GetType():GetAngularAccelerationLuaAddress(),"")
	
	l_DebugHelper:RegisterVect3fParameter("Starting speed 1",l_ParticleSystem:GetType():GetStartingSpeed1LuaAddress(),"")
	l_DebugHelper:RegisterVect3fParameter("Starting speed 2",l_ParticleSystem:GetType():GetStartingSpeed2LuaAddress(),"")
	l_DebugHelper:RegisterVect3fParameter("Starting Acceleration 1",l_ParticleSystem:GetType():GetStartingAcceleration1LuaAddress(),"")
	l_DebugHelper:RegisterVect3fParameter("Starting Acceleration 2",l_ParticleSystem:GetType():GetStartingAcceleration2LuaAddress(),"")
	l_DebugHelper:RegisterColorParameter("Color1",l_ParticleSystem:GetType():GetColor1LuaAddress(),"")
	l_DebugHelper:RegisterColorParameter("Color2",l_ParticleSystem:GetType():GetColor2LuaAddress(),"")

	l_DebugHelper:RegisterButton("Save","WriteParticleInfoToXml('"..l_Type:GetName().."')")
	--l_DebugHelper:RegisterButton("Save","WriteParticleInfoToXml("l_Type")")
end

function WriteParticleInfoToXml(Type)
	
	--local Filename = "Data\Level"..g_CurrentLevel.."\particles_systems.xml"
	local l_Type = g_ParticleSystemManager:GetResource(Type)
	local Filename = "Data/Level1/particles_systems.xml"
	local l_XMLTreeNode=CXMLTreeNode()
	local l_Loaded=l_XMLTreeNode:LoadFile(Filename)
	if l_Loaded then
		for i=0, l_XMLTreeNode:GetNumChildren() do
			local l_Element=l_XMLTreeNode:GetChild(i)
			if l_Element:GetName() == "particle_system" and l_Element:GetPszProperty("name", "", false) == Type then
				g_LogManager:Log("siiiiii")
				l_Element:WriteIntProperty("num_frames", l_Type:GetNumFramesLuaAddress())
				l_Element:WriteBoolProperty("loop_frames", l_Type:GetLoopLuaAddress())
			end
		end
	else
		print("File '"..Filename.."'not correctly loaded")
	end
end