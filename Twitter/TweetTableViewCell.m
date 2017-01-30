//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Bob Leano on 1/30/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TweetTableViewCell.h"

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
    self.contentLabel.text = @"VP of Ops w/Multi Platform Ad Company, addicted to Diet Coke & Peanut Butter (really), Excel Nerd, Mother, Wife, Support System & Cheerleader to all who know me.";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
