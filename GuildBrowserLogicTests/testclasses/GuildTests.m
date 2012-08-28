#import "GuildTests.h"
#import "Guild.h"
#import "Character.h"
#import "WowUtils.h"

@implementation GuildTests
{
    NSDictionary *guildData;
    Guild *guild;
}

-(void)setUp
{
    NSURL *dataServiceURL = [[NSBundle bundleForClass:self.class] URLForResource:@"guild" withExtension:@"json"];
    NSData *sampleData = [NSData dataWithContentsOfURL:dataServiceURL];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:sampleData options:kNilOptions error:&error];
    STAssertNotNil(json, @"invalid test data");
    guildData = json;
    guild = [[Guild alloc] initWithGuildData:guildData];
}

-(void)tearDown
{
    guildData = nil;
    guild = nil;
}

-(void)testCreateGuildFromJson
{
    STAssertNotNil(guild, @"");
}


-(void)testGuildProps
{
    STAssertNotNil(guild, @"");
    NSArray *names = @[
        @"Alad",
        @"Bliant",
        @"Bluekat",
        @"Britaxis",
        @"Bulldogg",
        @"Desplaines",
        @"Elassa",
        @"Everybody",
        @"Greatdane",
        @"Ivymoon",
        @"Jonan",
        @"Josephus",
        @"Lailet",
        @"Lixiu",
        @"Mercpriest",
        @"Mirai",
        @"Monk",
        @"Nerii",
        @"Torabargim",
        @"Verikus"
    ];
    
    NSArray *sortedGuildMemberNames = [[guild.members valueForKey:@"name"] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    
//    NSLog(@"sortedGuildMemberNames %@",sortedGuildMemberNames);
    
    STAssertEqualObjects(guild.name, @"Dream Catchers", @"");
    STAssertEqualObjects(guild.battlegroup, @"Emberstorm", @"");
    STAssertEqualObjects(guild.realm, @"Borean Tundra", @"");
    STAssertEqualObjects(guild.achievementPoints, @1655, @"");
    STAssertEqualObjects(guild.level, @25, @"");
    STAssertEqualObjects(sortedGuildMemberNames, names, @"");
}

-(void)testMemberByClassTypeName
{
        
    NSArray *mages = [guild membersByWowClassTypeName:WowClassTypeMage];
    STAssertEquals([mages count], (NSUInteger)2, nil);
    
    NSArray *warriors = [guild membersByWowClassTypeName:WowClassTypeWarrior];
    STAssertEquals([warriors count], (NSUInteger)1,nil);
    
    NSArray *paladins = [guild membersByWowClassTypeName:WowClassTypePaladin];
    STAssertEquals([paladins count], (NSUInteger)3,nil);
    
    NSArray *druids = [guild membersByWowClassTypeName:WowClassTypeDruid];
    STAssertEquals([druids count], (NSUInteger)3,nil);
    
    NSArray *hunters = [guild membersByWowClassTypeName:WowClassTypeHunter];
    STAssertEquals([hunters count], (NSUInteger)2,nil);
    
    NSArray *shamen = [guild membersByWowClassTypeName:WowClassTypeShaman];
    STAssertEquals([shamen count], (NSUInteger)0,nil);
    
    NSArray *warlock = [guild membersByWowClassTypeName:WowClassTypeWarlock];
    STAssertEquals([warlock count], (NSUInteger)0,nil);
    
    NSArray *dks = [guild membersByWowClassTypeName:WowClassTypeDeathKnight];
    STAssertEquals([dks count], (NSUInteger)1,nil);
    
    NSArray *pokers = [guild membersByWowClassTypeName:WowClassTypeRogue];
    STAssertEquals([pokers count], (NSUInteger)3,nil);
}
@end
