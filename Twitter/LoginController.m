//
//  LoginController.m
//  Twitter
//
//  Created by Bob Leano on 1/30/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "LoginController.h"
#import "TwitterClient.h"
@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onLoginButtonPushed:(id)sender {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    [twitterClient loginWithCompletion:^(User *user, NSError *error) {
        if(user != nil){
            NSLog(@"HELLO: %@", user.twitterName);
        }else{
            //error view
        }

    }];
}

@end
