//
//  User.h
//  NEEDS
//
//  Created by JackYu on 5/5/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface User : JSONModel <NSCoding>

@property (strong, nonatomic) NSString *sid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *user_type;
@property (nonatomic, strong) NSString *user_name;

//@property (strong, nonatomic) NSString *pk_id;
//@property (nonatomic, strong) NSString *fk_id;
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *password;
//@property (nonatomic, strong) NSString *email;

- (NSString*)description;

+ (NSString*)formatToString:(User*)user;

+ (User *)formatFromString:(NSString*)string;

@end
