//
//  MoveRectObject.m
//  SuperMario
//
//  Created by jashon on 13-12-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MoveRectObject.h"

@implementation MoveRectObject
@synthesize isMoving = isMoving_;

- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(float)f 
                  density:(float)dens 
              restitution:(long)rest 
                    boxId:(int)id 
{
    b2BodyDef collideObjBodyDef;
    if (dy) {
        collideObjBodyDef.type = b2_dynamicBody;
    }
    collideObjBodyDef.position.Set(pos.x/PTM_RATIO, pos.y/PTM_RATIO);
    collideObjBodyDef.userData = self;
    collideObjBodyDef.fixedRotation = true;
    
    p_body = world->CreateBody(&collideObjBodyDef);
    
    b2PolygonShape rectShape;
    rectShape.SetAsBox(size.x/2/PTM_RATIO, size.y/2/PTM_RATIO);
    
    b2FixtureDef fixtureDef1;
    fixtureDef1.shape = &rectShape;
    fixtureDef1.density = dens;
    fixtureDef1.friction = f;
    fixtureDef1.restitution = rest;
    p_polygonFixture = p_body->CreateFixture(&fixtureDef1);
    
    b2EdgeShape edgeShape1;
    edgeShape1.Set(b2Vec2((size.x/2)/PTM_RATIO, (size.y/2-0.5)/PTM_RATIO), 
                   b2Vec2((size.x/2)/PTM_RATIO, (-size.y/2+0.5)/PTM_RATIO));
    p_rightFixture = p_body->CreateFixture(&edgeShape1, 0);
    p_rightFixture->SetFriction(0);
    p_rightFixture->SetRestitution(1);
    
    b2EdgeShape edgeShape2;
    edgeShape2.Set(b2Vec2((-size.x/2)/PTM_RATIO, (size.y/2-0.5)/PTM_RATIO), 
                   b2Vec2((-size.x/2)/PTM_RATIO, (-size.y/2+0.5)/PTM_RATIO));
    p_leftFixture = p_body->CreateFixture(&edgeShape2, 0);
    p_leftFixture->SetFriction(0);
    p_leftFixture->SetRestitution(1);
    
    b2EdgeShape edgeShape3;
    edgeShape3.Set(b2Vec2((size.x/2-0.5)/PTM_RATIO, (size.y/2)/PTM_RATIO), 
                   b2Vec2((-size.x/2+0.5)/PTM_RATIO, (size.y/2)/PTM_RATIO));
    p_topFixture = p_body->CreateFixture(&edgeShape3, 0);
    
    b2EdgeShape edgeShape4;
    edgeShape4.Set(b2Vec2((-size.x/2+0.5)/PTM_RATIO, -size.y/2/PTM_RATIO), 
                   b2Vec2((size.x/2-0.5)/PTM_RATIO, -size.y/2/PTM_RATIO));
    p_bottomFixture = p_body->CreateFixture(&edgeShape4, 0);
    p_bottomFixture->SetFriction(0);
    p_bottomFixture->SetRestitution(1);
}

- (void)dealloc {
    [super dealloc];
}

@end
