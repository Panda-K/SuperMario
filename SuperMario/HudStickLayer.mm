//
//  HudStickLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "HudStickLayer.h"
#import "AppDelegate.h"

@implementation HudStickLayer
@synthesize score = p_score, coinNum = p_coinNum;
@synthesize btnA = p_btnA, btnB = p_btnB, stick = p_stick;

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
    [m_btnA setVisible:show];
    [m_btnB setVisible:show];
    [m_stick setVisible:show];
}

- (id) createBtnWithSkin:(NSString *)name1 pressSkin:(NSString *)name2 isHold:(BOOL)hold position:(CGPoint)pos {
    SneakyButton *btn = [[[SneakyButton alloc] initWithRect:CGRectZero] autorelease];
    btn.isHoldable = hold;
    SneakyButtonSkinnedBase *skinBtn = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    skinBtn.position = pos;
    skinBtn.defaultSprite = [self getSpriteByName:name1];
    skinBtn.pressSprite = [self getSpriteByName:name2];
    skinBtn.button = btn;
    [self addChild:skinBtn z:1];
    return skinBtn;
}

- (id) createJoyStick:(NSString *)in bg:(NSString *)out position:(CGPoint)pos {  
    CCSprite *thumb = [self getSpriteByName:in];
    SneakyJoystick *stick = [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, thumb.contentSize.width, thumb.contentSize.height)] autorelease];
    stick.autoCenter = YES;
    stick.hasDeadzone = YES;
    stick.deadRadius = 10;
    
    
    SneakyJoystickSkinnedBase *skinStick = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    skinStick.position = pos;
    skinStick.backgroundSprite = [self getSpriteByName:out];
    skinStick.thumbSprite = thumb;
    skinStick.joystick = stick;
    [self addChild:skinStick];
    
    return skinStick;
}

- (void) setStick {
    float btnRadius = 50.0;
    float stickRadius = 60.0;
    m_btnB = [self createBtnWithSkin:@"xbuttonB_up.png" 
                           pressSkin:@"xbuttonB_down.png" 
                              isHold:YES 
                            position:ccp(winSize.width-(btnRadius/480)*winSize.width, (btnRadius/320)*winSize.height)];
    m_btnA = [self createBtnWithSkin:@"xbuttonA_up.png" 
                           pressSkin:@"xbuttonA_down.png" 
                              isHold:YES 
                            position:ccp(winSize.width-(3*btnRadius/480)*winSize.width, (btnRadius/320)*winSize.height)];
    m_stick = [self createJoyStick:@"stick_in.png" 
                                bg:@"stick_out.png" 
                          position:ccp(((stickRadius+50.0)/480)*winSize.width, (stickRadius/320)*winSize.height)];
    p_btnA = m_btnA.button;
    p_btnB = m_btnB.button;
    p_stick = m_stick.joystick;
}

- (id)init {
    if (self = [super init]) {
        winSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mario.plist"];
        spriteSheet_ = [CCSpriteBatchNode batchNodeWithFile:@"mario.png"];
        [self addChild:spriteSheet_];
        
        [self setHud];
        [self setStick];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
    [p_btnA release];
    [p_btnB release];
    [p_stick release];
}

@end
