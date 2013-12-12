//
//  SelectLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-7.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "SelectLayer.h"
#import "SimpleAudioEngine.h"

@implementation SelectLayer

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

- (void) loadGameInfoScene: (id)sender {
    CCMenuItem *item = (CCMenuItem *)sender;
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    delegate.curCoinNum = 0;
    delegate.curScore = 0;
    delegate.curLives = 3;
    delegate.curLevelNum = item.tag;
    delegate.marioStatus = kMarioSmall;
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [delegate loadGameInfoScene];
}

- (void) createMenu {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *menuItem1 = [NSMutableArray array];
    NSMutableArray *menuItem2 = [NSMutableArray array];
    NSMutableArray *menuItem3 = [NSMutableArray array];
    int levelNum = 0;
    for (int i = 0; i < 32; i++) {
        CCMenuItemSprite *item = nil;
        if (levelNum < [delegate.levelIndexInCoreData count]) {
            if (i == [[delegate.levelIndexInCoreData objectAtIndex:levelNum] intValue]) {
                item = [CCMenuItemSprite itemWithNormalSprite:
                            [self getSpriteByName:[NSString stringWithFormat:@"level%d.png", i]] 
                                                              selectedSprite:nil
                                                                      target:self
                                                                    selector:@selector(loadGameInfoScene:)];
                levelNum++;
                item.tag = i;
            }
        }
        else {
            item = [CCMenuItemSprite itemWithNormalSprite:[self getSpriteByName:@"lockedLevel.png"] 
                                                             selectedSprite:nil];
            item.tag = 100;
        }
        if (i >= 0 && i < 12) {
            [menuItem1 addObject:item];
        }
        else if (i >= 12 && i < 24) {
            [menuItem2 addObject:item];
        }
        else if (i >= 24 && i <32) {
            [menuItem3 addObject:item];
        }
    }
    menu1_ = [[CCMenu alloc] initWithArray:menuItem1];
    menu2_ = [[CCMenu alloc] initWithArray:menuItem2];
    menu3_ = [[CCMenu alloc] initWithArray:menuItem3];
    
    menu1_.position = ccp(winSize.width/2, winSize.height/2);
    NSNumber *itemPerRow = [NSNumber numberWithInt:4];
    [menu1_ alignItemsInColumns:itemPerRow, itemPerRow, itemPerRow, nil];
    for (CCMenuItem *item in menu1_.children) {
        item.position = ccp(item.position.x, item.position.y+(30.0/320)*winSize.height);
    }
    [self addChild:menu1_ z:1];
    
    menu2_.position = ccp(winSize.width/2+winSize.width, winSize.height/2);
    [menu2_ alignItemsInColumns:itemPerRow, itemPerRow, itemPerRow, nil];
    for (CCMenuItem *item in menu2_.children) {
        item.position = ccp(item.position.x, item.position.y+(30.0/320)*winSize.height);
    }
    [self addChild:menu2_ z:1];
    
    menu3_.position = ccp(winSize.width/2+2*winSize.width, winSize.height/2);
    [menu3_ alignItemsInColumns:itemPerRow, itemPerRow, nil];
    for (CCMenuItem *item in menu3_.children) {
        item.position = ccp(item.position.x, item.position.y+(30.0/320)*winSize.height);
    }
    [self addChild:menu3_ z:1];
}

- (void) createBottomIndex {
    brick2 = [[self getSpriteByName:@"goldBrick1_1.png"] retain];
    brick2.position = ccp(winSize.width/2, (16.0/320)*winSize.height+brick2.contentSize.height/2);
    [spriteSheet_ addChild:brick2 z:2];
    [brick2 runAction:[[flashBrick_ copy] autorelease]];
    
    brick3 = [[self getSpriteByName:@"goldBrick1_1.png"] retain];
    brick3.position = ccp(winSize.width/2+(20.0/480)*winSize.width, brick2.position.y);
    [spriteSheet_ addChild:brick3 z:2];
    [brick3 runAction:[[flashBrick_ copy] autorelease]];
    
    brick1 = [[self getSpriteByName:@"no1.png"] retain];
    brick1.position = ccp(winSize.width/2-(20.0/480)*winSize.width, brick2.position.y);
    [spriteSheet_ addChild:brick1 z:2];
    
    upCoin1 = [[self getSpriteByName:@"coinUp1.png"] retain];
    upCoin1.position = brick1.position;
    upCoin1.tag = 51;
    [spriteSheet_ addChild:upCoin1 z:1];
    
    upCoin2 = [[self getSpriteByName:@"coinUp1.png"] retain];
    upCoin2.position = brick2.position;
    upCoin2.tag = 52;
    [spriteSheet_ addChild:upCoin2 z:1];
    
    upCoin3 = [[self getSpriteByName:@"coinUp1.png"] retain];
    upCoin3.position = brick3.position;
    upCoin3.tag = 53;
    [spriteSheet_ addChild:upCoin3 z:1];
}

- (id)init {
    if (self = [super init]) {
        isFirstTime_ = YES;
        self.isTouchEnabled = YES;
        inMenu1_ = YES;
        inMenu2_ = NO;
        inMenu3_ = NO;
        winSize = [[CCDirector sharedDirector] winSize];

        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"selectLayerSheet.plist"];
        spriteSheet_ = [CCSpriteBatchNode batchNodeWithFile:@"selectLayerSheet.png"];
        [self addChild:spriteSheet_];

        bg_ = [self getSpriteByName:@"selectBg.png"];
        bg_.position = ccp(winSize.width/2, winSize.height/2);
        [spriteSheet_ addChild:bg_ z:0];
        
        [self createMenu];
        
        flashBrick_ = [[self createFrameActionByName:@"goldBrick1_%d.png" frameNum:10 interval:0.1 repeat:0] retain];
        coinUp_ = [[self createFrameActionByName:@"coinUp%d.png" frameNum:4 interval:0.02 repeat:10] retain];
        
        [self createBottomIndex];
        
    }
    return self;
}

- (void)registerWithTouchDispatcher {  
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:-129 swallowsTouches:NO];  
}

- (void) panForTranslation: (CGPoint)translation {  
    menu1_.position = ccpAdd(menu1_.position, translation);  
    menu2_.position = ccpAdd(menu2_.position, translation);  
    menu3_.position = ccpAdd(menu3_.position, translation);  
    
}  

- (CGRect) getMenuCGRect: (CCNode *)node {  
    CGRect menuRect = CGRectMake(node.position.x - node.contentSize.width/2, node.position.y - node.contentSize.height/2, node.contentSize.width, node.contentSize.height);  
    return menuRect;  
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {  
    CGPoint location = [self convertTouchToNodeSpace:touch];  
    CGPoint locationInMenu1 = [menu1_ convertToNodeSpace:location];  
    CGPoint locationInMenu2 = [menu2_ convertToNodeSpace:location];  
    CGPoint locationInMenu3 = [menu3_ convertToNodeSpace:location];  
    startPos_ = location;  
    [menu1_ stopAllActions];  
    [menu2_ stopAllActions];  
    [menu3_ stopAllActions];  
    
    for (CCMenuItem *item in menu1_.children) {  
        if (CGRectContainsPoint([self getMenuCGRect:item], locationInMenu1)) {  
            [item setIsEnabled:NO];
            BeginTouchedItem_ = item; 
            return YES;
        }  
    }  
    for (CCMenuItem *item in menu2_.children) {  
        if (CGRectContainsPoint([self getMenuCGRect:item], locationInMenu2)) {  
            [item setIsEnabled:NO];  
            BeginTouchedItem_ = item;  
            return YES;  
        }  
    }  
    for (CCMenuItem *item in menu3_.children) {  
        if (CGRectContainsPoint([self getMenuCGRect:item], locationInMenu3)) {  
            [item setIsEnabled:NO];  
            BeginTouchedItem_ = item;  
            return YES;  
        }  
    }  
    return YES;  
}

- (void) setUpCoinPos: (id)sender {
    CCSprite *coin = (CCSprite *)sender;
    switch (coin.tag) {
        case 51:
            coin.position = brick1.position;
            break;
        case 52:
            coin.position = brick2.position;
            break;
        case 53:
            coin.position = brick3.position;
            break;
        default:
            break;
    }
}

- (void) menuMoveTo:(CGPoint)pos {
    [menu1_ runAction:[CCMoveTo actionWithDuration:0.5 position:pos]];  
    [menu2_ runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(pos.x+winSize.width, pos.y)]];  
    [menu3_ runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(pos.x+winSize.width*2, pos.y)]]; 
}

- (void) coinFlyUp:(CCSprite *)coin {
    [coin runAction:[CCSequence actions:
                        [CCMoveBy actionWithDuration:0.3 position:ccp(0, (50.0/320)*winSize.height)], 
                        [CCMoveBy actionWithDuration:0.1 position:ccp(0, -(15.0/320)*winSize.height)], 
                        [CCCallFuncN actionWithTarget:self selector:@selector(setUpCoinPos:)], nil]];
    [coin runAction:[[coinUp_ copy] autorelease]];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {   
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    CGPoint centerPoint = CGPointMake(winSize.width/2, winSize.height/2);  
    centerPoint = [self convertToNodeSpace:centerPoint];  
    endPos_ = [self convertTouchToNodeSpace:touch];  
    
    if (abs(startPos_.x - endPos_.x) <= 10 && abs(startPos_.y - endPos_.y) <= 10) {  //人手的触摸范围较大，需要一个范围
        [BeginTouchedItem_ setIsEnabled:YES];  
        [BeginTouchedItem_ activate];  
    }  
    CGRect menu1Rect = [self getMenuCGRect:menu1_];
    CGRect menu2Rect = [self getMenuCGRect:menu2_];
    CGRect menu3Rect = [self getMenuCGRect:menu3_];
    
    if (CGRectContainsPoint(menu1Rect, centerPoint)) {  
        [self menuMoveTo:ccp(winSize.width/2, winSize.height/2)]; 
        inMenu2_ = NO;
        if (inMenu1_ == NO) {
            [delegate.soundEngin playEffect:@"smb_coin.wav"];
            [brick1 pauseSchedulerAndActions];
            [brick2 resumeSchedulerAndActions];
            [brick1 setDisplayFrame:[self getFrameByName:@"no1.png"]];
            [self coinFlyUp:upCoin1];
            inMenu1_ = YES;
        }
    }
    else if (CGRectContainsPoint(menu2Rect, centerPoint)) {  
        [self menuMoveTo:ccp(-winSize.width/2, winSize.height/2)];
        inMenu1_ = NO;
        inMenu3_ = NO;
        
        if (inMenu2_ == NO) {
            [delegate.soundEngin playEffect:@"smb_coin.wav"];
            if (isFirstTime_) {
                [brick1 runAction:[[flashBrick_ copy]autorelease]];
                isFirstTime_ = NO;
            }
            else {
                [brick1 resumeSchedulerAndActions];
            }
            [brick2 pauseSchedulerAndActions];
            [brick3 resumeSchedulerAndActions];
            [brick2 setDisplayFrame:[self getFrameByName:@"no2.png"]];
            [self coinFlyUp:upCoin2];
            inMenu2_ = YES;
        }
    }  
    else if (CGRectContainsPoint(menu3Rect, centerPoint)) {  
        [self menuMoveTo:ccp(-winSize.width/2-winSize.width, winSize.height/2)];
        inMenu2_ = NO;
        if (inMenu3_ == NO) {
            [delegate.soundEngin playEffect:@"smb_coin.wav"];
            [brick3 pauseSchedulerAndActions];
            [brick2 resumeSchedulerAndActions];
            [brick3 setDisplayFrame:[self getFrameByName:@"no3.png"]];
            [self coinFlyUp:upCoin3];
            inMenu3_ = YES;
        }
    }  
    else if (centerPoint.x <= menu1_.position.x - menu1_.contentSize.width/2) {  
        [self menuMoveTo:ccp(winSize.width/2, winSize.height/2)];  
    }  
    else if (centerPoint.x - menu3_.position.x >= menu3_.contentSize.width/2) {  
        [self menuMoveTo:ccp(-winSize.width/2-winSize.width, winSize.height/2)];
    }  
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {  
    CGPoint curLocation = [self convertTouchToNodeSpace:touch];  
    CGPoint oldLocation = [touch previousLocationInView:touch.view];  
    oldLocation = [[CCDirector sharedDirector] convertToGL:oldLocation];   
    oldLocation = [self convertToNodeSpace:oldLocation];  
    
    CGPoint translation = ccpSub(curLocation, oldLocation);  
    [self panForTranslation:ccp(translation.x, 0)];  
}

-(void)onExit {
    [spriteSheet_ removeAllChildrenWithCleanup:YES];
}

- (void)dealloc {
    
    [super dealloc];
    [menu1_ release];
    [menu2_ release];
    [menu3_ release];
    [flashBrick_ release];
    [coinUp_ release];
    [brick1 release];
    [brick2 release];
    [brick3 release];
    [upCoin1 release];
    [upCoin2 release];
    [upCoin3 release];
}

@end

@implementation SelectScene

- (id)init {
    if (self = [super init]) {
        SelectLayer *layer = [SelectLayer node];
        [self addChild:layer];
    }
    return self;
}

-(void)dealloc {
    [super dealloc];
}

@end