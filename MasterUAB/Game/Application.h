#ifndef _APPLICATION_H
#define _APPLICATION_H

#include "HelperTypes.h"
#include "Render\RenderManager.h"
#include "AntTweakBar.h"
#include <string>

class CContextManager;

class CApplication
{

public:
	CApplication(CContextManager *_ContextManager);
	~CApplication();

	void SwitchCamera();

	void Update(float ElapsedTime);
	void Render();
	void Initialize(HWND Hwnd);

private:
	//CSphericalCameraController m_SphericalCamera;
	//CFPSCameraController m_FPSCamera;

	CCamera m_Camera;
	int m_CurrentCamera;
	CContextManager *m_ContextManager;
	CColor m_BackgroundColor;
	CRenderManager m_RenderManager;
};

#endif