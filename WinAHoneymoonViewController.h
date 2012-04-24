//
//  WinAHoneymoonViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WinAHoneymoonViewController : UIViewController {

	id delegate;
}

- (void) dismissWinAHoneymoon:(id) sender;
- (void) setDelegate:(id)adelegate;
- (IBAction) openForm:(id) sender;
- (IBAction) openRules:(id) sender;

@end

@protocol WinAHoneymoonControllerDelegate
- (void) homeButtonPressed:(id)sender;
@end