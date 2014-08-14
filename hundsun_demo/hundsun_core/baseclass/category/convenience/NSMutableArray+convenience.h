//
//  NSMutableArray+convenience.h
//
//  Created by in 't Veen Tjeerd on 5/10/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Convenience)

//将from下的对象 移到to位置
- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
