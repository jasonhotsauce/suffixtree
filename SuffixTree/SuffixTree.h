//
//  SuffixTree.h
//  SuffixTree
//
//  Created by Wenbin Zhang on 9/7/15.
//  Copyright © 2015 Wenbin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) NSArray *edges;

@end

@interface Edge : NSObject

@property (nonatomic, copy) NSString *value;
@property (nonatomic, strong) Node *nextNode;
@property (nonatomic, assign) NSInteger index;

@end

@interface SuffixTree : NSObject

@property (nonatomic, strong) Node *root;

+ (instancetype)buildTree:(NSString *)str;
- (BOOL)isSubString:(NSString *)string;
@end
