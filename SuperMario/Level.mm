//
//  Level.m
//  SuperMario
//
//  Created by jashon on 13-11-7.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "Level.h"

@implementation Level
@synthesize p_bg = m_bg;
@synthesize p_downWorldBg = m_downWorldBg;

- (Level *)initWithLevelNum:(int)num {
    if (self = [super init]) {
        
        switch (num) {
            case 0:
                m_bg = [[CCTMXTiledMap tiledMapWithTMXFile:@"world1-1.tmx"] retain];
                m_downWorldBg = [[CCTMXTiledMap tiledMapWithTMXFile:@"world1-1_down.tmx"] retain];
                break;
    //        case 1:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world1-2.tmx"];
    //            break;
    //        case 2:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world1-3.tmx"];
    //            break;
    //        case 3:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world1-4.tmx"];
    //            break;
    //        case 4:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world2-1.tmx"];
    //            break;
    //        case 5:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world2-2.tmx"];
    //            break;
    //        case 6:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world2-3.tmx"];
    //            break;
    //        case 7:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world2-4.tmx"];
    //            break;
    //        case 8:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world3-1.tmx"];
    //            break;
    //        case 9:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world3-2.tmx"];
    //            break;
    //        case 10:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world3-3.tmx"];
    //            break;
    //        case 11:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world3-4.tmx"];
    //            break;
    //        case 12:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world4-1.tmx"];
    //            break;
    //        case 13:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world4-2.tmx"];
    //            break;
    //        case 14:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world4-3.tmx"];
    //            break;
    //        case 15:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world4-4.tmx"];
    //            break;
    //        case 16:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world5-1.tmx"];
    //            break;
    //        case 17:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world5-2.tmx"];
    //            break;
    //        case 18:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world5-3.tmx"];
    //            break;
    //        case 19:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world5-4.tmx"];
    //            break;
    //        case 20:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world6-1.tmx"];
    //            break;
    //        case 21:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world6-2.tmx"];
    //            break;
    //        case 22:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world6-3.tmx"];
    //            break;
    //        case 23:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world6-4.tmx"];
    //            break;
    //        case 24:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world7-1.tmx"];
    //            break;
    //        case 25:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world7-2.tmx"];
    //            break;
    //        case 26:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world7-3.tmx"];
    //            break;
    //        case 27:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world7-4.tmx"];
    //            break;
    //        case 28:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world8-1.tmx"];
    //            break;
    //        case 29:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world8-2.tmx"];
    //            break;
    //        case 30:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world8-3.tmx"];
    //            break;
    //        case 31:
    //            m_bg = [CCTMXTiledMap tiledMapWithTMXFile:@"world8-4.tmx"];
    //            break;
            default:
                
                break;
        }
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    [m_bg release];
    [m_downWorldBg release];
}

@end
