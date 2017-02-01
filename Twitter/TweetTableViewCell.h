//
//  TweetTableViewCell.h
//  Twitter
//
//  Created by Bob Leano on 1/30/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightConstraint;
@property (weak, nonatomic) Tweet *tweet;

- (void)reload;

@end
