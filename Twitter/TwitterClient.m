//
//  TwitterClient.m
//  Twitter
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

NSString * const consumerKey = @"geqayCv0xeIIBmRmr6DcIpWt1";
NSString * const consumerSecret = @"SCoHYUvLwW1ugOGw4s5bDMh1fBs3vRreH9ad1uscMBCG7oGPlq";
NSString * const baseUrl = @"https://api.twitter.com";

@interface TwitterClient()
@property (nonatomic, strong) void (^loginCompletion) (User *user, NSError *error);
@property (strong, nonatomic) NSArray<Tweet *> *clientTweets;
@end



@implementation TwitterClient
static TwitterClient *sharedInstance = nil;

+ (TwitterClient *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[super alloc] initWithBaseURL:[NSURL URLWithString: baseUrl ] consumerKey: consumerKey consumerSecret: consumerSecret];
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

- (NSArray *) homeTimeline {
    [sharedInstance
     GET:@"1.1/statuses/home_timeline.json"
     parameters:nil
     progress:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         NSMutableArray *_tweets = [NSMutableArray array];
         NSArray *tweets = [Tweet tweetsWithArray:responseObject];
         for(Tweet *tweet in tweets){
             NSLog(@"tweet: %@", tweet.text);
             [_tweets addObject:tweet];
         }
         self.clientTweets = _tweets;
     }
     failure:^(NSURLSessionTask *task, NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
     }];
    return _clientTweets;
}

- (void) loginWithCompletion:( void (^)(User *user, NSError *error))completion{
    self.loginCompletion = completion;
    [self deauthorize];
    [self
     fetchRequestTokenWithPath:@"oauth/request_token"
     method:@"GET"
     callbackURL:[NSURL URLWithString:@"twitterproj://oauth"]
     scope:nil
     success:^(BDBOAuth1Credential *requestToken) {
         NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
         NSLog(@"requestToken.token: %@", requestToken.token);
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
     }
     failure:^(NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
         self.loginCompletion(nil, error);
     }
     ];
}

- (void) openURL: (NSURL *)url{
    BDBOAuth1Credential *credential = [BDBOAuth1Credential credentialWithQueryString: url.query];
    [self
     fetchAccessTokenWithPath:@"oauth/access_token"
     method:@"POST"
     requestToken:credential
     success:^(BDBOAuth1Credential *requestToken) {
         NSLog(@"access_token: %@", requestToken.token);
         [self.requestSerializer saveAccessToken: requestToken];
         [self
          GET:@"1.1/account/verify_credentials.json"
          parameters:nil
          progress:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              User *user = [[User alloc] initWithDictionary: responseObject];
              NSLog(@"user: %@", user.twitterScreenName);
              self.loginCompletion(user, nil);
          }
          failure:^(NSURLSessionTask *task, NSError *error) {
              NSLog(@"Error: %@", error.localizedDescription);
              self.loginCompletion(nil, error);
          }];
     }
     failure:^(NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
     }];

    
}


@end
