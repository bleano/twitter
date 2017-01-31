//
//  Tweet.h
//  Twitter
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *profileImageURL;
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;
+ (NSArray*) tweetsWithArray:(NSArray *) array;
@end
