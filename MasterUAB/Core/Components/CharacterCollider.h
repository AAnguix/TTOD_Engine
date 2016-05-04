#ifndef _CHARACTERCOLLIDER_H
#define _CHARACTERCOLLIDER_H

#include "Components\Component.h"

class CCharacterCollider : public CComponent
{

public:
	CCharacterCollider(const std::string &Name, CRenderableObject *Owner);
	virtual ~CCharacterCollider();
	virtual void Update(float ElapsedTime);
	virtual void Render(CRenderManager &RenderManager);
	virtual void RenderDebug(CRenderManager &RenderManager);
	static CCharacterCollider * AddCharacterCollider(const std::string &Name, CRenderableObject *Owner);
};

#endif