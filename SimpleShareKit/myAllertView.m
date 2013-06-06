//
//  CustomAlertView.m
//  CustomAlert
//
//  Created by Aaron Crabtree on 10/14/11.
//  Copyright (c) 2011 Tap Dezign, LLC. All rights reserved.
//

#import "myAlertView.h"
@implementation myAlertView

#pragma mark -
#pragma mark Memory management
- (void)dealloc 
{
//    [super dealloc];
}

#pragma mark -
#pragma mark UIView Overrides
- (void)layoutSubviews
{
	for (UIView *subview in self.subviews){

		if ([subview isMemberOfClass:[UIImageView class]]) { 			subview.hidden = YES;
		}
        
		if ([subview isMemberOfClass:[UILabel class]]) { //Point to UILabels To Change Text
			UILabel *label = (UILabel*)subview;	//Cast From UIView to UILabel
			label.textColor = [UIColor blackColor];
            UIFont *font = [UIFont fontWithName:@"Futura Medium" size:25];
            label.font = font;
			label.shadowColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByWordWrapping;
        }
    
	}
}

- (void)drawRect:(CGRect)rect 
{
	//////////////GET REFERENCE TO CURRENT GRAPHICS CONTEXT
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, self.bounds);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self dismissWithClickedButtonIndex:0 animated:YES];
}



@end

