//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Bob Leano on 1/30/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@interface TweetTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.text = @"Karen Scorelli";
    self.handleLabel.text = @"KCSorrelliKCSorrelliKCSorrelliKCSorrelliKCSorrelliKCSorrelli";
    self.timeStampLabel.text = @"4h";
    self.contentLabel.text = @"Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger. The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(self.tweet.content == nil) return;
    self.nameLabel.text = self.tweet.name;
    self.handleLabel.text = self.tweet.handle;
    self.contentLabel.text =  [NSString stringWithFormat:@"%@",self.tweet.content];
    self.timeStampLabel.text =  [NSString stringWithFormat:@"%@", self.tweet.relativeTime];
    [self.profileImageView setImageWithURL: self.tweet.profileImageURL];
//    if(self.tweet != nil) NSLog(@"\nsetSelected name:%@, handle:%@, content:%@\n\n", self.nameLabel.text, self.handleLabel.text, self.contentLabel.text);
}

@end
