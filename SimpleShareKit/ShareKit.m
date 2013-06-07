//
//  ShareKit.m
//  iEditMyPhoto
//
//  Created by redoan on 6/3/13.
//  Copyright (c) 2013 AAPBD-REDOAN. All rights reserved.
//

#import "ShareKit.h"
#import <MessageUI/MessageUI.h>
#import "Twitter/Twitter.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Accounts/Accounts.h>


@interface ShareKit ()<MFMailComposeViewControllerDelegate>
{
    UIViewController *callerClass;
}

@end

@implementation ShareKit
@synthesize delegate;


#pragma mark- Sharing Via Email

-(void)shareViaEmailWithSubject:(NSString*)subject andBody:(NSString*)message andImage:(UIImage*)image fromViewController:(UIViewController*)view{
    
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    
    if(image!=nil)
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.0);
        
        
        [mail addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"Attachment.jpg"]];
    }
    
    [mail setSubject:subject];
    [mail setMessageBody:message isHTML:NO];
    
    [[[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController] presentViewController:mail animated:YES completion:^{
        mail.mailComposeDelegate = self;
    }];
}

#pragma Email delegates

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [delegate shareKitSharingFailed:skFailureEmailCanceled];
            break;
            
        case MFMailComposeResultFailed:
            [delegate shareKitSharingFailed:skFailureEmailError];
            break;
            
        case MFMailComposeResultSaved:
            [delegate shareKitSharingFinished:skFinishedEmailSaved];
            break;
            
        case MFMailComposeResultSent:
            [delegate shareKitSharingFinished:skFinishedEmailSent];
            break;
        
        default:
            [delegate shareKitSharingFailed:skFailureEmailError];
            break;
    }

    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- Sharing Via Twitter

- (void)shareOnTwitter:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                [delegate shareKitSharingFailed:skFailureTwitterCancelled];
                
            } else
                
            {
                [delegate shareKitSharingFinished:skFinishedTwitterDone];
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        
        controller.completionHandler =myBlock;
        
        [controller setInitialText:initialText];
        
        if (urlString!=nil) {
            [controller addURL:[NSURL URLWithString:urlString]];
        }
        
        
        [controller addImage:image];
        
        [view presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        [delegate shareKitSharingFailed:skFailureTwitterNotAvailable];
    }

    
}


#pragma mark- Sharing Via Facebook

- (void)shareOnFacebook:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                [delegate shareKitSharingFailed:skFailureFacebookCancelled];
                
            } else
                
            {
                [delegate shareKitSharingFinished:skFinishedFacebookDone];
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        
        controller.completionHandler =myBlock;
        
        [controller setInitialText:initialText];
        
        if (urlString!=nil) {
            [controller addURL:[NSURL URLWithString:urlString]];
        }
        
        
        [controller addImage:image];
        
        [view presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        [delegate shareKitSharingFailed:skFailureFacebookNotAvailable];
    }
    
    
}

#pragma Save image To Camera Roll

-(void)saveImageToPhotosRoll:(UIImage*)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [delegate shareKitSharingFinished:skFinishedSavedToGallery];
}


-(void)copyImageToClipBoard:(UIImage *)image{
    [[UIPasteboard generalPasteboard] setImage:image];
    [delegate shareKitSharingFinished:skFinishedCopiedToClipboard];
}

#pragma mark - faceBookFriendsWall

-(void)postOnFriendsWall:(NSMutableDictionary*)params fromViewController:(UIViewController*)view{
    
    callerClass = view;
    
    if (!FBSession.activeSession.isOpen) {
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:@"read_friendlists", nil];
        
        [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *_session, FBSessionState state, NSError *error) {
            
            switch (state) {
                case FBSessionStateClosedLoginFailed:
                {
                    [delegate shareKitSharingFailed:skFailureFacebookPermission];
                }
                    break;
                default:
                    [self showFriendPickerWithOptions:params];
                    break;
            }
        }];
    }
    
    else if(FBSession.activeSession.isOpen){
        [self showFriendPickerWithOptions:params];
    }
}

-(void)showFriendPickerWithOptions:(NSMutableDictionary*)params{
    FBFriendPickerViewController *friendPickerController = [[FBFriendPickerViewController alloc] init];
    friendPickerController.title = @"Pick a Friends";
    [friendPickerController loadData];
    [friendPickerController setAllowsMultipleSelection:NO];
    
    // Use the modal wrapper method to display the picker.
    [friendPickerController presentModallyFromViewController:callerClass animated:YES handler:
     ^(FBViewController *sender, BOOL donePressed) {
         if (donePressed) {
             NSString *message;
             NSString* fid;
             NSString* fbUserName;
             
             NSLog(@"DONE PRESSED");
             {
                 
                 NSMutableString *text = [[NSMutableString alloc] init];
                 
                 // we pick up the users from the selection, and create a string that we use to update the text view
                 // at the bottom of the display; note that self.selection is a property inherited from our base class
                 for (id<FBGraphUser> user in friendPickerController.selection) {
                     if ([text length]) {
                         [text appendString:@", "];
                     }
                     [text appendString:user.name];
                     
                     fid = user.id;
                     fbUserName = user.name;
                 }
                 message = text;
             }
             [self showDialogwithUser:fid andName:message withOptions:params];
         }

         else{
             [delegate shareKitSharingFailed:skFailureFacebookFriendPickerCanceled];
             return;
         }
        
         
         }];

}
-(void)showDialogwithUser: (NSString*)userid andName:(NSString*)name  withOptions:(NSMutableDictionary*)params
{
    if (userid) {
        [params setObject:userid forKey:@"to"]; 
    }
    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or publishing a story.
             NSLog(@"Error publishing story.");
         }
         else
         {
             if (result == FBWebDialogResultDialogNotCompleted)
             {
                 // User clicked the "x" icon
                 [delegate shareKitSharingFailed:skFailureFacebookFeedDialogClosed];
                 
             }
             else if (result == FBWebDialogResultDialogCompleted)
             {
                 // Handle the publish feed callback
                 NSString *resultString = [resultURL absoluteString];
                 [self checkmeWithResult:resultString userid:userid];
             }
         }
     }];
}
-(void) checkmeWithResult:(NSString*)resultString userid:(NSString*)userid {
    
    if ([resultString rangeOfString:@"post_id"].location == NSNotFound)
    {
        [delegate shareKitSharingFailed:skFailureFacebookFeedDialogCanceled];
    }
    else
    {
        if (userid) {
           [delegate shareKitSharingFinished:skFinishedFacebookPostOnFriendsWall];
        }
        
        else{
            [delegate shareKitSharingFinished:skFinishedFacebookPostOnUsersWall];
        }
        
    }
}



@end