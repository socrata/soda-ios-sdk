//
//  SODA iOS SDK - Socrata, Inc
//
//  Copyright (C) 2013 Socrata, Inc
//  All rights reserved.
//
//  Developed for Socrata, Inc by:
//  47 Degrees, LLC
//  http://47deg.com
//  hello@47deg.com
//

#import <Foundation/Foundation.h>

/**
* A SODA specific datatype that represents a stored document
*/
@interface SODADocument : NSObject {
    NSString *_fileId;
    NSString *_fileName;
}

#pragma mark - Properties

@property(nonatomic, copy) NSString *fileId;
@property(nonatomic, copy) NSString *fileName;

#pragma mark - Initializers

- (id)initWithFileId:(NSString *)fileId fileName:(NSString *)fileName;

+ (id)documentWithFileId:(NSString *)fileId fileName:(NSString *)fileName;


@end