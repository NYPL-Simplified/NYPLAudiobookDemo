//
//  ObjCTest.m
//  NYPLAudiobookDemoApp
//
//  Created by Dean Silfen on 5/10/18.
//  Copyright © 2018 Dean Silfen. All rights reserved.
//

#import "ObjCTest.h"

@implementation ObjCTest
- (instancetype)initWithString:(NSString *)string {
  self = [super init];
  if (self) {
    NSData *data = [string dataUsingEncoding:kCFStringEncodingUTF8];
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    self.audiobook = [AudiobookFactory audiobook:json];
    
  }
  return self;
}

@end
