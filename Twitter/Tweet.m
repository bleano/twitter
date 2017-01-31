//
//  Tweet.m
//  TwitterDemo
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary{
    self = [super init];
    if(self){
        self.text = jsonDictionary[@"text"];
    }
    return self;
}
+ (NSArray*) tweetsWithArray:(NSArray *) array{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
@end
