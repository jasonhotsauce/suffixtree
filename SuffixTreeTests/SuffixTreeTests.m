//
//  SuffixTreeTests.m
//  SuffixTreeTests
//
//  Created by Wenbin Zhang on 9/7/15.
//  Copyright © 2015 Wenbin Zhang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SuffixTree.h"

@interface SuffixTreeTests : XCTestCase

@end

@implementation SuffixTreeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItBuildsTheCorrectTree {
    SuffixTree *tree = [SuffixTree buildTree:@"BANANA"];
    XCTAssertEqual(tree.root.edges.count, 3, @"From root, tree should have 3 edges");
    Edge *firstEdge = tree.root.edges[0];
    XCTAssertEqualObjects(firstEdge.value, @"A");
    Node *firstEdgeNode = firstEdge.nextNode;
    XCTAssertNotNil(firstEdgeNode);
    XCTAssertEqual(firstEdgeNode.edges.count, 1);
    Edge *firstEdgeNodeEdge = firstEdgeNode.edges[0];
    XCTAssertEqualObjects(firstEdgeNodeEdge.value, @"NA");
    Node *firstEdgeNodeEdgeNode = firstEdgeNodeEdge.nextNode;
    XCTAssertNotNil(firstEdgeNodeEdgeNode);
    XCTAssertEqual(firstEdgeNodeEdgeNode.edges.count, 1);
    Edge *firstEndEdge = firstEdgeNodeEdgeNode.edges[0];
    XCTAssertEqualObjects(firstEndEdge.value, @"NA");
}

- (void)testThatItCanSearchSubStringCorrectly {
    SuffixTree *tree = [SuffixTree buildTree:@"BANANA"];
    BOOL isSubString = [tree isSubString:@"BCD"];
    XCTAssertFalse(isSubString);
    
    BOOL shouldBeTrue = [tree isSubString:@"NAN"];
    XCTAssertTrue(shouldBeTrue);
}

@end
