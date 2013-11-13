//
//  IntroLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "AppDelegate.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    int flashTimes_;
    CCSprite *logo_;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
