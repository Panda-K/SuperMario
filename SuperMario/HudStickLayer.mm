//
//  HudStickLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "HudStickLayer.h"
#import "AppDelegate.h"

@implementation HudStickLayer
@synthesize score = p_score, coinNum = p_coinNum;

- (CCSpriteFrame *) getFrameByName: (NSString *)name {
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name];
    return frame;
}

- (CCSprite *) getSpriteByName: (NSString *)name {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrame:[self getFrameByName:name]];
    return sprite;
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

- (id) createLabelByName:(NSString *)name position:(CGPoint)pos fontSize:(int)size {
    CCLabelTTF *label = [CCLabelTTF labelWithString:name fontName:@"Chesterfield" fontSize:size];
    label.position = pos;
    [self addChild:label z:1];
    return label;
}

- (void) setHud {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    int l1 = delegate.curLevelNum/4 + 1;
    int l2 = delegate.curLevelNum%4 + 1;
    CCLabelTTF *mario = [self createLabelByName:@"MARIO" 
                                       position:ccp((130.0/480)*winSize.width, 
                                                    winSize.height-(10.0/320)*winSize.height) 
                                       fontSize:18];
    p_score = [self createLabelByName:[NSString stringWithFormat:@"%06d", delegate.curScore]
                             position:ccp(mario.position.x, mario.position.y-mario.contentSize.height) 
                             fontSize:17];
    
    CCSprite *coins = [self getSpriteByName:@"coins_1.png"];
    coins.position = ccp((200.0/480)*winSize.width, p_score.position.y);
    [self addChild:coins z:1];
    [coins runAction:[self createFrameActionByName:@"coins_%d.png" frameNum:3 interval:0.2 repeat:0]];
    
    p_coinNum = [self createLabelByName:[NSString stringWithFormat:@"x %02d", delegate.curCoinNum]
                               position:ccp(coins.position.x+(40.0/480)*winSize.width, coins.position.y) 
                               fontSize:17];
    
    CCLabelTTF *world = [self createLabelByName:@"WORLD" 
                                       position:ccp((330.0/480)*winSize.width, mario.position.y)
                                       fontSize:18];
    CCLabelTTF *levelNum = [self createLabelByName:[NSString stringWithFormat:@"%d-%d", l1, l2] 
                                          position:ccp(world.position.x, p_score.position.y) 
                                          fontSize:17];
    CCLabelTTF *time = [self createLabelByName:@"TIME" 
                                      position:ccp((430.0/480)*winSize.width, mario.position.y)
                                      fontSize:18];
    m_timeNum = [self createLabelByName:@"500" 
                               position:ccp(time.position.x, p_score.position.y) 
                               fontSize:17];
}

- (void)setStickVisible:(BOOL)show {
    isStickShow_ = show;
}

- (void) setStick {
    
}

- (id)init {
    if (self = [super init]) {
        winSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mario.plist"];
        spriteSheet_ = [CCSpriteBatchNode batchNodeWithFile:@"mario.png"];
        [self addChild:spriteSheet_];
        
        [self setHud];
        if (isStickShow_) {
            [self setStick];
        }
    }
    
    return self;
}

@end
