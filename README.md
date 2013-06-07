{\rtf1\ansi\ansicpg1252\cocoartf1187
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red170\green13\blue145;\red63\green110\blue116;\red28\green0\blue207;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww21120\viewh11700\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural

\f0\fs24 \cf0 ![Screenshot1](https://dl.dropbox.com/u/339699/github/ASFBPostController.png)\
\
SimpleShareKit\
==================\
\
SimpleShareKit allows you to integrate common sharing features to your iOS app. Its really simple to use.\
\
# Installation\
\
1. Copy ShareKit.h and ShareKit.m file to your Xcode project.\
2. In the class where you want to integrate sharing features, import ShareKit.h and declare SimpleShareKitDelegate protocol. \
3. Create a ShareKit object in your class interface.\
\
	#import "ShareKit.h" \
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural
\cf0 	@interface YourClassName ()<SimpleShareKitDelegate>\
	\{\
		ShareKit *share;\
	\}\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural
\cf0 \
4. In viewDidLoad, allocate the ShareKit object and as delegate, refer files owner.\
\
	- (void)viewDidLoad\
	\{\
	 	[super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib. \
		share = [[ShareKit alloc] init];\
		[share setDelegate:self]; \
	\}\
\
5. Now start calling sharing methods.\
\
	- (void)shareViaEmailWithSubject:(NSString*)subject andBody:(NSString*)message andImage:(UIImage*)image fromViewController:(UIViewController*)view;\
\
	- (void)shareOnTwitter:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view;\
\
	- (void)shareOnFacebook:(UIImage *)image withText:(NSString*)initialText andURL:(NSString*)urlString fromViewController:(UIViewController*)view; \
\
	- (void)postOnFriendsWall:(NSMutableDictionary*)params fromViewController:(UIViewController*)view;\
\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural
\cf0 	- (void)saveImageToPhotosRoll:(UIImage*)image; \
\
	- (void)copyImageToClipBoard:(UIImage*)image; \
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural
\cf0 \
*** put self in fromViewController parameter.\
*** postOnFriendsWall\
	NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys: \
							@"SimpleShareKit", @"name", @"iOS 6 plug n play sharing", @"caption", \
							@"https://github.com/redoan/SimpleShareKit", @"link", \
							@"https://raw.github.com/redoan/SimpleShareKit/master/SimpleShareKit.png", \
							@"picture", @"iOS sharing made easy! Check it now.", @"description", nil];\
\
\
6. Delegate methods:\
\
	
\f1\fs28 \CocoaLigature0 -(\cf2 void\cf0 )shareKitSharingFinished:(\cf3 skFinishedType\cf0 )type;\
	-(\cf2 void\cf0 )shareKitSharingFailed:(\cf3 skFailureType\cf0 )type;\
\
\pard\tx674\pardeftab674\pardirnatural
\cf2 typedef\cf0  \cf2 enum\cf0 \{\
    skFinishedEmailSent= \cf4 1\cf0 ,\
    skFinishedEmailSaved,\
    skFinishedTwitterDone,\
    skFinishedFacebookDone,\
    skFinishedSavedToGallery,\
    skFinishedCopiedToClipboard,\
    skFinishedFacebookPostOnFriendsWall,\
    skFinishedFacebookPostOnUsersWall,\
\}skFinishedType;\
\
\
\cf2 typedef\cf0  \cf2 enum\cf0  \{\
    skFailureEmailCanceled= \cf4 1\cf0 ,\
    skFailureEmailError,\
    skFailureTwitterCancelled,\
    skFailureTwitterNotAvailable,\
    skFailureFacebookCancelled,\
    skFailureFacebookNotAvailable,\
    skFailureFacebookPermission,\
    skFailureFacebookFriendPickerCanceled,\
    skFailureFacebookFeedDialogClosed,\
    skFailureFacebookFeedDialogCanceled,\
    skFailureFacebookFeedDialogError,\
    \
\}skFailureType;
\f0\fs24 \CocoaLigature1 \
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural
\cf0 \
\
	\{ NSString *message; message = @""; switch (type) \{ case skFailureEmailCanceled: message = @"You canceled the email!"; break; case skFailureEmailError: message = @"Email sending failed!"; break; case skFailureTwitterCancelled: message = @"You canceled the Tweet!"; break; case skFailureFacebookCancelled: message = @"You canceled the Facebook Post!"; break; case skFailureFacebookPermission: message = @"Facebook Permission missing!"; break; case skFailureFacebookFriendPickerCanceled: message = @"You cancelled the Friendpicker!"; break; case skFailureFacebookFeedDialogClosed: message = @"You clossed Facebook feedDialog"; break; case skFailureFacebookFeedDialogCanceled: message = @"You canceled Facebook share"; break; case skFailureFacebookFeedDialogError: message = @"Error poting on Friend's wall"; break; default: break; \} myAlertView*alert = [[myAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil]; [alert show]; [self performSelector:@selector(hideAlert:) withObject:alert afterDelay:2]; \} //typedef enum \{ // skFailureEmailCanceled= 1, // skFailureEmailError, // skFailureTwitterCancelled, // skFailureTwitterNotAvailable, // skFailureFacebookCancelled, // skFailureFacebookNotAvailable, // skFailureFacebookPermission, // skFailureFacebookFriendPickerCanceled, // skFailureFacebookFeedDialogClosed, // skFailureFacebookFeedDialogCanceled, // skFailureFacebookFeedDialogError, // //\}skFailureType; -\{\
\
	#import "ViewController.h" \
	#import "ShareKit.h" \
	@interface ViewController ()<SimpleShareKitDelegate> \
	\{\
		ShareKit *share;\
	 \} \
	@end \
	@implementation ViewController - (void)viewDidLoad \{ [super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib. share = [[ShareKit alloc] init]; [share setDelegate:self]; \}\
\
\
1. Create your iOS Facebook App (http://developers.facebook.com/).\
2. Replace sample ID (1234567) with your Facebook App ID.\
\
* ASFBPostController.m\
\
	FB_APP_ID @"1234567"\
\
* ASFBPost-Infor.plist\
\
	URL types > Item 0 > URL Schemes > Item 0 > fb1234567\
\
# Usage\
\
	ASFBPostController *c = [[ASFBPostController alloc] init];\
	c.thumbnailImage = [UIImage imageNamed:@"sample_thumb.jpg"];    \
	c.originalImage = [UIImage imageNamed:@"sample.jpg"];\
\
	UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];\
	n.modalPresentationStyle = UIModalPresentationFormSheet;\
	[c release];\
	\
	[self presentModalViewController:n animated:YES];\
	[n release];\
\
License\
==================\
The ASFBPostController is licensed under the Apache License, Version 2.0 as same as the Facebook SDK.\
\
Apache License\
http://www.apache.org/licenses/LICENSE-2.0.html\
\
Facebook iOS SDK\
https://github.com/facebook/facebook-ios-sdk/\
\
AppStair LLC\
http://appstair.com\
}