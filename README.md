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

1.Copy ShareKit.h and ShareKit.m file to your Xcode project.

2.Create your iOS facebook App (http://developers.facebook.com/).

3.Add a row in your info.plist file: FacebookAppID - your facebook appID

4.(optional) If you want to authorize facebook via Safari, add a URL type in your info.plist file with  URL Schemes fbYOUR_FB_APP_ID (e.g. fb12333940) and in your AppDelegate.m add the following method

    -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return YES;
    }
    
# Usage

1.In the class where you want to integrate sharing features, import ShareKit.h and declare SimpleShareKitDelegate protocol.
2.Create a ShareKit object in your class interface.

 
	@interface YourClassName ()<SimpleShareKitDelegate>
	{
		ShareKit *share;
	}

3.In viewDidLoad, allocate the ShareKit object and as delegate, refer files owner.

	- (void)viewDidLoad
	{
	 	[super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib. 
		share = [[ShareKit alloc] init];
		[share setDelegate:self]; 
	}

4.Now start calling sharing methods.

	- (void)shareViaEmailWithSubject:(NSString*)subject andBody:(NSString*)message andImage:(UIImage*)image fromViewController:(UIViewController*)view;

	- (void)shareOnTwitter:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view;

	- (void)shareOnFacebook:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view; 

	- (void)postOnFriendsWall:(NSMutableDictionary*)params fromViewController:(UIViewController*)view;

	- (void)saveImageToPhotosRoll:(UIImage*)image; 

	- (void)copyImageToClipBoard:(UIImage*)image; 

*** put self in fromViewController parameter.

*** postOnFriendsWall params object format
	
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys: 
							@"SimpleShareKit", @"name", @"iOS 6 plug n play sharing", @"caption", 
							@"https://github.com/redoan/SimpleShareKit", @"link", 
							@"https://raw.github.com/redoan/SimpleShareKit/master/SimpleShareKit.png", 
							@"picture", @"iOS sharing made easy! Check it now.", @"description", nil];


#Delegate methods:

	-(void)shareKitSharingFinished:(skFinishedType)type;
	-(void)shareKitSharingFailed:(skFailureType)type;

    skFinishedType
    
    skFinishedEmailSent
        User clicked send button
    skFinishedEmailSaved
        User clicked Save Draft button
    skFinishedTwitterDone
        Tweet Success
    skFinishedFacebookDone
        Facbook Native Post Success
    skFinishedSavedToGallery
        Image Saved to Gallery
    skFinishedCopiedToClipboard
        Image Copied on clipboard
    skFinishedFacebookPostOnFriendsWall
        User selected a friend and posted on his wall
    skFinishedFacebookPostOnUsersWall
        User pressed done without selecting friend and then post via FBWebDialog, so posted on user's wall



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


License
==================
Free to use and share.

