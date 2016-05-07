float3 Normal2Texture(float3 Normal)
{
	return Normal*0.5+0.5;
}

float3 Texture2Normal(float3 Color)
{
	return (Color-0.5)*2;
}

float4 Red()
{
	return float4(1.0,0.0,0.0,1.0);
}


float4 Green()
{
	return float4(0.0,1.0,0.0,1.0);
}


float4 Blue()
{
	return float4(0.0,0.0,1.0,1.0);
}

float3 GetPositionFromZDepthViewInViewCoordinates(float ZDepthView, float2 UV, float4x4 InverseProjection)
{
	// Get the depth value for this pixel
	// Get x/w and y/w from the viewport position
	float x = UV.x * 2 - 1;
	float y = (1 - UV.y) * 2 - 1;
	float4 l_ProjectedPos = float4(x, y, ZDepthView, 1.0);
	// Transform by the inverse projection matrix
	float4 l_PositionVS = mul(l_ProjectedPos, InverseProjection);
	// Divide by w to get the view-space position
	return l_PositionVS.xyz / l_PositionVS.w;
}

float3 GetPositionFromZDepthView(float ZDepthView, float2 UV, float4x4 InverseView, float4x4 InverseProjection)
{
	float3 l_PositionView=GetPositionFromZDepthViewInViewCoordinates(ZDepthView, UV, InverseProjection);
	return mul(float4(l_PositionView,1.0), InverseView).xyz;
}