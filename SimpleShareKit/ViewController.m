//
//  ViewController.m
//  SimpleShareKit
//
//  Created by redoan on 6/6/13.
//  Copyright (c) 2013 redoan.com. All rights reserved.
//

#import "ViewController.h"
#import "ShareKit.h"

@interface ViewController ()<SimpleShareKitDelegate>
{
    ShareKit *share;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)email:(id)sender{
    share = [[ShareKit alloc] init];
    [share setDelegate:self];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    @"LINK NAME", @"name",
    @"CAPTION", @"caption",
    @"http://www.redoan.com", @"link",
    @"http://victorysites.org/apps/terryberry/logo.png", @"picture",
    @"DESCRIPTION", @"description",
     nil];
    
    [share postOnFriendsWall:self withOptions:param];
}

-(void)shareKitSharingFailed:(int)type{
    switch (type) {
        case skFailureEmailCanceled:
            NSLog(@"CANCEL DELEGATE");
            break;
            
        case skFailureEmailError:
            NSLog(@"ERROR DELEGATE");
            break;
            
        default:
            break;
    }
}

-(void)shareKitSharingFinished:(int)type{
    switch (type) {
        case skFinishedEmailSaved:
            NSLog(@"Saved DELEGATE");
            break;
            
        case skFinishedEmailSent:
            NSLog(@"Sent DELEGATE");
            break;
            
        default:
            break;
    }
}


@end
