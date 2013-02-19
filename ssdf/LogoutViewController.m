//
//  LogoutViewController.m
//  ssdf
//
//  Created by Adarsh Ramakrishnan on 2/17/13.
//  Copyright (c) 2013 Adarsh Ramakrishnan. All rights reserved.
//

#import "LogoutViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.messageBox.text = [NSString stringWithFormat:@"Welcome %@. You have logged in %i times.", self.username, self.count];
}

-(void)setupViews
{
    // setup message box at top
    self.messageBox = [[UITextView alloc] initWithFrame:CGRectMake(22, 22, 290, 73)];
    self.messageBox.layer.borderWidth = 1.0f;
    self.messageBox.layer.borderColor = [[UIColor blueColor] CGColor];
    [self.view addSubview:self.messageBox];
    
    // setup logout button
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    self.logoutButton.frame = CGRectMake(95, 168, 131, 49);
    [self.logoutButton addTarget:self action:@selector(logoutPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
}

-(void)logoutPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
