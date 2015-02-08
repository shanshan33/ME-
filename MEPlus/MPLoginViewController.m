//
//  MPViewController.m
//  MEPlus
//
//  Created by Shanshan ZHAO on 9/7/14.
//  Copyright (c) 2014 APT9. All rights reserved.
//

#import "MPLoginViewController.h"
#import "MPMainViewController.h"

@interface MPLoginViewController () {
    CGFloat _fwidth;
    CGFloat _fheight;
    NSString *_appFont;
}
@property (weak, nonatomic) UILabel *startLabel;
@property (weak, nonatomic) UILabel *upLabel;
@property (weak, nonatomic) UILabel *downLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okayButton;
- (IBAction)cancel:(id)sender;
- (IBAction)okay:(id)sender;
@end

@implementation MPLoginViewController

#define TAG_START_LABEL 10

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _fwidth = self.view.frame.size.width;
    _fheight = self.view.frame.size.height;
    _appFont = @"Lantinghei SC";
    
    [self setup];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** Setup the appearences as loading the view.
 */
- (void)setup {
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _fheight/3, _fwidth, _fheight/3)];
    _startLabel = startLabel;
    [_startLabel setCenter:self.view.center];
    [_startLabel setFont:[UIFont fontWithName:_appFont size:20]];
    [_startLabel setTextAlignment:NSTextAlignmentCenter];
    [_startLabel setNumberOfLines:8];
    [_startLabel setText:@"我 是"];
    [_startLabel setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.1]];
    [_startLabel setTag:TAG_START_LABEL];
    [self.view addSubview:_startLabel];
    
    [_startLabel setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *dragStartLabel = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragLabel:)];
    [_startLabel addGestureRecognizer:dragStartLabel];
    
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _fwidth, _fheight/3)];
    _upLabel = upLabel;
    [_upLabel setFont:[UIFont fontWithName:_appFont size:17]];
    [_upLabel setTextAlignment:NSTextAlignmentCenter];
    [_upLabel setText:@"新用户"];
    [_upLabel setHidden:YES];
    [self.view addSubview:_upLabel];
    
    UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _fheight/3*2, _fwidth, _fheight/3)];
    _downLabel = downLabel;
    [_downLabel setFont:[UIFont fontWithName:_appFont size:17]];
    [_downLabel setTextAlignment:NSTextAlignmentCenter];
    [_downLabel setText:@"已注册用户"];
    [_downLabel setHidden:YES];
    [self.view addSubview:_downLabel];

    [_usernameTextField setFont:[UIFont fontWithName:_appFont size:15]];
    [_usernameTextField setText:@"用户名"];
    [_usernameTextField setTintColor:[UIColor blackColor]];
    [_usernameTextField setHidden:YES];
    
    [_passwordTextField setFont:[UIFont fontWithName:_appFont size:15]];
    [_passwordTextField setText:@"密码"];
    [_passwordTextField setTintColor:[UIColor blackColor]];
    [_passwordTextField setHidden:YES];
    
    [_cancelButton setHidden:YES];
    
    [_okayButton setHidden:YES];
    
}

/** Reset the appearences to the first load
 */
- (void)reset {
    [_upLabel setHidden:YES];
    [_downLabel setText:@"已注册用户"];
    [_downLabel setHidden:YES];
    [_usernameTextField setHidden:YES];
    [_usernameTextField setText:@"用户名"];
    [_passwordTextField setHidden:YES];
    [_passwordTextField setText:@"密码"];
    [_cancelButton setHidden:YES];
    [_okayButton setHidden:YES];
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_startLabel setHidden:NO];
}

#pragma mark - User Interactions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view.tag == TAG_START_LABEL) {
        [_startLabel setFont:[UIFont fontWithName:_appFont size:16]];
        [_startLabel setText:@"⇡\n\n\n我 是\n\n\n⇣"];
        [_startLabel setAlpha:0.5];
        [_upLabel setHidden:NO];
        [_downLabel setHidden:NO];
    }
    if ([_usernameTextField isFirstResponder] && [touch view] != _usernameTextField) {
        [_usernameTextField resignFirstResponder];
    }
    if ([_passwordTextField isFirstResponder] && [touch view] != _passwordTextField) {
        [_passwordTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.view.tag == TAG_START_LABEL) {
        [_startLabel setFont:[UIFont fontWithName:_appFont size:20]];
        [_startLabel setText:@"我 是"];
        [_upLabel setHidden:YES];
        [_downLabel setHidden:YES];
        [_startLabel setAlpha:1.0];
    }
}

- (void)dragLabel:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:gesture.view];
	[gesture.view setCenter:CGPointMake(gesture.view.center.x, gesture.view.center.y + translation.y)];
	[gesture setTranslation:CGPointZero inView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [_startLabel setFont:[UIFont fontWithName:_appFont size:20]];
        [_startLabel setText:@"我 是"];
        [_upLabel setHidden:YES];
        [_downLabel setHidden:YES];
        if (_startLabel.center.y <= _upLabel.center.y + 85) { // Reached up label
            [_startLabel setCenter:self.view.center];
            [_startLabel setHidden:YES];
            [_downLabel setHidden:NO];
            [_downLabel setText:@"注册"];
            [_usernameTextField setHidden:NO];
            [_passwordTextField setHidden:NO];
            [_cancelButton setHidden:NO];
            [_okayButton setHidden:NO];
        }
        else if (_startLabel.center.y >= _downLabel.center.y - 85) { // Reached down label
            [_startLabel setCenter:self.view.center];
            [_startLabel setHidden:YES];
            [_downLabel setHidden:NO];
            [_downLabel setText:@"登录"];
            [_usernameTextField setHidden:NO];
            [_passwordTextField setHidden:NO];
            [_cancelButton setHidden:NO];
            [_okayButton setHidden:NO];
        } else {
            [_startLabel setCenter:self.view.center];
        }
        [_startLabel setAlpha:1.0];
    }
}

- (IBAction)cancel:(id)sender {
    [self reset];
}

- (IBAction)okay:(id)sender {
    [self reset];
    NSString *username = _usernameTextField.text; // ?
    MPMainViewController *mainViewController = [[MPMainViewController alloc] initWithUser:username];
    [self presentViewController:mainViewController animated:NO completion:nil];
}

@end
