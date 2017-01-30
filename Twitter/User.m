//
//  User.m
//  Twitter 
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary{
    self = [super init];
    if(self){
        self.twitterName = jsonDictionary[@"name"];
        self.twitterScreenName = jsonDictionary[@"screen_name"];
        self.twitterDescription = jsonDictionary[@"description"];
        NSString *urlString = jsonDictionary[@"profile_image_url_https"];
        self.twitterProfileImageURLHTTPS = [NSURL URLWithString:urlString];
    }
    return self;
}
@end
