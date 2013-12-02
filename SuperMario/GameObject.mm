//
//  GameObject.m
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize type = type_;
@synthesize body = p_body;
@synthesize bottomFixture = p_bottomFixture;
@synthesize rightFixture = p_rightFixture;
@synthesize leftFixture = p_leftFixture;
@synthesize topFixture = p_topFixture;
@synthesize polygonFixture = p_polygonFixture;
@synthesize size = p_size;

-(id)init {
    if (self = [super init]) {
        type_ = kGameObjectNone;
        p_body = NULL;
        p_bottomFixture = NULL;
        p_topFixture = NULL;
    }
    return self;
}

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
          
    b2PolygonShape polygonShape;
    b2Vec2 vec[] = {b2Vec2((-size.x/4)/PTM_RATIO, -size.y/2/PTM_RATIO), 
                    b2Vec2((size.x/4)/PTM_RATIO, -size.y/2/PTM_RATIO), 
                    b2Vec2((size.x/2)/PTM_RATIO, size.y*3.0/8/PTM_RATIO), 
                    b2Vec2((size.x/2)/PTM_RATIO, size.y/2/PTM_RATIO), 
                    b2Vec2(-size.x/2/PTM_RATIO, size.y/2/PTM_RATIO), 
                    b2Vec2(-size.x/2/PTM_RATIO, size.y*3.0/8/PTM_RATIO)};
    polygonShape.Set(vec, 6);
    b2FixtureDef fixtureDef1;
    fixtureDef1.shape = &polygonShape;
    fixtureDef1.density = dens;
    fixtureDef1.friction = f;
    fixtureDef1.restitution = rest;
    p_polygonFixture = p_body->CreateFixture(&fixtureDef1);
    
    b2EdgeShape edgeShape;
    edgeShape.Set(b2Vec2((size.x/4-0.5)/PTM_RATIO, -size.y/2/PTM_RATIO), 
                  b2Vec2((-size.x/4+0.5)/PTM_RATIO, -size.y/2/PTM_RATIO));
    p_bottomFixture = p_body->CreateFixture(&edgeShape, 0);
    p_bottomFixture->SetFriction(0);
    
    b2EdgeShape edgeShape3;
    edgeShape3.Set(b2Vec2((-size.x/2)/PTM_RATIO, (size.y/2)/PTM_RATIO), 
                   b2Vec2((size.x/2)/PTM_RATIO, (size.y/2)/PTM_RATIO));
    p_topFixture = p_body->CreateFixture(&edgeShape3, 0);
}

- (void)dealloc {
    [super dealloc];
}

@end
