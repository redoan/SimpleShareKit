//
//  ViewController.m
//  SimpleShareKit
//
//  Created by redoan on 6/6/13.
//  Copyright (c) 2013 redoan.com. All rights reserved.
//

#import "ViewController.h"
#import "ShareKit.h"
#import "myAlertView.h"

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
    share = [[ShareKit alloc] init];
    [share setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)email:(id)sender{

    [share shareViaEmailWithSubject:@"Its really simple!" andBody:@"Check out this SimpleShareKit! visit http://github.com/redoan/SimpleShareKit/" andImage:[UIImage imageNamed:@"SimpleShareKit"] fromViewController:self];
}


-(IBAction)shareOnTwitter:(id)sender{
    [share shareOnTwitter:[UIImage imageNamed:@"SimpleShareKit"] withText:@"Check out this SimpleShareKit!" andURL:@"https://github.com/redoan/SimpleShareKit" fromViewController:self];
}

-(IBAction)shareOnFacebook:(id)sender{
    [share shareOnFacebook:[UIImage imageNamed:@"SimpleShareKit"] withText:@"Check out this SimpleShareKit! " andURL:@"https://github.com/redoan/SimpleShareKit" fromViewController:self];
}

-(IBAction)saveImageToDevice:(id)sender{
    [share saveImageToPhotosRoll:[UIImage imageNamed:@"SimpleShareKit"]];
}

-(IBAction)postOnFriendsWall:(id)sender{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                  @"SimpleShareKit", @"name",
                                  @"iOS 6 plug n play sharing", @"caption",
                                  @"https://github.com/redoan/SimpleShareKit", @"link",
                                  @"https://raw.github.com/redoan/SimpleShareKit/master/SimpleShareKit.png", @"picture",
                                  @"iOS sharing made easy! Check it now.", @"description",
                                  nil];
    
    [share postOnFriendsWall:param fromViewController:self];
}

-(IBAction)copyImageToClipboard:(id)sender{
    [share copyImageToClipBoard:[UIImage imageNamed:@"Icon"]];
}



//typedef enum{
//    skFinishedEmailSent= 1,
//    skFinishedEmailSaved,
//    skFinishedTwitterDone,
//    skFinishedFacebookDone,
//    skFinishedSavedToGallery,
//    skFinishedCopiedToClipboard,
//    skFinishedFacebookPostOnFriendsWall,
//    skFinishedFacebookPostOnUsersWall,
//}skFinishedType;

-(void)shareKitSharingFailed:(skFailureType)type{
    NSString *message;
    message = @"";
    switch (type) {
        case skFailureEmailCanceled:
            message = @"You canceled the email!";
            break;
            
        case skFailureEmailError:
            message = @"Email sending failed!";
            break;
            
        case skFailureTwitterCancelled:
            message = @"You canceled the Tweet!";
            break;
            
        case skFailureFacebookCancelled:
            message = @"You canceled the Facebook Post!";
            break;
            
        case skFailureFacebookPermission:
            message = @"Facebook Permission missing!";
            break;
            
        case skFailureFacebookFriendPickerCanceled:
            message = @"You cancelled the Friendpicker!";
            break;
            
        case skFailureFacebookFeedDialogClosed:
            message = @"You clossed Facebook feedDialog";
            break;
            
        case skFailureFacebookFeedDialogCanceled:
            message = @"You canceled Facebook share";
            break;
            
        case skFailureFacebookFeedDialogError:
            message = @"Error poting on Friend's wall";
            break;
            
        default:
            break;
    }
    
    myAlertView*alert = [[myAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    [self performSelector:@selector(hideAlert:) withObject:alert afterDelay:2];
}

//typedef enum {
//    skFailureEmailCanceled= 1,
//    skFailureEmailError,
//    skFailureTwitterCancelled,
//    skFailureTwitterNotAvailable,
//    skFailureFacebookCancelled,
//    skFailureFacebookNotAvailable,
//    skFailureFacebookPermission,
//    skFailureFacebookFriendPickerCanceled,
//    skFailureFacebookFeedDialogClosed,
//    skFailureFacebookFeedDialogCanceled,
//    skFailureFacebookFeedDialogError,
//    
//}skFailureType;

-(void)shareKitSharingFinished:(skFinishedType)type{
    NSString *message;
    switch (type) {
        case skFinishedEmailSaved:
            message = @"You saved the email!";
            break;
            
        case skFinishedEmailSent:
            message = @"Email is queued to sent!";
            break;
            
        case skFinishedTwitterDone:
            message = @"Tweet successful!";
            break;
            
        case skFinishedFacebookDone:
            message = @"Posted on Facebook!";
            break;
            
        case skFinishedSavedToGallery:
            message = @"Image saved on Device Gallery!";
            break;
            
        case skFinishedCopiedToClipboard:
            message = @"Image coppied to clipboard!";
            break;
            
        case skFinishedFacebookPostOnFriendsWall:
            message = @"Successfully Posted to your friend's wall!";
            break;
            
        case skFinishedFacebookPostOnUsersWall:
            message = @"You didn't pick a friend so it has been posted on your wall!";
            break;
            
        default:
            break;
    }
    
    myAlertView*alert = [[myAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    [self performSelector:@selector(hideAlert:) withObject:alert afterDelay:2];
}

-(void)hideAlert:(UIAlertView*)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


@end
