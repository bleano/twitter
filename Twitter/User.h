//
//  User.h
//  Twitter 
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (weak, nonatomic) NSString *twitterName;
@property (weak, nonatomic) NSString *twitterScreenName;
@property (weak, nonatomic) NSString *twitterDescription;
@property (weak, nonatomic) NSURL *twitterProfileImageURLHTTPS;

- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;

@end
