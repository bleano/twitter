//
//  TweetListViewController.m
//  Twitter
//
//  Created by Bob Leano on 1/30/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
@interface TweetListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTableView.dataSource = self;
    self.tweetTableView.estimatedRowHeight = 200;
    self.tweetTableView.rowHeight = UITableViewAutomaticDimension;
    UINib *uiNib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tweetTableView registerNib:uiNib forCellReuseIdentifier:@"TweetTableViewCell"];
    [self getTimelineTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetTableViewCell *tweetTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    return tweetTableViewCell;
}

- (void) getTimelineTweets {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    [twitterClient getTweetsWithCompletion:^(NSArray *tweets, NSError *error) {
        if(tweets != nil){
            for(Tweet *tweet in tweets){
            NSLog(@"timelineTweet: %@", tweet.text);
            }

        }else{
            //error view
        }
    }];
}

@end
