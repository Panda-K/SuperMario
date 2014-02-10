//
//  SelectLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-7.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//
#import "AppDelegate.h"

@interface SelectLayer : CCLayer {
    CCSpriteBatchNode *m_spriteSheet;
    CCMenu *menu1_;
    CCMenu *menu2_;
    CCMenu *menu3_;    
    CCMenuItem *BeginTouchedItem_;
    
    CCSprite *brick1;
    CCSprite *brick2;
    CCSprite *brick3;
    CCSprite *upCoin1;
    CCSprite *upCoin2;
    CCSprite *upCoin3;
    CCSprite *bg_;
    
    BOOL inMenu1_, inMenu2_, inMenu3_;
    
    CCAction *flashBrick_;
    CCAction *coinUp_;
    
    BOOL isFirstTime_;
    CCSpriteBatchNode *spriteSheet_;
    CGPoint startPos_, endPos_;
    CGSize winSize;
}
    
@end

@interface SelectScene : CCScene {

}
@end
