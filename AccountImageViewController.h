//
//  AccountImageViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccountImageViewController : UIViewController <UIScrollViewDelegate>{

	NSString *accountName;
	UIImage *accountImage;
	UIImageView *imageView;
	IBOutlet UIScrollView *scrollView;
}

@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) NSString *accountName;
@property(nonatomic, retain) UIImage *accountImage;

@end
