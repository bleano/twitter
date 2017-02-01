//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Bob Leano on 1/30/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "TwitterClient.h"
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
@property (weak, nonatomic) IBOutlet UIView *retweetView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetIcon;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) NSString *tweetId;
@end

@implementation TweetTableViewCell
- (IBAction)onRetweetButton:(id)sender {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    Tweet *myTweet = twitterClient.mapOfMyTweets[self.tweetId];
    if(myTweet.retweeted) return;
    if(self.tweet.retweetedByUser) return;
    [twitterClient retweetThisId:self.tweetId retweetWithCompletion:^(id response, NSError *error) {
        if(response != nil){
            UIImage *image = [UIImage imageNamed: @"retweet-icon-green@3x.png"];
            [self.retweetButton setImage:image forState:UIControlStateNormal];
            self.tweet.retweetedByUser = YES;
        }else{
            NSLog(@"getTimelineTweets NSError: %@", error.localizedDescription);
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setTweet:(Tweet *)tweet
{
    _tweet = tweet;
    [self reload];
}


- (void)reload
{
    if(self.tweet.content == nil) return;
    UIImage *image = [UIImage imageNamed: @"retweet-icon@3x.png"];
    [self.retweetButton setImage:image forState:UIControlStateNormal];
    self.tweetId = self.tweet.tweetId;
    self.retweetView.hidden = YES;
    if(self.tweet.retweeted){
        self.retweetView.hidden = NO;
        self.retweetLabel.text = self.tweet.retweetedByName;
    }
    self.nameLabel.text = self.tweet.name;
    self.handleLabel.text = self.tweet.handle;
    self.contentLabel.text =  [NSString stringWithFormat:@"%@",self.tweet.content];
    self.timeStampLabel.text =  [NSString stringWithFormat:@"%@", self.tweet.relativeTime];
    [self.profileImageView setImageWithURL: self.tweet.profileImageURL];
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    Tweet *myTweet = twitterClient.mapOfMyTweets[self.tweetId];
    if(myTweet != nil && myTweet.retweetedByUser){
        UIImage *image = [UIImage imageNamed: @"retweet-icon-green@3x.png"];
        [self.retweetButton setImage:image forState:UIControlStateNormal];
    }
    [self needsUpdateConstraints];
    //    if(self.tweet != nil) NSLog(@"\nsetSelected name:%@, handle:%@, content:%@\n\n", self.nameLabel.text, self.handleLabel.text, self.contentLabel.text);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
