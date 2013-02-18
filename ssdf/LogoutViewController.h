//
//  LogoutViewController.h
//  ssdf
//
//  Created by Adarsh Ramakrishnan on 2/17/13.
//  Copyright (c) 2013 Adarsh Ramakrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutViewController : UIViewController

@property (nonatomic, strong) UITextView *messageBox;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, assign) int count;

@end
