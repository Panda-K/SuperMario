//
//  Player.h
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "GameConfig.h"

@interface Player : GameObject {
    
}

- (void) moveRight;
- (void) moveLeft;
- (void) jump;
- (void) down;

@end
