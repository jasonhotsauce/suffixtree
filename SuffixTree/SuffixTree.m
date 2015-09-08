//
//  SuffixTree.m
//  SuffixTree
//
//  Created by Wenbin Zhang on 9/7/15.
//  Copyright © 2015 Wenbin Zhang. All rights reserved.
//

#import "SuffixTree.h"

@implementation Node

@end

@implementation Edge

@end

@implementation SuffixTree

+ (instancetype)buildTree:(NSString *)str
{
    Node *root = [[Node alloc] init];
    for (NSInteger i = str.length - 1; i >= 0; i--) {
        NSString *suffix = [str substringFromIndex:i];
        [self insertSuffix:suffix toNode:root];
    }
    SuffixTree *tree = [[SuffixTree alloc] init];
    tree.root = root;
    return tree;
}

+ (void)insertSuffix:(NSString *)suffix toNode:(Node *)root
{
    if (!root.edges) {
        Edge *edge = [[Edge alloc] init];
        edge.value = suffix;
        root.edges = [NSArray arrayWithObject:edge];
    } else {
        for (NSInteger i = 0; i < root.edges.count; i++) {
            Edge *edge = root.edges[i];
            BOOL isPath = YES;
            NSInteger index = 0;
            while (index < edge.value.length) {
                if (![[edge.value substringWithRange:NSMakeRange(index, 1)] isEqualToString:[suffix substringWithRange:NSMakeRange(index, 1)]]) {
                    isPath = NO;
                    break;
                }
                index++;
            }
            if (isPath) {
                if (edge.nextNode) {
                    [self insertSuffix:[suffix substringFromIndex:index] toNode:edge.nextNode];
                } else {
                    Node *node = [[Node alloc] init];
                    Edge *suEdge = [[Edge alloc] init];
                    suEdge.value = [suffix substringFromIndex:index];
                    node.edges = [NSArray arrayWithObject:suEdge];
                    edge.nextNode = node;
                }
                return;
            }
        }
        Edge *edge = [[Edge alloc] init];
        edge.value = suffix;
        NSMutableArray *rootEdges = [root.edges mutableCopy];
        [rootEdges addObject:edge];
        root.edges = [rootEdges copy];
    }
}

- (BOOL)isSubString:(NSString *)string
{
    return [self searchSubString:string fromNode:self.root];
}

- (BOOL)searchSubString:(NSString *)string fromNode:(Node *)node
{
    if (node.edges.count == 0) {
        return NO;
    }
    for (Edge *edge in node.edges) {
        BOOL isPath = YES;
        NSInteger index = 0;
        while (index < edge.value.length && index < string.length) {
            if (![[edge.value substringWithRange:NSMakeRange(index, 1)] isEqualToString:[string substringWithRange:NSMakeRange(index, 1)]]) {
                isPath = NO;
                break;
            }
            index++;
        }
        if (isPath) {
            if (index == string.length) {
                return YES;
            } else {
                if (edge.nextNode) {
                    return [self searchSubString:[string substringFromIndex:index] fromNode:edge.nextNode];
                }
            }
        }
    }
    return NO;
}

@end
