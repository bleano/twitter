//
//  Tweet.h
//  Twitter
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (weak, nonatomic) NSString *content;
@property (weak, nonatomic) NSString *handle;
@property (weak, nonatomic) NSString *name;
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;
+ (NSArray*) tweetsWithArray:(NSArray *) array;
@end
