//
//  MPMainViewController.m
//  MEPlus
//
//  Created by Shanshan ZHAO on 9/7/14.
//  Copyright (c) 2014 APT9. All rights reserved.
//

#import "MPMainViewController.h"
#import "MPBTLEViewController.h"

@interface MPMainViewController () {
    CGFloat _fwidth;
    CGFloat _fheight;
    NSString *_appFont;
    NSString *_username;
    BOOL _verified;
}
@property (weak, nonatomic) UIButton *meButton;
@property (weak, nonatomic) UIButton *plusButton;
@property (weak, nonatomic) UIButton *themButton;
@property (weak, nonatomic) IBOutlet UILabel *verifyAlertLabel;
@property (weak, nonatomic) IBOutlet UIButton *verifyLaterButton;
@property (weak, nonatomic) IBOutlet UIButton *verifyNowButton;

- (IBAction)verifyLater:(id)sender;
- (IBAction)verifyNow:(id)sender;
@end

@implementation MPMainViewController

- (id)initWithUser:(NSString *)username {
    //self = [super init];
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MPMainViewController"];
    if (self) {
        _username = username;
        NSLog(@"USERNAME: %@", _username);
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _fwidth = self.view.frame.size.width;
    _fheight = self.view.frame.size.height;
    _appFont = @"Lantinghei SC";
    _verified = NO;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setup];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    UIButton *meButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _fwidth, _fheight/3)];
    _meButton = meButton;
    [_meButton.titleLabel setFont:[UIFont fontWithName:_appFont size:23]];
    [_meButton setTitle:@"我" forState:UIControlStateNormal];
    [_meButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_meButton addTarget:self action:@selector(editMe) forControlEvents:UIControlEventTouchUpInside];
    [_meButton setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.1]];
    [self.view addSubview:_meButton];
    
    UIButton *plusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _plusButton = plusButton;
    [_plusButton setCenter:self.view.center];
    [_plusButton setBackgroundImage:[UIImage imageNamed:@"plus23.png"] forState:UIControlStateNormal];
    [_plusButton addTarget:self action:@selector(addContact) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_plusButton];
    
    UIButton *themButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _fheight/3*2, _fwidth, _fheight/3)];
    _themButton = themButton;
    [_themButton.titleLabel setFont:[UIFont fontWithName:_appFont size:23]];
    [_themButton setTitle:@"?" forState:UIControlStateNormal];
    [_themButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_themButton addTarget:self action:@selector(contacts) forControlEvents:UIControlEventTouchUpInside];
    [_themButton setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.1]];
    [self.view addSubview:_themButton];
    
    [_verifyAlertLabel setFont:[UIFont fontWithName:_appFont size:16]];
    [_verifyAlertLabel setText:@"需要验证手机号码并初始化我的姓名"];
    [_verifyAlertLabel setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.1]];
    [_verifyAlertLabel setHidden:YES];
    
    [_verifyLaterButton.titleLabel setFont:[UIFont fontWithName:_appFont size:15]];
    [_verifyLaterButton setTitle:@"以后再做" forState:UIControlStateNormal];
    [_verifyLaterButton.layer setBorderWidth:1.0];
    [_verifyLaterButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [_verifyLaterButton setHidden:YES];
    
    [_verifyNowButton.titleLabel setFont:[UIFont fontWithName:_appFont size:15]];
    [_verifyNowButton setTitle:@"现在去做" forState:UIControlStateNormal];
    [_verifyNowButton.layer setBorderWidth:1.0];
    [_verifyNowButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [_verifyNowButton setHidden:YES];
}

- (void)setMainPanelHidden:(BOOL)yesOrNo {
    [_meButton setHidden:yesOrNo];
    [_plusButton setHidden:yesOrNo];
    [_themButton setHidden:yesOrNo];
}

- (void)setVerifyAlertPanelHidden:(BOOL)yesOrNo {
    [_verifyAlertLabel setHidden:yesOrNo];
    [_verifyLaterButton setHidden:yesOrNo];
    [_verifyNowButton setHidden:yesOrNo];
}

#pragma mark - User Interations

- (void)editMe {
    NSLog(@"ME");
    if (_verified) {
        NSLog(@"EDIT PROFILE");
    } else {
        [_verifyAlertLabel setText:[NSString stringWithFormat:@"%@\n\n%@", @"初次编辑我的资料之前", _verifyAlertLabel.text]];
        [self setMainPanelHidden:YES];
        [self setVerifyAlertPanelHidden:NO];
    }
}

- (void)addContact {
    NSLog(@"ADD CONTACT");
    if (_verified) {
        MPBTLEViewController *addContactViewController = [[MPBTLEViewController alloc] init];
        [self addChildViewController:addContactViewController];
        [self.view addSubview:addContactViewController.view];
        [self didMoveToParentViewController:addContactViewController];
    } else {
        [_verifyAlertLabel setText:[NSString stringWithFormat:@"%@\n\n%@", @"初次添加联系人之前", _verifyAlertLabel.text]];
        [self setMainPanelHidden:YES];
        [self setVerifyAlertPanelHidden:NO];
    }
}

- (void)contacts {
    NSLog(@"CONTACTS");
    if (_verified) {
        NSLog(@"ADDRESS BOOK");
    } else {
        [_verifyAlertLabel setText:[NSString stringWithFormat:@"%@\n\n%@", @"初次导入通讯录之前", _verifyAlertLabel.text]];
        [self setMainPanelHidden:YES];
        [self setVerifyAlertPanelHidden:NO];
    }
}

- (IBAction)verifyLater:(id)sender {
    [_verifyAlertLabel setText:@"需要验证手机号码并初始化我的姓名"];
    [self setVerifyAlertPanelHidden:YES];
    [self setMainPanelHidden:NO];
}

- (IBAction)verifyNow:(id)sender {
    _verified = YES;
    
    [_verifyAlertLabel setText:@"需要验证手机号码并初始化我的姓名"];
    [self setVerifyAlertPanelHidden:YES];
    [self setMainPanelHidden:NO];
}
@end
