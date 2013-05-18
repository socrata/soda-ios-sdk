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

#import "SODADocument.h"


@implementation SODADocument {

}

#pragma mark - Properties

@synthesize fileId = _fileId;
@synthesize fileName = _fileName;

#pragma mark - Initializers

- (id)initWithFileId:(NSString *)fileId fileName:(NSString *)fileName {
    self = [super init];
    if (self) {
        self.fileId = fileId;
        self.fileName = fileName;
    }

    return self;
}

+ (id)documentWithFileId:(NSString *)fileId fileName:(NSString *)fileName {
    return [[self alloc] initWithFileId:fileId fileName:fileName];
}

@end