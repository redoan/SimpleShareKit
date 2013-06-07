SimpleShareKit
==================

SimpleShareKit allows you to integrate common sharing features to your iOS app. Its really simple to use.

     Facebook post
     Facebook post on Friend's wall
     Twitter tweets
     Emailing
     Saving Image on Device
     Copy on clipboard
    

# Installation

Copy ShareKit.h and ShareKit.m file to your Xcode project.
Create your iOS facebook App (http://developers.facebook.com/).
Add a row in your info.plist file: FacebookAppID - your facebook appID
(optional) If you want to authorize facebook via Safari, add a URL type in your info.plist file with  URL Schemes fbYOUR_FB_APP_ID (e.g. fb12333940) and in your AppDelegate.m add the following method

    -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return YES;
    }
    
    
    -In the class where you want to integrate sharing features, import ShareKit.h and declare SimpleShareKitDelegate protocol.
    -Create a ShareKit object in your class interface.

 
	@interface YourClassName ()<SimpleShareKitDelegate>
	{
		ShareKit *share;
	}

    //In viewDidLoad, allocate the ShareKit object and as delegate, refer files owner.

	- (void)viewDidLoad
	{
	 	[super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib. 
		share = [[ShareKit alloc] init];
		[share setDelegate:self]; 
	}

    Now start calling sharing methods.

	- (void)shareViaEmailWithSubject:(NSString*)subject andBody:(NSString*)message andImage:(UIImage*)image fromViewController:(UIViewController*)view;

	- (void)shareOnTwitter:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view;

	- (void)shareOnFacebook:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view; 

	- (void)postOnFriendsWall:(NSMutableDictionary*)params fromViewController:(UIViewController*)view;

	- (void)saveImageToPhotosRoll:(UIImage*)image; 

	- (void)copyImageToClipBoard:(UIImage*)image; 

*** put self in fromViewController parameter.
*** postOnFriendsWall
	NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys: 
							@"SimpleShareKit", @"name", @"iOS 6 plug n play sharing", @"caption", 
							@"https://github.com/redoan/SimpleShareKit", @"link", 
							@"https://raw.github.com/redoan/SimpleShareKit/master/SimpleShareKit.png", 
							@"picture", @"iOS sharing made easy! Check it now.", @"description", nil];


6. Delegate methods:

	-(void)shareKitSharingFinished:(skFinishedType)type;
	-(void)shareKitSharingFailed:(skFailureType)type;

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

# Usage

	ASFBPostController *c = [[ASFBPostController alloc] init];
	c.thumbnailImage = [UIImage imageNamed:@"sample_thumb.jpg"];    
	c.originalImage = [UIImage imageNamed:@"sample.jpg"];

	UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
	n.modalPresentationStyle = UIModalPresentationFormSheet;
	[c release];
	
	[self presentModalViewController:n animated:YES];
	[n release];

License
==================
The ASFBPostController is licensed under the Apache License, Version 2.0 as same as the Facebook SDK.

Apache License
http://www.apache.org/licenses/LICENSE-2.0.html

Facebook iOS SDK
https://github.com/facebook/facebook-ios-sdk/

AppStair LLC
http://appstair.com

