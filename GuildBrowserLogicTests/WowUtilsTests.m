//
//  WowUtilsTests.m
//  GuildBrowser
//
//  Created by Fahim Farook on 28/8/12.
//  Copyright (c) 2012 Charlie Fulton. All rights reserved.
//

#import "WowUtilsTests.h"
#import "Character.h"
#import "Item.h"

@implementation WowUtilsTests

-(void)testRaceLookup
{
	Character *test7 = [[Character alloc] initWithCharacterDetailData:@{ @"class" : @7}];
	STAssertEqualObjects(test7.classType, @"Shaman", nil);
	
	Character *test11 = [[Character alloc] initWithCharacterDetailData:@{ @"class" : @11}];
	STAssertEqualObjects(test11.classType, @"Druid", nil);
}

-(void)testRaceTypeLookup
{
	Character *test = [[Character alloc] initWithCharacterDetailData:@{ @"race" : @1}];
	STAssertEqualObjects(test.race, @"Human", nil);
	
	Character *test2 = [[Character alloc] initWithCharacterDetailData:@{ @"race" : @2}];
	STAssertEqualObjects(test2.race, @"Orc", nil);
}

-(void)testQualityLookup
{
	Item *item1 = [[Item alloc] initWithName:nil itemId:nil icon:nil quality:1];
	STAssertEqualObjects(item1.quality, WowItemQualityGrey, nil);
	
	Item *item2 = [[Item alloc] initWithName:nil itemId:nil icon:nil quality:2];
	STAssertEqualObjects(item2.quality, WowItemQualityWhite, nil);
}

@end
