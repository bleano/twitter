//
//  TwitterClient.h
//  Twitter 
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1SessionManager
+ (TwitterClient *)sharedInstance;
- (void) currentAccount;
- (void) loginWithCompletion:( void (^)(User *user, NSError *error))completion;
- (void) getTweetsWithCompletion:( void (^)(NSArray *tweets, NSError *error))completion;
- (void) openURL: (NSURL *)url;
@property (strong, nonatomic) NSArray<Tweet *> *timelineTweets;
@end
