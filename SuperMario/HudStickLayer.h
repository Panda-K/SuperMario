//
//  HudStickLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

@interface HudStickLayer : CCLayer {
    CCLabelTTF *p_score;
    CCLabelTTF *p_coinNum;
    CCLabelTTF *m_timeNum;
    
    BOOL isStickShow_;
    
    CCSpriteBatchNode *spriteSheet_;
    
    SneakyButton *p_btnA;
    SneakyButton *p_btnB;
    SneakyJoystick *p_stick;
    SneakyButtonSkinnedBase *m_btnA;
    SneakyButtonSkinnedBase *m_btnB;
    SneakyJoystickSkinnedBase *m_stick;
    CGSize winSize;
}

@property (nonatomic, retain) CCLabelTTF *score;
@property (nonatomic, retain) CCLabelTTF *coinNum;
@property (nonatomic, retain) SneakyButton *btnA;
@property (nonatomic, retain) SneakyButton *btnB;
@property (nonatomic, retain) SneakyJoystick *stick;

- (void) reset;
- (void) setScoreLabel;
- (void) setCoinLabel;
- (void) setStickVisible:(BOOL)show;

@end
