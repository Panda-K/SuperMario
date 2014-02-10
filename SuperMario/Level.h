//
//  Level.h
//  SuperMario
//
//  Created by jashon on 13-11-7.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

@interface Level : NSObject {
    CCTMXTiledMap *m_bg;
    CCTMXTiledMap *m_downWorldBg;
}
@property (nonatomic, retain) CCTMXTiledMap *p_bg;
@property (nonatomic, retain) CCTMXTiledMap *p_downWorldBg;

- (Level *) initWithLevelNum:(int) num;
@end
