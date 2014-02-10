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
@synthesize isGamePause = p_isGamePause;

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

- (void) loadGameInfoScene {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate loadGameInfoScene];
}

- (void) loadSelectScene {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate loadSelectScene];
}

- (id) createLabelByName:(NSString *)name position:(CGPoint)pos fontSize:(int)size {
    CCLabelTTF *label = [CCLabelTTF labelWithString:name fontName:@"Chesterfield" fontSize:size];
    label.position = pos;
    [self addChild:label z:1];
    return label;
}

- (void) stretchOutAction {
    [m_stretchMenu runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    [m_wheelGear runAction:[CCRotateBy actionWithDuration:0.8 angle:360.0]];
}

- (void) stretchInAction {
    [m_stretchMenu runAction:[CCScaleTo actionWithDuration:0.5 scaleX:1.0 scaleY:0.01]];
    [m_wheelGear runAction:[CCRotateBy actionWithDuration:0.8 angle:-360.0]];
}

- (void) soundOnAndOff:(id)sender {
    CCMenuItemToggle *tog = (CCMenuItemToggle *)sender;
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    
    if (tog.selectedItem == m_soundOn) {
        delegate.isSoundOn = YES;
    }
    if (tog.selectedItem == m_soundOff) {
        delegate.isSoundOn = NO;
    }
}

- (void) toolBtnStretch:(id) sender {
    CCMenuItemToggle *tog = (CCMenuItemToggle *)sender;
    
    if (tog.selectedItem == m_stretchOut) {
        [self stretchOutAction];
        self.isGamePause = YES;
    }
    
    if (tog.selectedItem == m_stretchIn) {
        [self stretchInAction];
        self.isGamePause = NO;
    }
}

- (void) continueGame {
    [self stretchInAction];
    self.isGamePause = NO;
}

- (void)setToolMenuEnable:(BOOL)enable {
    [m_toolMenu setEnabled:enable];
}

- (void) createToolBtn {
    
    m_stretchOut = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"bottomCircle.png"] 
                                           selectedSprite:nil 
                                                   target:self 
                                                 selector:nil] retain];
    [m_stretchOut setScale:0.5];
    m_stretchIn = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"bottomCircle.png"] 
                                          selectedSprite:nil 
                                                  target:self 
                                                selector:nil] retain];
    [m_stretchIn setScale:0.5];
    CCMenuItemToggle *togBtn = [CCMenuItemToggle itemWithTarget:self 
                                                       selector:@selector(toolBtnStretch:) 
                                                          items:m_stretchOut, m_stretchIn, nil];
    m_toolMenu = [CCMenu menuWithItems:togBtn, nil];
    m_toolMenu.position = ccp((30.0/480)*winSize.width, winSize.height-(30.0/320)*winSize.height);
    [self addChild:m_toolMenu z:2];
    
    m_wheelGear = [[self getSpriteByName:@"tool.png"] retain];
    m_wheelGear.position = ccp(m_toolMenu.position.x, m_toolMenu.position.y);
    [m_wheelGear setScale:0.5];
    [spriteSheet_ addChild:m_wheelGear];
    
    m_continueBtn = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"continue1.png"] 
                                            selectedSprite:nil 
                                                    target:self 
                                                  selector:@selector(continueGame)] retain];
    [m_continueBtn setScale:0.3];
    m_restartBtn = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"restart1.png"] 
                                           selectedSprite:nil 
                                                   target:self 
                                                 selector:@selector(loadGameInfoScene)] retain];
    [m_restartBtn setScale:0.3];
    m_contentBtn = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"content1.png"] 
                                           selectedSprite:nil 
                                                   target:self 
                                                 selector:@selector(loadSelectScene)] retain];
    [m_contentBtn setScale:0.3];
    m_soundOn = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"soundOn.png"] 
                                        selectedSprite:nil 
                                                target:self 
                                              selector:nil] retain];
    [m_soundOn setScale:0.3];
    m_soundOff = [[CCMenuItemImage itemWithNormalSprite:[self getSpriteByName:@"soundOff.png"] 
                                         selectedSprite:nil 
                                                 target:self 
                                               selector:nil] retain];
    [m_soundOff setScale:0.3];
    
    m_soundBtn = [[CCMenuItemToggle itemWithTarget:self 
                                          selector:@selector(soundOnAndOff:) 
                                             items:m_soundOn, m_soundOff, nil] retain];
    m_stretchMenu = [[CCMenu alloc] initWithArray:
                     [NSArray arrayWithObjects:m_continueBtn, m_restartBtn, m_contentBtn, m_soundBtn, nil]];
    [m_stretchMenu alignItemsVerticallyWithPadding:5.0];
    m_stretchMenu.ignoreAnchorPointForPosition = NO;
    m_stretchMenu.anchorPoint = ccp(0, 1.0);
    m_stretchMenu.position = ccp(m_wheelGear.position.x, m_wheelGear.position.y);
    m_stretchMenu.contentSize = CGSizeMake((80.0/480)*winSize.width, (150.0/320)*winSize.height);
    [m_stretchMenu setScale:0.01];
    
    [self addChild:m_stretchMenu z:1];
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
    m_timeNum = [self createLabelByName:[NSString stringWithFormat:@"%d", delegate.timer] 
                               position:ccp(time.position.x, p_score.position.y) 
                               fontSize:17];
}

- (void) changeTime:(int) time {
    [m_timeNum setString:[NSString stringWithFormat:@"%d", time]];
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
        self.isGamePause = NO;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hudLayerSheet.plist"];
        spriteSheet_ = [CCSpriteBatchNode batchNodeWithFile:@"hudLayerSheet.png"];
        [self addChild:spriteSheet_ z:3];
        
        [self setHud];
        [self setStick];
        [self createToolBtn];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
    [p_btnA release];
    [p_btnB release];
    [p_stick release];
    [m_stretchIn release];
    [m_stretchOut release];
    [m_wheelGear release];
    [m_soundOff release];
    [m_soundOn release];
    [m_contentBtn release];
    [m_continueBtn release];
    [m_restartBtn release];
    [m_soundBtn release];
    [m_stretchMenu release];
}

@end
