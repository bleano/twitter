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
        self.retweeted = NO;
        self.content = jsonDictionary[@"text"];
        NSString *createdAt = jsonDictionary[@"created_at"];
        self.relativeTime = [self dateDiff:createdAt];
        NSDictionary  *userDictionary = jsonDictionary[@"user"];
        NSDictionary *retweetedInfo = jsonDictionary[@"retweeted_status"];
        if(retweetedInfo != nil){
            NSDictionary  *retweetedInfoUserDictionary = retweetedInfo[@"user"];
            self.handle = retweetedInfoUserDictionary[@"screen_name"];
            self.name = retweetedInfoUserDictionary[@"name"];
            self.retweetedByName = [NSString stringWithFormat:@"%@ Retweeted", userDictionary[@"name"]];
            self.retweeted = YES;
            self.profileImageURL = [NSURL URLWithString: retweetedInfoUserDictionary[@"profile_image_url_https"]];
        }else{
            self.handle = userDictionary[@"screen_name"];
            self.name = userDictionary[@"name"];
            self.profileImageURL = [NSURL URLWithString: userDictionary[@"profile_image_url_https"]];
        }
    }
    return self;
}
+ (NSArray*) tweetsWithArray:(NSArray *) array{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    for(Tweet *tweet in tweets){
        NSLog(@"\n\n\tcontent:[%@], \n\thandle:[%@], \n\tname:[%@], \n\timage:[%@]\n\n", tweet.content, tweet.handle, tweet.name, tweet.profileImageURL.absoluteString);
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
