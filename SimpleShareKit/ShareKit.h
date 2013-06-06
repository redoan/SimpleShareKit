//
//  ShareKit.h
//  iEditMyPhoto
//
//  Created by redoan on 6/3/13.
//  Copyright (c) 2013 AAPBD-REDOAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <FacebookSDK/FacebookSDK.h>


typedef enum{
    skFinishedEmailSent= 1,
    skFinishedEmailSaved,
    skFinishedTwitterDone,
    skFinishedFacebookDone,
    skFinishedSavedToGallery,
    skFinishedCopiedToClipboard,
    skFinishedFacebookPostOnFriendsWall,
    skFinishedFacebookPostOnUsersWall,
}skFinishedType;


typedef enum {
    skFailureEmailCanceled= 1,
    skFailureEmailError,
    skFailureTwitterCancelled,
    skFailureTwitterNotAvailable,
    skFailureFacebookCancelled,
    skFailureFacebookNotAvailable,
    skFailureFacebookPermission,
    skFailureFacebookFriendPickerCanceled,
    skFailureFacebookFeedDialogClosed,
    skFailureFacebookFeedDialogCanceled,
    skFailureFacebookFeedDialogError,
    
}skFailureType;


@protocol SimpleShareKitDelegate <NSObject>

-(void)shareKitSharingFinished:(int)type;
-(void)shareKitSharingFailed:(int)type;
@end

@interface ShareKit : NSObject
{

}

@property (nonatomic,retain) UIViewController *rootViewControllwe;

-(void)shareViaEmailWithSubject:(NSString*)subject andBody:(NSString*)message andImage:(UIImage*)image fromViewController:(UIViewController*)view;

- (void)shareOnTwitter:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString andViewController:(UIViewController*)view;

- (void)shareOnFacebook:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString andViewController:(UIViewController*)view;

-(void)saveImageToPhotosRoll:(UIImage*)image;

-(void)copyImageToClipBoard:(UIImage*)image;

-(void)postOnFriendsWall:(UIViewController*)view withOptions:(NSMutableDictionary*)params;

@property (nonatomic, assign) id <SimpleShareKitDelegate> delegate;

@end
