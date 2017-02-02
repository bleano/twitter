//
//  User.h
//  Twitter 
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *twitterName;
@property (strong, nonatomic) NSString *twitterScreenName;
@property (strong, nonatomic) NSString *twitterDescription;
@property (strong, nonatomic) NSURL *twitterProfileImageURLHTTPS;

- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;

@end
