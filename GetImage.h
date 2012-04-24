//
//  GetImages.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetImage : NSObject {
	id delegate;
	NSMutableData* receivedData;
	NSString *dataURL;
	
}

@property(nonatomic, retain) NSString *dataURL;

- (void) getImage:(NSString*)dataURLFromUser;
- (void) setDelegate:(id)adelegate;

@end


@protocol GetImageDelegate
@optional
- (void) gettingImageDone:(GetImage*)getimage data:(NSMutableData *)webData;
@end

