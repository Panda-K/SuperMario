//
//  MainGameLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "MainGameLayer.h"
#import "AppDelegate.h"

@implementation MainGameLayer
using namespace std;
@synthesize hud = hud_;

- (void) reset {

}

- (CCSpriteFrame *) getFrameByName: (NSString *)name {
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name];
    return frame;
}

- (id) getSpriteByName: (NSString *)name {
    GameObject *sprite = [GameObject spriteWithSpriteFrame:[self getFrameByName:name]];
    return sprite;
}

- (id) getFixedObjByName: (NSString *)name {
    PipeAndRock *sprite = [PipeAndRock spriteWithSpriteFrame:[self getFrameByName:name]];
    return sprite;
}

- (id) getPlayerByName: (NSString *)name {
    Player * player = [Player spriteWithSpriteFrame:[self getFrameByName:name]];
    return player;
}

- (id) createFrameActionByName:(NSString *)name frameNum:(int)num interval:(float)dt repeat:(int)times {
    NSMutableArray *frame = [NSMutableArray array];
    for (int i = 0; i < num; i++) {
        [frame addObject:[self getFrameByName:[NSString stringWithFormat:name, i+1]]];
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frame delay:dt];
    CCActionInterval *animate = [CCAnimate actionWithAnimation:animation];
    CCAction *repeat = nil;
    if (times <= 0) {
        repeat = [CCRepeatForever actionWithAction:animate];
    }
    else {
        repeat = [CCRepeat actionWithAction:animate times:times];
    }
    return repeat;
}

- (void) backToSelectScene {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate loadSelectScene];
}

- (void)generateAction {
    marios_runFastL = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    marios_runFastR = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    marios_runMediumL = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    marios_runMediumR = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    marios_runSlowL = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    marios_runSlowR = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    marios_standL = [[self getFrameByName:@"marios_standl.png"] retain];
    marios_standR = [[self getFrameByName:@"marios_standr.png"] retain];
    marios_stopL = [[self getFrameByName:@"marios_stopl.png"] retain];
    marios_stopR = [[self getFrameByName:@"marios_stopr.png"] retain];
    marios_jumpL = [[self getFrameByName:@"marios_jumpl.png"] retain];
    marios_jumpR = [[self getFrameByName:@"marios_jumpr.png"] retain];

    mariom_runFastL = [[self createFrameActionByName:@"mariom_walkl%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariom_runFastR = [[self createFrameActionByName:@"mariom_walkr%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariom_runMediumL = [[self createFrameActionByName:@"mariom_walkl%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariom_runMediumR = [[self createFrameActionByName:@"mariom_walkr%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariom_runSlowL = [[self createFrameActionByName:@"mariom_walkl%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    mariom_runSlowR = [[self createFrameActionByName:@"mariom_walkr%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    mariom_standL = [[self getFrameByName:@"mariom_standl.png"] retain];
    mariom_standR = [[self getFrameByName:@"mariom_standr.png"] retain];
    mariom_stopL = [[self getFrameByName:@"mariom_stopl.png"] retain];
    mariom_stopR = [[self getFrameByName:@"mariom_stopr.png"] retain];
    mariom_jumpL = [[self getFrameByName:@"mariom_jumpl.png"] retain];
    mariom_jumpR = [[self getFrameByName:@"mariom_jumpr.png"] retain];
    
    mariol_runFastL = [[self createFrameActionByName:@"mariol_walkl%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariol_runFastR = [[self createFrameActionByName:@"mariol_walkr%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariol_runMediumL = [[self createFrameActionByName:@"mariol_walkl%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariol_runMediumR = [[self createFrameActionByName:@"mariol_walkr%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariol_runSlowL = [[self createFrameActionByName:@"mariol_walkl%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    mariol_runSlowR = [[self createFrameActionByName:@"mariol_walkr%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    mariol_standL = [[self getFrameByName:@"mariol_standl.png"] retain];
    mariol_standR = [[self getFrameByName:@"mariol_standr.png"] retain];
    mariol_stopL = [[self getFrameByName:@"mariol_stopl.png"] retain];
    mariol_stopR = [[self getFrameByName:@"mariol_stopr.png"] retain];
    mariol_jumpL = [[self getFrameByName:@"mariol_jumpl.png"] retain];
    mariol_jumpR = [[self getFrameByName:@"mariol_jumpr.png"] retain];
    
    ironBrick_ = [[self getFrameByName:@"iron1.png"] retain];
    
    goldBrickFlash_ = [[self createFrameActionByName:@"goldBrick1_%d.png" frameNum:10 interval:0.1 repeat:0] retain];
    flowerFlash_ = [[self createFrameActionByName:@"flower%d.png" frameNum:4 interval:0.1 repeat:0] retain];
}

- (void) setViewPointCenter:(CGPoint)pos {
    int x = MAX(pos.x, winSize.width/2);
    int y = MAX(pos.y, winSize.height/2);
    x = MIN(x, tileMap_.mapSize.width*tileMap_.tileSize.width-winSize.width/2);
    y = MIN(y, tileMap_.mapSize.height*tileMap_.tileSize.height-winSize.height/2);
    CGPoint actualPos = ccp(x, y);
    CGPoint center = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(center, actualPos);
    CGPoint zero = ccp(0, 0);
    zero = [self convertToNodeSpace:zero];
    if (actualPos.x - zero.x < winSize.width/2) {
        return;
    }
    self.position = viewPoint;
}

- (void) drawCollideObject {
    CCTMXObjectGroup *objects = [tileMap_ objectGroupNamed:@"sprite"];
    NSMutableDictionary *objPoint;
    
    float x, y, w, h;
    for (objPoint in [objects objects]) {
        x = [[objPoint valueForKey:@"x"] intValue];
        y = [[objPoint valueForKey:@"y"] intValue];
        w = [[objPoint valueForKey:@"width"] intValue];
        h = [[objPoint valueForKey:@"height"] intValue];
        NSString *objType = [objPoint valueForKey:@"type"];
        CGPoint _point = ccp(x+w/2, y+h/2);
        CGPoint _size = ccp(w, h);
        
        GameObject *sprite = nil;
        BOOL isDynamic;
        
        if (objType && [objType compare:@"hero"] == NSOrderedSame) {
            if (mario_status == kMarioSmall) {
                _point = ccp(x, y+10.0);
                player_ = [self getPlayerByName:@"marios_standr.png"];
            }
            else if (mario_status == kMarioLarge) {
                player_ = [self getPlayerByName:@"mariom_standr.png"];
                _point = ccp(x+8.0, y+26.0);
                _size = ccp(16.0, 32.0);
            }
            else {
                player_ = [self getPlayerByName:@"mariol_standr.png"];
                _point = ccp(x+8.0, y+26.0);
                _size = ccp(16.0, 32.0);
            }
            player_.position = _point;
            player_.type = kGameObjectPlayer;
            [spriteSheet_ addChild:player_];
            [player_ createPhisicsBody:world_ 
                               postion:_point 
                                  size:_size 
                               dynamic:YES 
                              friction:1 
                               density:6.5 
                           restitution:0 
                                 boxId:-1];
        }
        else if (objType && [objType compare:@"ground"] == NSOrderedSame) {
            PipeAndRock *ground = [self getFixedObjByName:@"other.png"];
            ground.position = _point;
            ground.size = _size;
            ground.type = kGameObjectPlatform;
            [spriteSheet_ addChild:ground];
            [ground createPhisicsBody:world_ 
                            postion:_point 
                               size:_size 
                            dynamic:NO 
                           friction:1 
                            density:5.0 
                        restitution:0 
                              boxId:-1];
        }
        else if (objType && [objType compare:@"brick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"brick1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectBrick;
            [spriteSheet_ addChild:sprite];
        }
        else if (objType && [objType compare:@"goldBrick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"goldBrick1_1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectGoldBrick;
            [spriteSheet_ addChild:sprite];
            [sprite runAction:[[goldBrickFlash_ copy] autorelease]];
        }
        else if (objType && [objType compare:@"mushBrick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"goldBrick1_1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectMushBrick;
            [spriteSheet_ addChild:sprite z:2];
            [sprite runAction:[[goldBrickFlash_ copy] autorelease]];
        }
        else if (objType && [objType compare:@"pipe"] == NSOrderedSame) {
            PipeAndRock *pipe = [self getFixedObjByName:@"other.png"];
            pipe.position = _point;
            pipe.type = kGameObjectPipe;
            pipe.size = _size;
            [spriteSheet_ addChild:pipe z:2];
            [pipe createPhisicsBody:world_ 
                            postion:_point 
                               size:_size 
                            dynamic:NO 
                           friction:1 
                            density:0 
                        restitution:0 
                              boxId:-1];
        }
        else if (objType && [objType compare:@"rock"] == NSOrderedSame) {
            PipeAndRock *rock = [self getFixedObjByName:@"other.png"];
            rock.position = _point;
            rock.size = _size;
            rock.type = kGameObjectRock;
            [spriteSheet_ addChild:rock z:1];
            [rock createPhisicsBody:world_ 
                            postion:_point 
                               size:_size 
                            dynamic:NO 
                           friction:1 
                            density:0 
                        restitution:0 
                              boxId:-1];
        }
        
        if (sprite != nil) {
            sprite.size = _size;
            [sprite createPhisicsBody:world_ 
                              postion:_point 
                                 size:_size 
                              dynamic:isDynamic 
                             friction:1
                              density:5.0
                          restitution:0 
                                boxId:-1];
        }
    }
}

- (void) setPhysicsWorld {
    b2Vec2 gravity = b2Vec2(0.0, -30.0);
    world_ = new b2World(gravity);
    world_->SetAllowSleeping(YES);
    world_->SetContinuousPhysics(true);
    contactListener_ = new MarioContactListener();
    world_->SetContactListener(contactListener_);
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
    world_->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    m_debugDraw->SetFlags(flags);
}

//- (void) draw {
//    [super draw];
//    ccGLEnableVertexAttribs(kCCVertexAttrib_Position);
//    kmGLPushMatrix();
//    world_->DrawDebugData();
//    kmGLPopMatrix();
//}

- (void) brickRunPushUpAction: (GameObject *)obj height: (float)height {
    [obj runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(0, height)], 
                    [CCMoveTo actionWithDuration:0.1 position:ccp(obj.body->GetPosition().x*PTM_RATIO, 
                                                                  obj.body->GetPosition().y*PTM_RATIO)], 
                    nil]];
}

- (void) objRunDieAction:(GameObject *)obj toPos:(CGPoint)pos jumpHeight:(float)height {
    [obj runAction:[CCJumpTo actionWithDuration:1.0f position:pos height:height jumps:1]];
}

- (void) destroyBody: (vector<b2Body *> &)vector alsoSprite:(BOOL)value {
    std::vector<b2Body *>::iterator pos;
    for (pos = vector.begin(); pos != vector.end(); ++pos) {
        b2Body *body = *pos;
        if (body->GetUserData() != NULL && value == YES) {
            GameObject *sprite = (GameObject *) body->GetUserData();
            [self removeChild:sprite cleanup:YES];
        }
        world_->DestroyBody(body);
    }
}

- (void) smallBrickMoveAfterBigBrick: (GameObject *)obj1 {
    GameObject *smallBrick1 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick1.position = ccp(obj1.position.x-5, obj1.position.y+5);
    
    GameObject *smallBrick2 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick2.position = ccp(obj1.position.x+5, obj1.position.y+5);
    smallBrick2.flipX = YES;
    
    GameObject *smallBrick3 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick3.position = ccp(obj1.position.x-5, obj1.position.y-5);
    smallBrick3.flipY = YES;
    
    GameObject *smallBrick4 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick4.position = ccp(obj1.position.x+5, obj1.position.y-5);
    smallBrick4.flipX = YES;
    smallBrick4.flipY = YES;
    
    [spriteSheet_ addChild:smallBrick1];
    [spriteSheet_ addChild:smallBrick2];
    [spriteSheet_ addChild:smallBrick3];
    [spriteSheet_ addChild:smallBrick4];
    [self objRunDieAction:smallBrick1 toPos:ccp(obj1.position.x-20, -10) jumpHeight:20];
    [self objRunDieAction:smallBrick2 toPos:ccp(obj1.position.x+20, -10) jumpHeight:20];
    [self objRunDieAction:smallBrick3 toPos:ccp(obj1.position.x-20, -10) jumpHeight:15];
    [self objRunDieAction:smallBrick4 toPos:ccp(obj1.position.x+20, -10) jumpHeight:15];
}

- (void) updateOtherObjPosition {
    for (GameObject *obj in spriteSheet_.children) {
        if (obj.type == kGameObjectMushRoom && obj.body != NULL) {
            obj.position = ccp(obj.body->GetPosition().x*PTM_RATIO, 
                               obj.body->GetPosition().y*PTM_RATIO);
        }
    }
}

- (void) generateBodyOfSprite:(id)sender {
    PipeAndRock *obj = (PipeAndRock *)sender;
    
    if (obj.type == kGameObjectMushRoom) {
        [obj createPhisicsBody:world_ 
                       postion:obj.position 
                          size:ccp(obj.contentSize.width, obj.contentSize.height) 
                       dynamic:YES 
                      friction:0 
                       density:0 
                   restitution:0 
                         boxId:-1];
        obj.rightFixture->SetRestitution(1.0);
        obj.leftFixture->SetRestitution(1.0);
        obj.body->SetLinearVelocity(b2Vec2(2.0, 0));
    }
    
    if (obj.type == kGameObjectFlower) {
        [obj createPhisicsBody:world_ 
                       postion:obj.position 
                          size:ccp(obj.contentSize.width, obj.contentSize.height) 
                       dynamic:NO 
                      friction:0 
                       density:5 
                   restitution:0 
                         boxId:-1];
    }
}

- (void) coinBrickToIronBrick:(GameObject *)coinB {
    coinB.type = kGameObjectIronBrick;
    [coinB stopAllActions];
    [coinB setDisplayFrame:ironBrick_];
}

- (void) updateCollision {
    vector<b2Body *>toDestroy;
    vector<MyContact>::iterator pos;
    
    for (b2ContactEdge *ce = player_.body->GetContactList(); ce; ce = ce->next) {
        if (ce->contact->GetFixtureA() != player_.leftFixture && 
            ce->contact->GetFixtureA() != player_.rightFixture && 
            ce->contact->GetFixtureB() != player_.leftFixture && 
            ce->contact->GetFixtureB() != player_.rightFixture) {
            player_.isFaceWall = NO;
        }
    }
    
    int onGround = 0;
    for (pos = contactListener_->contacts_.begin(); 
         pos != contactListener_->contacts_.end(); 
         ++pos) {
        MyContact contact = *pos;
        
        b2Body *body1 = contact.fixtureA->GetBody();
        b2Body *body2 = contact.fixtureB->GetBody();
        
        GameObject *obj1 = (GameObject *)body1->GetUserData();
        GameObject *obj2 = (GameObject *)body2->GetUserData();
        
        //判断Mario是否站在地上或其他物体上,上升的过程中碰到底边时仍旧在跳跃的过程中
        if ((contact.fixtureA == player_.bottomFixture) || 
            (contact.fixtureB == player_.bottomFixture) || 
            (contact.fixtureA == player_.polygonFixture && 
             contact.fixtureB == obj2.topFixture && player_.body->GetLinearVelocity().y <= 0) || 
            (contact.fixtureB == player_.polygonFixture && 
             contact.fixtureA == obj1.topFixture && player_.body->GetLinearVelocity().y <= 0)) {
            player_.isJump = NO;
            pushUpTimes_ = 0;
            onGround++;
        }
        
        //判断Mario是否被阻挡
        if (contact.fixtureA == player_.leftFixture || 
            contact.fixtureA == player_.rightFixture || 
            contact.fixtureB == player_.leftFixture ||
            contact.fixtureB == player_.rightFixture) {
            
            player_.isFaceWall = YES;

        }
        
        //判断Mario是否跳起并碰撞到其他物体
        if ((contact.fixtureA == player_.topRightFixture || 
             contact.fixtureA == player_.topLeftFixture || 
             contact.fixtureB == player_.topLeftFixture || 
             contact.fixtureB == player_.topRightFixture) && player_.isJump == YES) {
            player_.body->SetLinearVelocity(b2Vec2(0, player_.body->GetLinearVelocity().y));
        }
        
        if (pushUpTimes_ == 0) {
            if (obj1.type == kGameObjectBrick && 
                obj1.bottomFixture == contact.fixtureA && 
                obj2.type == kGameObjectPlayer) {
                if (mario_status == kMarioSmall) {
                    [self brickRunPushUpAction:obj1 height:10];
                    
                }
                else {
                    if (std::find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                    [self brickRunPushUpAction:obj1 height:10];
                    [self smallBrickMoveAfterBigBrick:obj1];
                }
                pushUpTimes_++;
            }
            else if (obj2.type == kGameObjectBrick && 
                     obj2.bottomFixture == contact.fixtureB && 
                     obj1.type == kGameObjectPlayer) {
                if (mario_status == kMarioSmall) {
                    [self brickRunPushUpAction:obj2 height:10];
                    
                }
                else {
                    if (std::find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                    [self brickRunPushUpAction:obj2 height:10];
                    [self smallBrickMoveAfterBigBrick:obj2];
                }
                pushUpTimes_++;
            }
            else if (obj1.type == kGameObjectGoldBrick && 
                     obj1.bottomFixture == contact.fixtureA && 
                     obj2.type == kGameObjectPlayer) {
                
                pushUpTimes_++;
            }
            else if (obj2.type == kGameObjectGoldBrick && 
                     obj2.bottomFixture == contact.fixtureB && 
                     obj1.type == kGameObjectPlayer) {
                
                pushUpTimes_++;
            }
            else if (obj1.type == kGameObjectMushBrick && 
                     obj1.bottomFixture == contact.fixtureA && 
                     obj2.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj1];
                [self brickRunPushUpAction:obj1 height:10];
                
                if (mario_status == kMarioSmall) {
                    PipeAndRock *mushRoom = [self getFixedObjByName:@"mushRoom.png"];
                    mushRoom.position = ccp(obj1.position.x, obj1.position.y+10);
                    mushRoom.type = kGameObjectMushRoom;
                    [spriteSheet_ addChild:mushRoom z:1];
                    [mushRoom runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, 8)], 
                                                            [CCCallFuncN actionWithTarget:self 
                                                                                 selector:@selector(generateBodyOfSprite:)], 
                                                            nil]];
                    
                }
                else {
                    PipeAndRock *flower = [self getFixedObjByName:@"flower1.png"];
                    flower.position = ccp(obj1.position.x, obj1.position.y+10);
                    flower.type = kGameObjectFlower;
                    [spriteSheet_ addChild:flower z:1];
                    [flower runAction:[[flowerFlash_ copy] autorelease]];
                    [flower runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, 6)], 
                                                            [CCCallFuncN actionWithTarget:self 
                                                                                selector:@selector(generateBodyOfSprite:)], 
                                                            nil]];
                    
                }
                pushUpTimes_++;
            }
            else if (obj2.type == kGameObjectMushBrick && 
                     obj2.bottomFixture == contact.fixtureA && 
                     obj1.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj2];
                [self brickRunPushUpAction:obj2 height:10];
                
                if (mario_status == kMarioSmall) {
                    GameObject *mushRoom = [self getSpriteByName:@"mushRoom.png"];
                    mushRoom.position = ccp(obj2.position.x, obj2.position.y+10);
                    mushRoom.type = kGameObjectMushRoom;
                    [spriteSheet_ addChild:mushRoom z:1];
                    [mushRoom runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, 8)], 
                                         [CCCallFuncN actionWithTarget:self 
                                                              selector:@selector(generateBodyOfSprite:)], 
                                         nil]];
                    
                }
                else {
                    GameObject *flower = [self getSpriteByName:@"flower1.png"];
                    flower.position = ccp(obj2.position.x, obj2.position.y+10);
                    flower.type = kGameObjectFlower;
                    [spriteSheet_ addChild:flower z:1];
                    [flower runAction:[[flowerFlash_ copy] autorelease]];
                    [flower runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, 6)], 
                                       [CCCallFuncN actionWithTarget:self 
                                                            selector:@selector(generateBodyOfSprite:)], 
                                       nil]];
                    
                }
                pushUpTimes_++;
            }
        }
        
    }
    if (onGround == 0) {
        player_.isJump = YES;
        faceWallTimes_ = 0;
    }
    
    std::vector<b2Body *>::iterator pos1;
    for (pos1 = toDestroy.begin(); pos1 != toDestroy.end(); ++pos1) {
        b2Body *body = *pos1;
        if (body->GetUserData() != NULL) {
            GameObject *sprite = (GameObject *) body->GetUserData();
            [self removeChild:sprite cleanup:YES];
        }
        world_->DestroyBody(body);
    }
}

- (void) checkoutJump:(ccTime) dt {
    if (player_.isJump == NO) {
        if (hud_.btnB.active == YES) {
            totalPressTime_ += dt;
            player_.readyToJump = YES;
            if (totalPressTime_ > 0.1) {
                totalPressTime_ = 0.1;
                player_.body->ApplyLinearImpulse(b2Vec2(0, (300.0+2000*totalPressTime_)/PTM_RATIO), 
                                                 player_.body->GetWorldCenter());
                [player_ stopAllActions];
                if (player_.isMarioMovingRight) {
                    
                    if (mario_status == kMarioSmall) {
                        [player_ setDisplayFrame:marios_jumpR];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ setDisplayFrame:mariom_jumpR];
                    }
                    else {
                        [player_ setDisplayFrame:mariol_jumpR];
                    }
                }
                else {
                    
                    if (mario_status == kMarioSmall) {
                        [player_ setDisplayFrame:marios_jumpL];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ setDisplayFrame:mariom_jumpL];
                    }
                    else {
                        [player_ setDisplayFrame:mariol_jumpL];
                    }
                }
                totalPressTime_ = 0;
                player_.readyToJump = NO;
            }
        }
        else if (player_.readyToJump) {
            player_.body->ApplyLinearImpulse(b2Vec2(0, (300+2000*(totalPressTime_))/PTM_RATIO), 
                                             player_.body->GetWorldCenter());
            [player_ stopAllActions];
            if (player_.isMarioMovingRight) {
                
                if (mario_status == kMarioSmall) {
                    [player_ setDisplayFrame:marios_jumpR];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ setDisplayFrame:mariom_jumpR];
                }
                else {
                    [player_ setDisplayFrame:mariol_jumpR];
                }
            }
            else {
                
                if (mario_status == kMarioSmall) {
                    [player_ setDisplayFrame:marios_jumpL];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ setDisplayFrame:mariom_jumpL];
                }
                else {
                    [player_ setDisplayFrame:mariol_jumpL];
                }
            }
            player_.readyToJump = NO;
            totalPressTime_ = 0;
        }
    }
}

- (void) playerRunAction:(CCAction *)action1 second:(CCAction *)action2 third:(CCAction *)action3 {
    
    if (mario_status == kMarioSmall) {
        [player_ runAction:[[action1 copy] autorelease]];
    }
    else if (mario_status == kMarioLarge) {
        [player_ runAction:[[action2 copy] autorelease]];
    }
    else {
        [player_ runAction:[[action3 copy] autorelease]];
    }
}

- (void) updatePlayerPositon:(ccTime)dt {
    int32 velocityIterations = 8;
    int32 positionIterations = 3;
    world_->Step(dt, velocityIterations, positionIterations);
    CGPoint stkPos = hud_.stick.stickPosition;
    
    if (player_.isJump) {
        player_.isMoveFast = NO;
    }
    
    if (stkPos.x > 0 && abs(stkPos.x) > abs(stkPos.y)) {
        player_.stkHead = kStickHeadingRight;
    }
    if (stkPos.x < 0 && abs(stkPos.x) > abs(stkPos.y)) {
        player_.stkHead = kStickHeadingLeft;
    }
    if (stkPos.y < 0 && abs(stkPos.y) > abs(stkPos.x)) {
        player_.stkHead = kStickHeadingDown;
    }
    if (stkPos.y > 0 && abs(stkPos.y) > abs(stkPos.x)) {
        player_.stkHead = kStickHeadingUp;
    }
    if (stkPos.x == 0 && stkPos.y == 0) {
        player_.stkHead = kStickHeadingZero;
    }
    
    if (player_.stkHead == kStickHeadingRight && player_.isJump == NO) {
        
        if (player_.isFaceWall && faceWallTimes_ == 0) {
            [player_ stopAllActions];
            [self playerRunAction:marios_runSlowR second:mariom_runSlowR third:mariol_runSlowR];
            faceWallTimes_++;
        }
        
        if (hud_.btnA.active == YES) {
            player_.body->ApplyForceToCenter(b2Vec2((2000)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == NO) && 
                player_.isFaceWall == NO) {
                [player_ stopAllActions];
                [self playerRunAction:marios_runFastR second:mariom_runFastR third:mariol_runFastR];
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = YES;
            }
            
            if (player_.body->GetLinearVelocity().x > 8) {
                player_.body->SetLinearVelocity(b2Vec2(8.0, player_.body->GetLinearVelocity().y));
            }
        }
        else {
            player_.body->ApplyForceToCenter(b2Vec2((1500)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == NO || player_.isMoveFast == NO) && 
                player_.isFaceWall == NO) {
                [player_ stopAllActions];
                if (player_.body->GetLinearVelocity().x >= 0 && player_.body->GetLinearVelocity().x <= 1) {
                    [self playerRunAction:marios_runSlowR second:mariom_runSlowR third:mariol_runSlowR];
                    player_.isMoveFast = NO;
                }
                else if (player_.body->GetLinearVelocity().x > 1 && player_.body->GetLinearVelocity().x <= 5) {
                    [self playerRunAction:marios_runMediumR second:mariom_runMediumR third:mariol_runMediumR];
                    player_.isMoveFast = YES;
                }
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = YES;
            }
            
            if (player_.body->GetLinearVelocity().x > 4) {
                player_.body->SetLinearVelocity(b2Vec2(4.0, player_.body->GetLinearVelocity().y));
            }
        }
        
        if (player_.body->GetLinearVelocity().x < -2) {
            
            if (mario_status == kMarioSmall) {
                [player_ setDisplayFrame:marios_stopR];
            }
            else if (mario_status == kMarioLarge) {
                [player_ setDisplayFrame:mariom_stopR];
            }
            else {
                [player_ setDisplayFrame:mariol_stopR];
            }
        }
        
    }
    else if (player_.stkHead == kStickHeadingLeft && player_.isJump == NO) {
        
        if (player_.isFaceWall && faceWallTimes_ == 0) {
            [player_ stopAllActions];
            [self playerRunAction:marios_runSlowL second:mariom_runSlowL third:mariol_runSlowL];
            faceWallTimes_++;
        }
        
        if (hud_.btnA.active == YES) {
            player_.body->ApplyForceToCenter(b2Vec2(-(2000)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == YES) && 
                player_.isFaceWall == NO) {
                [player_ stopAllActions];
                
                [self playerRunAction:marios_runFastL second:mariom_runFastL third:mariol_runFastL];
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = NO;
            }
            
            if (player_.body->GetLinearVelocity().x < -8) {
                player_.body->SetLinearVelocity(b2Vec2(-8.0, player_.body->GetLinearVelocity().y));
            }
        }
        else {
            player_.body->ApplyForceToCenter(b2Vec2(-(1500)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == YES || player_.isMoveFast == NO) && 
                player_.isFaceWall == NO) {      
                [player_ stopAllActions];
                if (player_.body->GetLinearVelocity().x <= 0 && player_.body->GetLinearVelocity().x >= -1) {
                    [self playerRunAction:marios_runSlowL second:mariom_runSlowL third:mariol_runSlowL];
                    player_.isMoveFast = NO;
                }
                else if (player_.body->GetLinearVelocity().x < -1 && player_.body->GetLinearVelocity().x >= -5) {
                    [self playerRunAction:marios_runMediumL second:mariom_runMediumL third:mariol_runMediumL];
                    player_.isMoveFast = YES;
                }
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = NO;
                
            }
            
            if (player_.body->GetLinearVelocity().x < -4) {
                player_.body->SetLinearVelocity(b2Vec2(-4.0, player_.body->GetLinearVelocity().y));
            }
        }
        
        if (player_.body->GetLinearVelocity().x > 2) {
            
            if (mario_status == kMarioSmall) {
                [player_ setDisplayFrame:marios_stopL];
            }
            else if (mario_status == kMarioLarge) {
                [player_ setDisplayFrame:mariom_stopL];
            }
            else {
                [player_ setDisplayFrame:mariol_stopL];
            }
        }
        
    }
    
    //COMMENTS:
    //判断条件是mario的底边和任何物体有接触时，isJump = NO
    //当弹跳达到最高点时，竖直方向的速度也是0，所以不能用这个来判断mario是否在弹跳过程中
    
    if (abs(player_.body->GetLinearVelocity().x) < 0.3 && 
        abs(player_.body->GetLinearVelocity().y) < 0.3 && 
        player_.isJump == NO) {
            
        player_.isMarioStop = YES;
        player_.isMoveFast = NO;
        
        if (player_.stkHead != kStickHeadingLeft &&
            player_.stkHead != kStickHeadingRight) {
            faceWallTimes_ = 0;
            [player_ stopAllActions];
            if (player_.isMarioMovingRight) {
                
                if (mario_status == kMarioSmall) {
                    [player_ setDisplayFrame:marios_standR];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ setDisplayFrame:mariom_standR];
                }
                else {
                    [player_ setDisplayFrame:mariol_standR];
                }
            }
            else {
                
                if (mario_status == kMarioSmall) {
                    [player_ setDisplayFrame:marios_standL];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ setDisplayFrame:mariom_standL];
                }
                else {
                    [player_ setDisplayFrame:mariol_standL];
                }
            }
        }
    }
    
    player_.position = CGPointMake(player_.body->GetPosition().x*PTM_RATIO, 
                                   player_.body->GetPosition().y*PTM_RATIO);
    
    CGPoint zero = CGPointMake(0, 0);
    zero = [self convertToNodeSpace:zero];
    if (player_.position.x-player_.contentSize.width/2 < zero.x) {
        player_.body->SetTransform(b2Vec2((zero.x+player_.contentSize.width/2)/PTM_RATIO, 
                                          player_.body->GetPosition().y), 
                                   player_.body->GetAngle());
    }
    
    if (player_.position.y < zero.y) {
        [self backToSelectScene];
    }
    
    [self setViewPointCenter:player_.position];
}



- (id)init {
    if (self = [super init]) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        totalPressTime_ = 0;
        
        mario_status = delegate.marioStatus;
        
        tileMap_  = [CCTMXTiledMap node];
        tileMap_ = delegate.currentLevel.p_bg;
        tileMap_.anchorPoint = ccp(0, 0);
        //        CCTMXLayer *bgLayer = [tileMap_ layerNamed:@"backGround"];
        [self addChild:tileMap_];
                
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mario.plist"];
        spriteSheet_ = [[CCSpriteBatchNode batchNodeWithFile:@"mario.png"] retain];
        [tileMap_ addChild:spriteSheet_];
        
        [self generateAction];
        [self setPhysicsWorld];
                
        [self drawCollideObject];
        [self schedule:@selector(updateCollision)];
        [self schedule:@selector(checkoutJump:) interval:0.05];
        [self schedule:@selector(updatePlayerPositon:)];
        [self schedule:@selector(updateOtherObjPosition)];
        
    }
    return self;
}

- (void)dealloc {
    delete world_;
    delete m_debugDraw;
    delete contactListener_;
    [spriteSheet_ release];
    [marios_runSlowR release];
    [marios_runSlowL release];
    [marios_runFastR release];
    [marios_runFastL release];
    [marios_standL release];
    [marios_standR release];
    [marios_stopL release];
    [marios_stopR release];
    [marios_jumpL release];
    [marios_jumpR release];
    
    [mariom_runSlowR release];
    [mariom_runSlowL release];
    [mariom_runFastR release];
    [mariom_runFastL release];
    [mariom_standL release];
    [mariom_standR release];
    [mariom_stopL release];
    [mariom_stopR release];
    [mariom_jumpL release];
    [mariom_jumpR release];
    
    [mariol_runSlowR release];
    [mariol_runSlowL release];
    [mariol_runFastR release];
    [mariol_runFastL release];
    [mariol_standL release];
    [mariol_standR release];
    [mariol_stopL release];
    [mariol_stopR release];
    [mariol_jumpL release];
    [mariol_jumpR release];
    
    [ironBrick_ release];
    [goldBrickFlash_ release];
    [flowerFlash_ release];
    [super dealloc];
}

@end


@implementation MainGameScene
@synthesize gameLayer = gameLayer_, hudLayer = hudLayer_;

+ (id)scene {
    MainGameScene *scene = [MainGameScene node];
    scene.gameLayer = [MainGameLayer node];
    [scene addChild:scene.gameLayer z:-1];
    scene.hudLayer = [HudStickLayer node];
    [scene.hudLayer setStickVisible:YES];
    [scene addChild:scene.hudLayer z:0];
    scene.gameLayer.hud = scene.hudLayer;
    return scene;
}

@end