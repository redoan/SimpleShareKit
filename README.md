<<<<<<< HEAD
![Screenshot1](https://dl.dropbox.com/u/339699/github/ASFBPostController.png)

SimpleShareKit
==================

SimpleShareKit allows you to integrate common sharing features to your iOS app. Its really simple to use.

Currently we support:

     Facebook post
     Facebook post on Friend's wall
     Twitter tweets
     Emailing
     Saving Image on Device
     Copy on clipboard
    

# Installation

1. Copy ShareKit.h and ShareKit.m file to your Xcode project.
2. In the class where you want to integrate sharing features, import ShareKit.h and declare SimpleShareKitDelegate protocol. 
3. Create a ShareKit object in your class interface.

	#import "ShareKit.h" 
	@interface YourClassName ()<SimpleShareKitDelegate>
	{
		ShareKit *share;
	}

4. In viewDidLoad, allocate the ShareKit object and as delegate, refer files owner.

	- (void)viewDidLoad
	{
	 	[super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib. 
		share = [[ShareKit alloc] init];
		[share setDelegate:self]; 
	}

5. Now start calling sharing methods.

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
=======
GitHub Markup
=============

We use this library on GitHub when rendering your README or any other
rich text file.

Markups
-------

The following markups are supported.  The dependencies listed are required if
you wish to run the library.

* [.markdown, .mdown, .md](http://daringfireball.net/projects/markdown/) -- `gem install redcarpet` (https://github.com/vmg/redcarpet)
* [.textile](http://www.textism.com/tools/textile/) -- `gem install RedCloth`
* [.rdoc](http://rdoc.sourceforge.net/) -- `gem install rdoc -v 3.6.1`
* [.org](http://orgmode.org/) -- `gem install org-ruby`
* [.creole](http://wikicreole.org/) -- `gem install creole`
* [.mediawiki](http://www.mediawiki.org/wiki/Help:Formatting) -- `gem install wikicloth`
* [.rst](http://docutils.sourceforge.net/rst.html) -- `easy_install docutils`
* [.asciidoc](http://www.methods.co.nz/asciidoc/) -- `brew install asciidoc`
* [.pod](http://search.cpan.org/dist/perl/pod/perlpod.pod) -- `Pod::Simple::HTML`
  comes with Perl >= 5.10. Lower versions should install Pod::Simple from CPAN.


Contributing
------------

Want to contribute? Great! There are two ways to add markups.


### Commands

If your markup is in a language other than Ruby, drop a translator
script in `lib/github/commands` which accepts input on STDIN and
returns HTML on STDOUT. See [rest2html][r2h] for an example.

Once your script is in place, edit `lib/github/markups.rb` and tell
GitHub Markup about it. Again we look to [rest2html][r2hc] for
guidance:

    command(:rest2html, /re?st(.txt)?/)

Here we're telling GitHub Markup of the existence of a `rest2html`
command which should be used for any file ending in `rest`,
`rst`, `rest.txt` or `rst.txt`. Any regular expression will do.

Finally add your tests. Create a `README.extension` in `test/markups`
along with a `README.extension.html`. As you may imagine, the
`README.extension` should be your known input and the
`README.extension.html` should be the desired output.

Now run the tests: `rake`

If nothing complains, congratulations!


### Classes

If your markup can be translated using a Ruby library, that's
great. Check out `lib/github/markups.rb` for some
examples. Let's look at Markdown:

    markup(:markdown, /md|mkdn?|markdown/) do |content|
      Markdown.new(content).to_html
    end

We give the `markup` method three bits of information: the name of the
file to `require`, a regular expression for extensions to match, and a
block to run with unformatted markup which should return HTML.

If you need to monkeypatch a RubyGem or something, check out the
included RDoc example.

Tests should be added in the same manner as described under the
`Commands` section.


Installation
-----------

    gem install github-markup


Usage
-----

    require 'github/markup'
    GitHub::Markup.render('README.markdown', "* One\n* Two")

Or, more realistically:

    require 'github/markup'
    GitHub::Markup.render(file, File.read(file))


Testing
-------

To run the tests:

    $ rake

To add tests see the `Commands` section earlier in this
README.


Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b my_markup`)
3. Commit your changes (`git commit -am "Added Snarkdown"`)
4. Push to the branch (`git push origin my_markup`)
5. Open a [Pull Request][1]
6. Enjoy a refreshing Diet Coke and wait


[r2h]: http://github.com/github/markup/tree/master/lib/github/commands/rest2html
[r2hc]: http://github.com/github/markup/tree/master/lib/github/markups.rb#L13
[1]: http://github.com/github/markup/pulls
>>>>>>> 8154dca5f42425fe389ed7027c5569ae91e377ba
