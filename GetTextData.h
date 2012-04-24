//
//  GetTextData.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/18/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetTextData : NSObject {
	id delegate;
	NSMutableData* receivedData;
	NSString *dataURL;
	NSInteger tag;
}

@property(nonatomic, retain) NSString *dataURL;
@property(nonatomic) NSInteger tag;

- (void) getTextData:(NSString*)dataURLFromUser;
- (void) setDelegate:(id)adelegate;

@end


@protocol GetTextDataDelegate
@optional
- (void) gettingTextDataDone:(GetTextData*)gettextdata data:(NSMutableData *)webData;
@end
