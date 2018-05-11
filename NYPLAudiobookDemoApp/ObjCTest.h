//
//  ObjCTest.h
//  NYPLAudiobookDemoApp
//
//  Created by Dean Silfen on 5/10/18.
//  Copyright © 2018 Dean Silfen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NYPLAudiobookToolkit/NYPLAudiobookToolkit-Swift.h>

@interface ObjCTest : NSObject
@property (nonatomic, nullable, strong) id<Audiobook> audiobook;
- (instancetype)initWithString:(NSString *)string;
@end
