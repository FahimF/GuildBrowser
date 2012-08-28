#import "ItemTests.h"
#import "Item.h"
#import "WowUtils.h"

@implementation ItemTests

-(void)testCreateItemWithDictionary
{
    // Sample item json data
    NSDictionary *testData =
    @{
        @"icon": @"inv_bracer_plate_dungeonplate_c_04",
        @"name": @"Vicious Pyrium Bracers",
        @"id": @75124,
        @"quality": @3
    };
    
    Item *item = [Item initWithData:testData];
    
    STAssertEqualObjects(@"inv_bracer_plate_dungeonplate_c_04",[item valueForKey:@"icon"],@"icons are not equal");
    
    STAssertEqualObjects(item.quality, WowItemQualityGreen, nil);
    
    STAssertEqualObjects( @"Vicious Pyrium Bracers", item.name, @"name should be equal");
    STAssertEqualObjects(@75124, item.itemId, @"item should be equals");
    
}

-(void)testCreateItemWithBadData
{
    NSDictionary *badData =
    @{
        @"badkey" : @"bad value",
        @"bad key2": @"bad value 2"
    };
    
    Item *badItem = [Item initWithData:badData];
    
    STAssertNil(badItem.icon, @"icon shoudld be nil");
    STAssertNil(badItem.name, @"name shoudld be nil");
    STAssertNil(badItem.itemId, @"itemId shoudld be nil");
    STAssertEqualObjects(badItem.quality,@"",nil);
}




@end
