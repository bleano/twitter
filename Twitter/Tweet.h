//
//  Tweet.h
//  Twitter
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (strong, nonatomic) NSString *relativeTime;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *tweetId;
@property (strong, nonatomic) NSString *retweetedInfoTweetId;
@property (strong, nonatomic) NSURL *profileImageURL;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, assign) BOOL alreadyRetweeted;
@property (nonatomic, assign) BOOL retweetedByUser;
@property (strong, nonatomic) NSString *retweetedByName;
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary fromUserTimeline: (BOOL) fromUserTimeline;
+ (NSArray*) tweetsWithArray:(NSArray *) array fromUserTimeline: (BOOL) fromUserTimeline;
@end
