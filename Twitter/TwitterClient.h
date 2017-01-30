//
//  TwitterClient.h
//  Twitter
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>

@interface TwitterClient : BDBOAuth1SessionManager
+ (TwitterClient *)sharedInstance;
- (void) currentAccount;
- (void) homeTimeline;
@end
