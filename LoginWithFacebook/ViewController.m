//
//  ViewController.m
//  LoginWithFacebook
//
//  Created by mac developer on 7/11/13.
//  Copyright (c) 2013 mac developer. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController () <FBLoginViewDelegate>

@property(nonatomic, strong) IBOutlet UILabel *lblFirstName;
@property(nonatomic, strong) IBOutlet FBProfilePictureView *fbProfilePic;
@property(nonatomic, strong) id<FBGraphUser> loggedInUser;
@property(nonatomic, strong) IBOutlet UILabel *lblStatus;
@property(nonatomic, strong) IBOutlet UILabel *lblLocation;


@end

@implementation ViewController

@synthesize lblFirstName = _lblFirstName;
@synthesize fbProfilePic = _fbProfilePic;
@synthesize loggedInUser = _loggedInUser;
@synthesize lblStatus = _lblStatus;
@synthesize lblLocation = _lblLocation;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.readPermissions = @[@"email", @"user_likes"];
    loginview.publishPermissions = @[@"publish_actions"];
    loginview.defaultAudience = FBSessionDefaultAudienceFriends;
    
    loginview.frame = CGRectOffset(loginview.frame, 5, 5);
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    /*[self UpdateView];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if(!delegate.session.isOpen){
        delegate.session  = [[FBSession alloc] init];
        
        if(delegate.session.state == FBSessionStateCreatedTokenLoaded){
            [self openLoginHandler];
        }
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(void)UpdateView{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if(!delegate.session.isOpen){
        [self.btnLoginFacebook setTitle:@"Log in" forState:UIControlStateNormal];
        //[self.textNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@", delegate.session.accessTokenData.accessToken]];
    }else{
        [self.btnLoginFacebook setTitle:@"Log out" forState:UIControlStateNormal];
    }
}

-(IBAction)btnLoginHandler:(id)sender{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if(!delegate.session.isOpen){
        if(delegate.session.state != FBSessionStateCreated){
            delegate.session = [[FBSession alloc] init];
        }
        
        [self openLoginHandler];
    }else{
        [delegate.session closeAndClearTokenInformation];
    }
}

-(void)openLoginHandler{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        
        delegate.session = session;
        
        [self UpdateView];
    }];
    
    
    [delegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        [self UpdateView];
    }];
}
*/


#pragma mark - FBLoginViewDelegate

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    self.lblFirstName.text = [NSString stringWithFormat:@"Hello %@", user.first_name];
    self.fbProfilePic.profileID = user.id;
    self.loggedInUser = user;
    self.lblLocation.text = user.location.name;
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.lblStatus.text = @"login";
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.fbProfilePic.profileID = nil;
    self.lblFirstName.text = @"";
    self.lblStatus.text = @"logout";
    self.lblLocation.text = @"";
}

-(void) loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"Error %@", error);
}
@end
