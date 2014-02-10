//
//  Player.m
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "AppDelegate.h"

@implementation Player
@synthesize topLeftFixture = p_topLeftFixture, topRightFixture = p_topRightFixture;
@synthesize isMarioStop = isMarioStop_;
@synthesize isMarioMovingRight = isMarioMovingRight_;
@synthesize isMoveFast = isMoveFast_;
@synthesize isJump = isJump_, isFall = isFall_;
@synthesize readyToJump = readyToJump_;
@synthesize isFaceWall = isFaceWall_;
@synthesize isFireing = isFireing_;
@synthesize isCollidable = isCollidable_;
@synthesize stkHead = stkHead_;
@synthesize marioStatus = p_mario_status;
@synthesize isInvincible = isInvincible_;

+ (id) spriteWithSpriteFrame:(CCSpriteFrame *)spriteFrame {
    Player *mario = nil;
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    if ((mario = [super spriteWithSpriteFrame:spriteFrame])) {
        mario.type = kGameObjectPlayer;
        mario.isMarioStop = YES;
        mario.isMarioMovingRight = YES;
        mario.isMoveFast = NO;
        mario.isJump = NO;
        mario.isFall = NO;
        mario.readyToJump = NO;
        mario.isFaceWall = NO;
        mario.isCollidable = YES;
        mario.isInvincible = NO;
        mario.marioStatus = delegate.marioStatus;
    }
    
    return mario;
}

- (void) moveRight {
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

- (void) setFilter:(b2Fixture *)fixture {
    b2Filter filter;
    filter.categoryBits = 0x0002;
    filter.maskBits = 0x0005;
    fixture->SetFilterData(filter);
}

- (void) generateFixtureOfSize:(CGPoint)size 
                       density:(float)dens 
                      friction:(float)f 
                   restitution:(long)rest 
{
    if (p_mario_status == kMarioSmall) {
        b2PolygonShape polygonShape;
        b2Vec2 vec[] = {b2Vec2(-size.x/2/PTM_RATIO, -size.y/2/PTM_RATIO), 
            b2Vec2(size.x/2/PTM_RATIO, -size.y/2/PTM_RATIO), 
            b2Vec2(size.x/2/PTM_RATIO, -size.y*3.0/8/PTM_RATIO), 
            b2Vec2(size.x*3.0/8/PTM_RATIO, size.y/2/PTM_RATIO), 
            b2Vec2(-size.x*3.0/8/PTM_RATIO, size.y/2/PTM_RATIO), 
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
        edgeShape3.Set(b2Vec2((size.x*3.0/8)/PTM_RATIO, (size.y/2)/PTM_RATIO), 
                       b2Vec2((size.x/2-0.2)/PTM_RATIO, (-size.y*3.0/8+7*0.2*size.y/size.x)/PTM_RATIO));
        p_topRightFixture = p_body->CreateFixture(&edgeShape3, 0);
        p_topRightFixture->SetRestitution(0);
        p_topRightFixture->SetFriction(0);
        
        b2EdgeShape edgeShape4;
        edgeShape4.Set(b2Vec2((-size.x*3.0/8)/PTM_RATIO, (size.y/2)/PTM_RATIO), 
                       b2Vec2((-size.x/2+0.2)/PTM_RATIO, (-size.y*3.0/8+7*0.2*size.y/size.x)/PTM_RATIO));
        p_topLeftFixture = p_body->CreateFixture(&edgeShape4, 0);
        p_topLeftFixture->SetRestitution(0);
        p_topLeftFixture->SetFriction(0);
        
        [self setFilter:p_polygonFixture];
        [self setFilter:p_bottomFixture];
        [self setFilter:p_rightFixture];
        [self setFilter:p_leftFixture];
        [self setFilter:p_topLeftFixture];
        [self setFilter:p_topRightFixture];
    }
    
    if (p_mario_status == kMarioLarge || p_mario_status == kMarioCanFire) {
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
        
        [self setFilter:p_polygonFixture];
        [self setFilter:p_bottomFixture];
        [self setFilter:p_rightFixture];
        [self setFilter:p_leftFixture];
        [self setFilter:p_topLeftFixture];
        [self setFilter:p_topRightFixture];
    }
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
    
    [self generateFixtureOfSize:size density:dens friction:f restitution:rest];
}

- (void) resizeBodyAtPositon:(CGPoint)pos 
                        size:(CGPoint)size
                    friction:(float)f 
                     density:(float)dens 
                 restitution:(float)rest
{
    p_body->DestroyFixture(p_polygonFixture);
    p_body->DestroyFixture(p_bottomFixture);
    p_body->DestroyFixture(p_rightFixture);
    p_body->DestroyFixture(p_leftFixture);
    p_body->DestroyFixture(p_topRightFixture);
    p_body->DestroyFixture(p_topLeftFixture);
    
    p_body->SetTransform(b2Vec2(pos.x/PTM_RATIO, pos.y/PTM_RATIO), p_body->GetAngle());
    [self generateFixtureOfSize:size density:dens friction:f restitution:rest];
}

@end
