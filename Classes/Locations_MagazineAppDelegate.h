//
//  Locations_MagazineAppDelegate.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright LocationsMagazine.Com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Locations_MagazineViewController;

@interface Locations_MagazineAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Locations_MagazineViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Locations_MagazineViewController *viewController;

@end

