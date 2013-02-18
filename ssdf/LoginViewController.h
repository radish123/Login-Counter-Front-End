//
//  LoginViewController.h
//  ssdf
//
//  Created by Adarsh Ramakrishnan on 2/17/13.
//  Copyright (c) 2013 Adarsh Ramakrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>


@property (nonatomic, strong) UILabel *passLabel;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UITextField *passField;
@property (nonatomic, strong) UITextView *messageBox;
@property (nonatomic, strong) UIButton *addUserButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) AFHTTPClient *httpClient;

@end
