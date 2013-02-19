//
//  LoginViewController.m
//  ssdf
//
//  Created by Adarsh Ramakrishnan on 2/17/13.
//  Copyright (c) 2013 Adarsh Ramakrishnan. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LogoutViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)setupButtons
{
    self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 120, 24)];
    self.userLabel.text = @"Username: ";
    self.userLabel.font = [UIFont fontWithName:@"Calibri" size:20.0];
    [self.view addSubview:self.userLabel];
    
    self.passLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 120, 24)];
    self.passLabel.text = @"Password: ";
    self.passLabel.font = [UIFont fontWithName:@"Calibri" size:20.0];
    [self.view addSubview:_passLabel];
    
    // create message box at top
    self.messageBox = [[UITextView alloc] initWithFrame:CGRectMake(25, 26, 290, 73)];
    self.messageBox.text = @"Please enter your username and password";
    self.messageBox.font = [UIFont fontWithName:@"Calibri" size:24.0];
    self.messageBox.layer.borderWidth = 1.0f;
    self.messageBox.editable = NO;
    self.messageBox.layer.borderColor = [[UIColor blueColor] CGColor];
    [self.view addSubview:self.messageBox];
    
    // create username field
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(117, 117, 183, 30)];
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.delegate = self;
    [self.view addSubview:self.usernameField];
    
    // create password field
    self.passField = [[UITextField alloc] initWithFrame:CGRectMake(117, 165, 183, 30)];
    self.passField.borderStyle = UITextBorderStyleRoundedRect;
    self.passField.delegate = self;
    [self.view addSubview:self.passField];
    
    // create login button
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(20, 247, 131, 49);
    [self.loginButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    // create add user button
    self.addUserButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addUserButton setTitle:@"Add User" forState:UIControlStateNormal];
    self.addUserButton.frame = CGRectMake(169, 247, 131, 49);
    [self.addUserButton addTarget:self action:@selector(addUserPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addUserButton];
}

- (void)viewDidLoad
{
    [self setupButtons];
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    
    self.httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://young-dawn-5882.herokuapp.com/"]];
    [self.httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    self.httpClient.parameterEncoding = AFJSONParameterEncoding;
	// Do any additional setup after loading the view.
}

-(void)loginPressed
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text, @"user", self.passField.text, @"password", nil];
    [self.httpClient postPath:@"/users/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int errCode = ((NSString *)[responseObject objectForKey:@"errCode"]).intValue;
        switch (errCode) {
            case 1:
            {
                int count = ((NSString *) [responseObject objectForKey:@"count"]).intValue;
                LogoutViewController *successVC = [[LogoutViewController alloc] init];
                successVC.count = count;
                successVC.username = self.usernameField.text;
                [self presentViewController:successVC animated:YES completion:nil];
                
            }
                break;
            case -1:
            {
                self.messageBox.text = @"Invalid username and password combination. Please try again.";
            }
                break;
            default:
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
    
}

-(void)addUserPressed
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text, @"user", self.passField.text, @"password", nil];
    [self.httpClient postPath:@"/users/add" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int errCode = ((NSString *)[responseObject objectForKey:@"errCode"]).intValue;
        switch (errCode) {
            case 1:
            {
                int count = ((NSString *) [responseObject objectForKey:@"count"]).intValue;
                LogoutViewController *successVC = [[LogoutViewController alloc] init];
                successVC.username = self.usernameField.text;
                successVC.count = count;
                [self presentViewController:successVC animated:YES completion:nil];
            }
                break;
            case -2:
            {
                [self.messageBox setText:@"This user name already exists. Please try again."];
            }
                break;
            case -3:
            {
                self.messageBox.text = @"The user name should be non-empty and at most 128 characters long. Please try again.";
            }
                break;
            case -4:
            {
                self.messageBox.text = @"The password should be at most 128 characters long. Please try again.";
            }
                break;
            default:
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
