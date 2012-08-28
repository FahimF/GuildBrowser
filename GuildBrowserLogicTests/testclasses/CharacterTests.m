#import "CharacterTests.h"
#import "Character.h"
#import "Item.h"

@implementation CharacterTests
{
    NSDictionary *characterDetailJson;
}

-(void)setUp
{
    NSURL *dataServiceURL = [[NSBundle bundleForClass:self.class] URLForResource:@"character" withExtension:@"json"];
    NSData *sampleData = [NSData dataWithContentsOfURL:dataServiceURL];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:sampleData options:kNilOptions error:&error];
    STAssertNotNil(json, @"invalid test data");
    characterDetailJson = json;
}

-(void)tearDown
{
    characterDetailJson = nil;
}

-(void)testCreateCharacterFromDetailJson
{
    Character *hagrel = [[Character alloc] initWithCharacterDetailData:characterDetailJson];
    STAssertNotNil(hagrel, @"Could not create character from detail json");
    
    // make sure designated initializer works with no data
    Character *hagrel2 = [[Character alloc] initWithCharacterDetailData:nil];
    STAssertNotNil(hagrel2, @"Could not create character from nil data");
}

-(void)testCreateCharacterFromDetailJsonProps
{
    Character *hagrel = [[Character alloc] initWithCharacterDetailData:characterDetailJson];
        
    STAssertEqualObjects(hagrel.thumbnail, @"borean-tundra/171/40508075-avatar.jpg", @"thumbnail url is wrong");
    STAssertEqualObjects(hagrel.name, @"Hagrel", @"name is wrong");
    STAssertEqualObjects(hagrel.battleGroup, @"Emberstorm", @"battlegroup is wrong");
    STAssertEqualObjects(hagrel.realm, @"Borean Tundra", @"realm is wrong");
    STAssertEqualObjects(hagrel.achievementPoints, @3130, @"achievement points is wrong");
    STAssertEqualObjects(hagrel.level,@85, @"level is wrong");
    STAssertEqualObjects(hagrel.selectedSpec, @"Arms", @"selected spec is wrong");
    STAssertEqualObjects(hagrel.classType, @"Warrior", @"class type is wrong");
    STAssertEqualObjects(hagrel.race, @"Human", @"race is wrong");
    STAssertEqualObjects(hagrel.gender, @"Male", @"gener is wrong");
    STAssertEqualObjects(hagrel.averageItemLevel, @379, @"avg item level is wrong");
    STAssertEqualObjects(hagrel.averageItemLevelEquipped, @355, @"avg item level is wrong");
}

-(void)testCreateCharacterFromDetailJsonValidateItems
{
    Character *hagrel = [[Character alloc] initWithCharacterDetailData:characterDetailJson];
    STAssertEqualObjects(hagrel.neckItem.name,@"Stoneheart Choker", @"name is wrong");
    STAssertEqualObjects(hagrel.wristItem.name,@"Vicious Pyrium Bracers", @"name is wrong");
    STAssertEqualObjects(hagrel.waistItem.name,@"Girdle of the Queen's Champion", @"name is wrong");
    STAssertEqualObjects(hagrel.handsItem.name,@"Time Strand Gauntlets", @"name is wrong");
    STAssertEqualObjects(hagrel.shoulderItem.name,@"Temporal Pauldrons", @"name is wrong");
    STAssertEqualObjects(hagrel.chestItem.name,@"Ruthless Gladiator's Plate Chestpiece", @"name is wrong");
    STAssertEqualObjects(hagrel.fingerItem1.name,@"Thrall's Gratitude", @"name is wrong");
    STAssertEqualObjects(hagrel.fingerItem2.name,@"Breathstealer Band", @"name is wrong");
    STAssertEqualObjects(hagrel.shirtItem.name,@"Black Swashbuckler's Shirt", @"name is wrong");
    STAssertEqualObjects(hagrel.tabardItem.name,@"Tabard of the Wildhammer Clan", @"nname is wrong");
    STAssertEqualObjects(hagrel.headItem.name,@"Vicious Pyrium Helm", @"neck name is wrong");
    STAssertEqualObjects(hagrel.backItem.name,@"Cloak of the Royal Protector", @"neck name is wrong");
    STAssertEqualObjects(hagrel.legsItem.name,@"Bloodhoof Legguards", @"neck name is wrong");
    STAssertEqualObjects(hagrel.feetItem.name,@"Treads of the Past", @"neck name is wrong");
    STAssertEqualObjects(hagrel.mainHandItem.name,@"Axe of the Tauren Chieftains", @"neck name is wrong");
    // this profile has no offhand
    STAssertEqualObjects(hagrel.offHandItem.name,nil, @"neck name is wrong");
    STAssertEqualObjects(hagrel.trinketItem1.name,@"Rosary of Light", @"neck name is wrong");
    STAssertEqualObjects(hagrel.trinketItem2.name,@"Bone-Link Fetish", @"neck name is wrong");
    STAssertEqualObjects(hagrel.rangedItem.name,@"Ironfeather Longbow", @"neck name is wrong");    
}

-(void)testGettingProfileImageUrlFromCharacter
{
    Character *hagrel = [[Character alloc] initWithCharacterDetailData:characterDetailJson];
    STAssertEqualObjects([hagrel profileImageUrl], @"http://us.battle.net/static-render/us/borean-tundra/171/40508075-profilemain.jpg",
                         @"url is wrong");
}

-(void)testGettingThumbnailImageUrlFromCharacter
{
    Character *hagrel = [[Character alloc] initWithCharacterDetailData:characterDetailJson];
    STAssertEqualObjects([hagrel thumbnailUrl], @"http://us.battle.net/static-render/us/borean-tundra/171/40508075-avatar.jpg",
                         @"url is wrong");
}

-(void)testSortingCharacters
{
    // create characters make sure they sort correctly
    //Doc, Grumpy, Happy, Sleepy, Bashful, Sneezy, and Dopey,
    
    NSDictionary *charData1 = @{ @"name" : @"Doc",      @"level" : @85, @"achievementPoints": @25};
    NSDictionary *charData2 = @{ @"name" : @"Grumpy",   @"level" : @19                      };
    NSDictionary *charData3 = @{ @"name" : @"Happy",    @"level" : @29, @"achievementPoints": @100 };
    NSDictionary *charData4 = @{ @"name" : @"Sleepy",   @"level" : @85, @"achievementPoints": @2000 };
    NSDictionary *charData5 = @{ @"name" : @"Bashful",  @"level" : @34, @"achievementPoints": @4453 };
    NSDictionary *charData6 = @{ @"name" : @"Sneezy",   @"level" : @40, @"achievementPoints": @5554 };
    NSDictionary *charData7 = @{ @"name" : @"Dopey",    @"level" : @85, @"achievementPoints": @30 };
    
    NSArray *unsortedList = @[
        [[Character alloc] initWithCharacterDetailData:charData1],
        [[Character alloc] initWithCharacterDetailData:charData2],
        [[Character alloc] initWithCharacterDetailData:charData3],
        [[Character alloc] initWithCharacterDetailData:charData4],
        [[Character alloc] initWithCharacterDetailData:charData5],
        [[Character alloc] initWithCharacterDetailData:charData6],
        [[Character alloc] initWithCharacterDetailData:charData7],

    ];    
    STAssertTrue([unsortedList count] == (NSUInteger) 7, @"");

    // sort by using Character compare impl
    NSArray *sortedList = [unsortedList sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *sortedNames = [[NSMutableArray alloc] initWithCapacity:8];
    for (Character *dwarf in sortedList) {
        [sortedNames addObject: dwarf.name];
    }
    NSArray *correctList = @[ @"Sleepy", @"Dopey", @"Doc", @"Sneezy", @"Bashful", @"Happy", @"Grumpy"];
    STAssertEqualObjects([NSArray arrayWithArray:sortedNames], correctList, @"sortedList is wrong");
}


@end
