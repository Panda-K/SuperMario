//
//  HudStickLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

@interface HudStickLayer : CCLayer {
    CCLabelTTF *p_score;
    CCLabelTTF *p_coinNum;
    CCLabelTTF *m_timeNum;
    
    BOOL isStickShow_;
    
    CCSpriteBatchNode *spriteSheet_;
    CGSize winSize;
}

@property (nonatomic, retain) CCLabelTTF *score;
@property (nonatomic, retain) CCLabelTTF *coinNum;

- (void) reset;
- (void) setScoreLabel;
- (void) setCoinLabel;
- (void) hideStick;

@end
