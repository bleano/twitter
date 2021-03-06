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
@property (strong, nonatomic) IBOutlet UITableView *tweetTableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControlForTableView;
@end

@implementation TweetListViewController

- (void)foo {
    NSLog(@"FOO");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc]initWithTitle:@"COMPOSE" style:UIBarButtonItemStylePlain target:self action: @selector(foo)];
    self.navigationItem.rightBarButtonItem = composeButton;
    UIRefreshControl *uiRefreshControl = [[UIRefreshControl alloc]init];
    self.refreshControlForTableView = uiRefreshControl;
    [self.tweetTableView addSubview:uiRefreshControl];
    [self.refreshControlForTableView addTarget:self action:@selector(getTimelineTweets) forControlEvents:UIControlEventValueChanged];
    self.tweetTableView.dataSource = self;
    self.tweetTableView.estimatedRowHeight = 500;
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
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetTableViewCell *tweetTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    Tweet * tweet = [twitterClient.timelineTweets objectAtIndex:indexPath.row];
//    NSLog(@"\n\n cellForRowAtIndexPath content:%@, handle:%@, name:%@, image:%@\n\n", tweet.content, tweet.handle, tweet.name, tweet.profileImageURL.absoluteString);
    tweetTableViewCell.tweet = tweet;
    [tweetTableViewCell reload];
    return tweetTableViewCell;
}

- (void) getTimelineTweets {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    [twitterClient getTweetsWithCompletion:^(NSArray *tweets, NSError *error) {
        if(tweets != nil){
            self.tweets = tweets;
            [twitterClient getMyTweetsWithCompletion:^(NSArray *tweets, NSError *error) {
                if(tweets != nil){
                    [self performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone: NO];
                }else{
                    NSLog(@"getMyTweetsWithCompletiond NSError: %@", error.localizedDescription);
                }
            }];
        }else{
            NSLog(@"getTimelineTweets NSError: %@", error.localizedDescription);
        }
    }];
}

- (void) reload{
    [self.refreshControlForTableView endRefreshing];
    [self.tweetTableView reloadData];

}



@end
