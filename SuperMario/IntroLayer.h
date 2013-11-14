//
//  IntroLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright __Panda-K__ 2013年. All rights reserved.
//

#import "AppDelegate.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    CGPoint flasPos_;
    CCSprite *logo_;
    int flashTimes_;
    CGSize winSize;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
