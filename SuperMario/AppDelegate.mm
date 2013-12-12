//
//  AppDelegate.mm
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//
#import "AppDelegate.h"

@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;
@synthesize startScene = startScene_, selectScene = selectScene_, gameInfoScene = gameInfoScene_;
@synthesize mainGameScene = mainGameScene_;
@synthesize curCoinNum = curCoinNum_, curLevelNum = curLevelNum_, curLives = curLives_, curScore = curScore_;
@synthesize levels = levels_, coreDataContext = coreDataContext_, sharedPsc = sharedPsc_;
@synthesize levelIndexInCoreData = levelIndexInCoreData_;
@synthesize soundEngin = soundEngin_, marioStatus = marioStatus_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
    
#if GAME_ORIENTATION == kGameOrientationPortrait
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	
								   depthFormat:0	
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
#elif GAME_ORIENTATION == kGameOrientationLandScape
    CCGLView *glView = [CCGLView viewWithFrame:CGRectMake(0, 0, [window_ bounds].size.height, [window_ bounds].size.width)
								   pixelFormat:kEAGLColorFormatRGB565	
								   depthFormat:0	
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
#endif
    
	// Enable multiple touches
	[glView setMultipleTouchEnabled:YES];
    NSLog(@"glView width is : %f", glView.bounds.size.width);
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
    
	// Display FSP and SPF
	//[director_ setDisplayStats:YES];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
	
	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director_ enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
    
    
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
    // Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
    
    //[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
    
    
    
    self.levelIndexInCoreData = [[NSMutableArray alloc] init];
    self.levels = [[NSMutableArray alloc] init];
    
    self.coreDataContext = [[NSManagedObjectContext alloc] init];
    self.sharedPsc = nil;
    self.curScore = 0;
    self.curLives = 3;
    self.curCoinNum = 0;
    self.marioStatus = kMarioSmall;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self sharedPersistentStoreCoordinator];
        coreDataContext_.persistentStoreCoordinator = sharedPsc_;
        [self loadLevelIndexData];
    });
    
    for (int index = 0; index < 32; index++) {
        Level *t_level = [[Level alloc] initWithLevelNum:index];
        [self.levels addObject:t_level];
        
    }
    [director_ pushScene: [IntroLayer scene]];

    
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	
    
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (Level *)currentLevel {
    return [levels_ objectAtIndex:curLevelNum_];
}

- (void) loadStartScene {
    startScene_ =  [StartScene node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                                                                                 scene:startScene_
                                                                             withColor:ccWHITE]];
}

- (void) loadSelectScene {
    selectScene_ = [SelectScene node];
    [[CCDirector sharedDirector] replaceScene:selectScene_];
}

- (void) loadGameInfoScene {
    gameInfoScene_ = [GameInfoScene scene];
    [[CCDirector sharedDirector] replaceScene:gameInfoScene_];
}

- (void) loadMainGameScene {
    mainGameScene_ = [MainGameScene scene];
    [mainGameScene_.gameLayer reset];
    [[CCDirector sharedDirector] replaceScene:mainGameScene_];
}

- (void) nextLevel {
    mainGameScene_ = [MainGameScene scene];
    [mainGameScene_.gameLayer reset];
    [[CCDirector sharedDirector] replaceScene:mainGameScene_];
}

- (void) levelComplete {
    curLevelNum_++;
    [self loadGameInfoScene]; //check load winScene ,gameoverScene or newLevelScene
}

- (void) restartGame {
    [self loadSelectScene];
}





- (NSPersistentStoreCoordinator *)sharedPersistentStoreCoordinator {
    if (sharedPsc_) {
        return sharedPsc_;
    }
    sharedPsc_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:
                                                            [NSManagedObjectModel mergedModelFromBundles:nil]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *storePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"coredata.sql"];

    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    NSError *error = nil;
    if (![sharedPsc_ addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:storeUrl
                                        options:options
                                          error:&error]) {
        NSLog(@"Unresolved Problem : %@ %@ \n!!", error, [error userInfo]);
        abort();
    }
    return sharedPsc_;
}

- (void) loadLevelIndexData {
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    request.entity = [NSEntityDescription entityForName:@"Levels" inManagedObjectContext:coreDataContext_];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"levelIndex" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
//    request.predicate = [NSPredicate predicateWithFormat:@"leveIndex < %@", [NSNumber numberWithInt:32]];

    NSError *error = nil;
    NSArray *objs = [[[NSArray alloc] init] autorelease];
    objs = [self.coreDataContext executeFetchRequest:request error:&error];

    if (error) {
        [NSException raise:@"Search error!\n" format:@"%@", [error localizedDescription]];
    }
    else if (objs.count == 0) {
        NSManagedObject *level = [NSEntityDescription insertNewObjectForEntityForName:@"Levels" inManagedObjectContext:coreDataContext_];
        [level setValue:[NSNumber numberWithInt:0] forKey:@"levelIndex"];
        NSError *err = nil;
        if (![self.coreDataContext save:&err]) {
            [NSException raise:@"DataBase Access error!!\n" format:@"%@", [err localizedDescription]];
        }
        else {
            [levelIndexInCoreData_ addObject:[NSNumber numberWithInt:0]];
        }
    }
    else {
        for (NSManagedObject *obj in objs) {
            [levelIndexInCoreData_ addObject:[obj valueForKey:@"levelIndex"]];
            
        }
    }
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	[levels_ release];
    [coreDataContext_ release];
    [sharedPsc_ release];
    [levelIndexInCoreData_ release];
//    [mainGameScene_ release];
    
	[super dealloc];
}
@end

