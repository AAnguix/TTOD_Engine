#include "EnableAdditiveAlphaBlendSceneRendererCommand.h"
#include "Render\RenderManager.h"
#include "Engine.h"

CEnableAdditiveAlphaBlendSceneRendererCommand::CEnableAdditiveAlphaBlendSceneRendererCommand(CXMLTreeNode &TreeNode) : CSceneRendererCommand(TreeNode)
{
	D3D11_BLEND_DESC l_AlphablendDesc;
	ZeroMemory(&l_AlphablendDesc, sizeof(D3D11_BLEND_DESC));
	l_AlphablendDesc.RenderTarget[0].BlendEnable = true;
	l_AlphablendDesc.RenderTarget[0].SrcBlend = D3D11_BLEND_SRC_ALPHA;
	l_AlphablendDesc.RenderTarget[0].DestBlend = D3D11_BLEND_INV_SRC_ALPHA;
	l_AlphablendDesc.RenderTarget[0].BlendOp = D3D11_BLEND_OP_ADD;
	l_AlphablendDesc.RenderTarget[0].SrcBlendAlpha = D3D11_BLEND_SRC_ALPHA;
	l_AlphablendDesc.RenderTarget[0].DestBlendAlpha = D3D11_BLEND_INV_SRC_ALPHA;
	l_AlphablendDesc.RenderTarget[0].BlendOpAlpha = D3D11_BLEND_OP_ADD;
	l_AlphablendDesc.RenderTarget[0].RenderTargetWriteMask = D3D11_COLOR_WRITE_ENABLE_ALL;

	if (FAILED(CEngine::GetSingleton().GetRenderManager()->GetContextManager()->GetDevice()->CreateBlendState(&l_AlphablendDesc, &m_AdditiveAlphaBlendState)))
		return;
}

void CEnableAdditiveAlphaBlendSceneRendererCommand::Execute(CRenderManager &RenderManager)
{
	RenderManager.GetContextManager()->SetAlphaBlendState(m_AdditiveAlphaBlendState);
	RenderManager.GetContextManager()->EnableAlphaBlendState();
}

