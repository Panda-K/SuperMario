//
//  Player.m
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize topLeftFixture = p_topLeftFixture, topRightFixture = p_topRightFixture;
@synthesize isMarioStop = isMarioStop_;
@synthesize isMarioMovingRight = isMarioMovingRight_;
@synthesize isMoveFast = isMoveFast_;
@synthesize isJump = isJump_;
@synthesize readyToJump = readyToJump_;
@synthesize isFaceWall = isFaceWall_;
@synthesize stkHead = stkHead_;

- (id)init {
    if (self = [super init]) {
        type_ = kGameObjectPlayer;
        isMarioStop_ = YES;
        isMarioMovingRight_ = YES;
        isMoveFast_ = NO;
        isJump_ = NO;
        readyToJump_ = NO;
        isFaceWall_ = NO;
    }
    return self;
}

- (void)moveRight {
    b2Vec2 impulse = b2Vec2(10.0, 0.0);
    p_body->ApplyLinearImpulse(impulse, p_body->GetWorldCenter());
    
}

- (void)moveLeft {
    b2Vec2 impulse = b2Vec2(-10.0, 0.0);
    p_body->ApplyLinearImpulse(impulse, p_body->GetWorldCenter());
}

- (void)jump {
    b2Vec2 impulse = b2Vec2(0.0, 15.0);
    p_body->ApplyLinearImpulse(impulse, p_body->GetWorldCenter());
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
    b2Vec2 vec[] = {b2Vec2(-size.x/2/PTM_RATIO, -size.y/2/PTM_RATIO), 
                    b2Vec2(size.x/2/PTM_RATIO, -size.y/2/PTM_RATIO), 
                    b2Vec2(size.x/2/PTM_RATIO, -size.y*3.0/8/PTM_RATIO), 
                    b2Vec2(size.x/4/PTM_RATIO, size.y/2/PTM_RATIO), 
                    b2Vec2(-size.x/4/PTM_RATIO, size.y/2/PTM_RATIO), 
                    b2Vec2(-size.x/2/PTM_RATIO, -size.y*3.0/8/PTM_RATIO)};
    polygonShape.Set(vec, 6);
    b2FixtureDef fixtureDef1;
    fixtureDef1.shape = &polygonShape;
    fixtureDef1.density = dens;
    fixtureDef1.friction = f;
    fixtureDef1.restitution = rest;
    p_polygonFixture = p_body->CreateFixture(&fixtureDef1);
    
    b2EdgeShape edgeShape;
    edgeShape.Set(b2Vec2((size.x/2-0.3)/PTM_RATIO, -size.y/2/PTM_RATIO), 
                  b2Vec2((-size.x/2+0.3)/PTM_RATIO, -size.y/2/PTM_RATIO));
    p_bottomFixture = p_body->CreateFixture(&edgeShape, 0);
    
    b2EdgeShape edgeShape1;
    edgeShape1.Set(b2Vec2(size.x/2/PTM_RATIO, (-size.y*3.0/8-0.5)/PTM_RATIO), 
                   b2Vec2(size.x/2/PTM_RATIO, (-size.y/2+0.5)/PTM_RATIO));
    
    p_rightFixture = p_body->CreateFixture(&edgeShape1, 0);
    p_rightFixture->SetRestitution(0);
    p_rightFixture->SetFriction(0);
    
    b2EdgeShape edgeShape2;
    edgeShape2.Set(b2Vec2(-size.x/2/PTM_RATIO, (-size.y*3.0/8-0.5)/PTM_RATIO), 
                   b2Vec2(-size.x/2/PTM_RATIO, (-size.y/2+0.5)/PTM_RATIO));
    
    p_leftFixture = p_body->CreateFixture(&edgeShape2, 0);
    p_leftFixture->SetRestitution(0);
    p_leftFixture->SetFriction(0);
    
    b2EdgeShape edgeShape3;
    edgeShape3.Set(b2Vec2((size.x/4+0.2)/PTM_RATIO, (size.y/2-3.5*0.2*size.y/size.x)/PTM_RATIO), 
                   b2Vec2((size.x/2-0.2)/PTM_RATIO, (-size.y*3.0/8+3.5*0.2*size.y/size.x)/PTM_RATIO));
    p_topRightFixture = p_body->CreateFixture(&edgeShape3, 0);
    p_topRightFixture->SetRestitution(0);
    p_topRightFixture->SetFriction(0);
    
    b2EdgeShape edgeShape4;
    edgeShape4.Set(b2Vec2((-size.x/4-0.2)/PTM_RATIO, (size.y/2-3.5*0.2*size.y/size.x)/PTM_RATIO), 
                   b2Vec2((-size.x/2+0.2)/PTM_RATIO, (-size.y*3.0/8+3.5*0.2*size.y/size.x)/PTM_RATIO));
    p_topLeftFixture = p_body->CreateFixture(&edgeShape4, 0);
    p_topLeftFixture->SetRestitution(0);
    p_topLeftFixture->SetFriction(0);
}

@end
