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
        self.content = jsonDictionary[@"text"];
        NSDictionary  *userDictionary = jsonDictionary[@"user"];
        self.handle = userDictionary[@"screen_name"];
        self.name = userDictionary[@"name"];
        NSString *urlString = userDictionary[@"profile_image_url_https"];
        self.profileImageURL = [NSURL URLWithString: urlString];
//        NSLog(@"\n\nTweet initWithDictionary content:%@, handle:%@, name:%@, image:%@\n\n", self.content, self.handle, self.name, urlString);
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
