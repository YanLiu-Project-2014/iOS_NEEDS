//
//  ModelBase.h
//  iHotelApp
//

#import <Foundation/Foundation.h>

@interface JSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying> {

}

/**
 *  Key-Value coding, convert a json object string to an object.
 *
 *  @param jsonObject       the json object string.
 *
 *  @return Object it self.
 *
 *  @since 1.0
 */
-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
