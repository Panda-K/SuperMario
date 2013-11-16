//
//  IntroLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright __Panda-K__ 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "MainGameLayer.h"
#import "StartLayer.h"
#import "SimpleAudioEngine.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) flashPoint {
    if (flashTimes_ < 15) {
        flasPos_ = ccp(logo_.position.x-logo_.contentSize.width/2+(10.0/480)*winSize.width+flashTimes_*(logo_.contentSize.width-20)/14, logo_.position.y - logo_.contentSize.height/2-(20.0/320)*winSize.height);
        CCSprite *point = [CCSprite spriteWithFile:@"flashPoint.png"];
        point.position = flasPos_;
        point.scale = 0.8;
        [self addChild:point z:1];
        [point runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.5], nil]];
        flashTimes_++;
    }
    else {
        flashTimes_ = 0;
    }
}

- (void) loadLogo {
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		logo_ = [CCSprite spriteWithFile:@"logo.png"];
	} else {
		logo_ = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	logo_.position = ccp(winSize.width/2, winSize.height/2);
	[self addChild: logo_ z:0];
    [logo_ runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.5], [CCFadeIn actionWithDuration:0.5], nil]];
}

- (void) loadSoundEngine {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    delegate.soundEngin = [SimpleAudioEngine sharedEngine];
    [delegate.soundEngin preloadEffect:@"smb_coin.wav"];
    [delegate.soundEngin preloadBackgroundMusic:@"Overworld_piano.mid"];
}

-(void) onEnter
{
	[super onEnter];
	winSize = [[CCDirector sharedDirector] winSize];
    flashTimes_ = 0;
    
	[self loadLogo];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadSoundEngine];
    });
    
    [self schedule:@selector(flashPoint) interval:0.075 repeat:45 delay:0];
	
	[self scheduleOnce:@selector(makeTransition:) delay:3];
}

-(void) makeTransition:(ccTime)dt
{
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate loadStartScene];
}
@end
