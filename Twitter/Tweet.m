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
        NSString *createdAt = jsonDictionary[@"created_at"];
        self.relativeTime = [self dateDiff:createdAt];
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

- (NSString *)dateDiff:(NSString *)createdAtDate {
    //"created_at": "Tue Aug 28 21:16:23 +0000 2012",

    NSDateFormatter *frm = [[NSDateFormatter alloc] init];
    [frm setDateStyle:NSDateFormatterLongStyle];
    [frm setFormatterBehavior:NSDateFormatterBehavior10_4];
    [frm setDateFormat: @"EEE MMM d HH:mm:ss Z y"];
    NSDate *newDate = [frm dateFromString:createdAtDate];
    NSDate *todayDate = [NSDate date];
    double ti = [newDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"never";
    } else  if (ti < 60) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%ds", diff];
    } else if (ti < 3600) {
        //1 hour
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%dm", diff];
    } else if (ti < 86400) {
        //24 hours
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%dh", diff];
    } else if (ti < 2629743) {
        //30 days
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%dd", diff];
    } else {
        return @"never";
    }
}
@end
