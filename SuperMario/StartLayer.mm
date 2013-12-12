//
//  StartLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-7.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "StartLayer.h"
#import "AppDelegate.h"

@implementation StartLayer

- (void) createCloudAtY:(float)posY scale:(float)scale duration:(float)time  {
    CCSprite *cloud1 = [CCSprite spriteWithFile:@"cloud.png"];
    cloud1.position = ccp(-cloud1.contentSize.width/2, (3.0/4)*winSize.height+posY);;
    cloud1.scale = scale;
    [self addChild:cloud1 z:1];
    [cloud1 runAction:[CCRepeatForever actionWithAction:
                       [CCSequence actions:
                        [CCMoveTo actionWithDuration:time 
                                            position:ccp(winSize.width+cloud1.contentSize.width/2, cloud1.position.y)],
                        [CCCallBlock actionWithBlock:^{ cloud1.position = ccp(-cloud1.contentSize.width/2, (3.0/4)*winSize.height+posY);; }], 
                        nil]]];
}

- (void) createEnemy {
    NSMutableArray *frame = [NSMutableArray array];
    CCSprite *enemy = [CCSprite spriteWithFile:@"enemy1_1.png"];
    enemy.position = ccp((120.0/480)*winSize.width, enemy.contentSize.height/2+(16.0/320)*winSize.height);
    [self addChild:enemy z:1];
    [enemy runAction:[CCRepeatForever actionWithAction:
                      [CCSequence actions:
                        [CCMoveBy actionWithDuration:5 position:ccp((115.0/480)*winSize.width, 0)], 
                        [CCMoveBy actionWithDuration:5 position:ccp(-(115.0/480)*winSize.width, 0)], 
                        nil]]];
    [frame addObject:[CCSpriteFrame frameWithTextureFilename:@"enemy1_1.png" rect:CGRectMake(0, 0, 16, 16)]];
    [frame addObject:[CCSpriteFrame frameWithTextureFilename:@"enemy1_2.png" rect:CGRectMake(0, 0, 16, 16)]];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frame delay:0.3];
    [enemy runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]]];
}

- (void) loadSelectScene {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate loadSelectScene];
}

- (void) createMenu {
    CCMenuItemFont *start = [CCMenuItemFont itemWithString:@"START" target:self selector:@selector(loadSelectScene)];
    CCMenu *menu = [CCMenu menuWithItems:start, nil];
    menu.position = ccp(winSize.width/2, (1.0/4)*winSize.height+(10.0/320)*winSize.height);
    [self addChild:menu z:1];
}

- (id)init {
    if (self = [super init]) {
        winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *bg = [CCSprite spriteWithFile:@"startLogo.png"];
        bg.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:bg z:0];
        
        [self createCloudAtY:0 scale:1 duration:15];
        [self createCloudAtY:10 scale:0.7 duration:20];
        [self createEnemy];
        [self createMenu];
    }
    return self;
}

-(void)onExit {
    [self removeAllChildrenWithCleanup:YES];
}

-(void)dealloc {
    [super dealloc];
}

@end

@implementation StartScene

- (id)init {
    if (self = [super init]) {
        StartLayer *layer = [StartLayer node];
        layer.position = ccp(0, 0);
        [self addChild:layer z:0];
    }
    return self;
}

-(void)dealloc {
    [super dealloc];
}

@end