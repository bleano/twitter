//
//  TwitterClient.m
//  Twitter
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"
NSString * const consumerKey = @"geqayCv0xeIIBmRmr6DcIpWt1";
NSString * const consumerSecret = @"SCoHYUvLwW1ugOGw4s5bDMh1fBs3vRreH9ad1uscMBCG7oGPlq";
NSString * const baseUrl = @"https://api.twitter.com";

@implementation TwitterClient
static TwitterClient *sharedInstance = nil;

+ (TwitterClient *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[super alloc] initWithBaseURL:[NSURL URLWithString: baseUrl ] consumerKey: @"geqayCv0xeIIBmRmr6DcIpWt1" consumerSecret: consumerSecret];
        }
    });
    return sharedInstance;
}

- (void) currentAccount {
    [sharedInstance
     GET:@"1.1/account/verify_credentials.json"
     parameters:nil
     progress:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         User *user = [[User alloc] initWithDictionary: responseObject];
         NSLog(@"user: %@", user.twitterScreenName);
     }
     failure:^(NSURLSessionTask *task, NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
     }];
}

- (void) homeTimeline {
    [sharedInstance
     GET:@"1.1/statuses/home_timeline.json"
     parameters:nil
     progress:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"home_timeline.json: %@", responseObject);
     }
     failure:^(NSURLSessionTask *task, NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
     }];
    
}


@end
