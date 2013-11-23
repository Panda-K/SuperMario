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
@synthesize topFixture = p_topFixture;

-(id)init {
    if (self = [super init]) {
        type_ = kGameObjectNone;
    }
    return self;
}

- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(long)f 
                  density:(long)dens 
              restitution:(long)rest 
                    boxId:(int)id {
                        
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
    p_body->CreateFixture(&fixtureDef1);
    
    b2EdgeShape edgeShape;
    edgeShape.Set(b2Vec2((-size.x/2)/PTM_RATIO, (-size.y/2)/PTM_RATIO), 
                  b2Vec2((size.x/2)/PTM_RATIO, (-size.y/2)/PTM_RATIO));

    p_bottomFixture = p_body->CreateFixture(&edgeShape, 0);
                        
//    edgeShape.Set(b2Vec2((pos.x-size.x/2)/PTM_RATIO, (pos.y+size.y/2)/PTM_RATIO), 
//                  b2Vec2((pos.x+size.x/2)/PTM_RATIO, (pos.y+size.y/2)/PTM_RATIO));
//
//    p_topFixture = p_body->CreateFixture(&edgeShape, 0);
}

- (void)dealloc {
    [super dealloc];
}

@end
