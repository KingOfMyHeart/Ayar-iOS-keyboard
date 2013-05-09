//
//  UTViewController.m
//  iOS Custom Keyboards
//
//  Created by Kulpreet Chilana on 11/6/12.
//  Copyright (c) 2012 Kulpreet Chilana. All rights reserved.
//

#import "UTViewController.h"

@interface UTViewController ()

@end

@implementation UTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        PMCustomKeyboard *customKeyboard = [[PMCustomKeyboard alloc] init];
        [customKeyboard setTextView:self.textView];
        
    }
    else {
        PKCustomKeyboard *customKeyboard = [[PKCustomKeyboard alloc] init];
        [customKeyboard setTextView:self.textView];
    }
    [self.textView setFont:[UIFont fontWithName:@"Ayar_pub" size:16]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
