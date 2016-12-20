//
//  CUtilTests.m
//  CUtilTests
//
//  Created by Acttos on 28/11/2016.
//  Sources https://github.com/acttos/CommonUtilities
//  Copyright © 2016 Acttos.org. All codes follow MIT License.
//

#import <XCTest/XCTest.h>

#import "CUtil.h"

@interface CUtilTests : XCTestCase

@end

@implementation CUtilTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    // 初始化的代码，在测试方法调用之前调用
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    // 释放测试用例的资源代码，这个方法会每个测试用例执行后调用
    [super tearDown];
}

- (void)testCUCode {
    NSString *identifier = [CUCode uniqueIdentifier];
    XCTAssertNotNil(identifier);
    
//    Codes with Keychain can NOT be tested here because we can only test logic on simulators which is not supporting Keychain.
//    [CUCode saveInKeychainWithIdentifier:identifier];
//    XCTAssertTrue([identifier isEqualToString:[CUCode loadIdentifierFromKeychain]]);
    
    NSString *sourceString = @"HelloSourceStringWhichIsGoingToBeEncodedAsBASE64.";
    XCTAssertTrue([@"abad2da070f76f70e3494bf0880d195a" isEqualToString:[CUCode MD5CodeWithString:sourceString]]);
    XCTAssertTrue([@"b37faee2bce0691b66aceb391fa05644082e926e" isEqualToString:[CUCode SHA1CodeWithString:sourceString]]);
    
    NSString *encodedString = [CUCode BASE64EncodeWithString:sourceString];
    XCTAssertTrue([@"SGVsbG9Tb3VyY2VTdHJpbmdXaGljaElzR29pbmdUb0JlRW5jb2RlZEFzQkFTRTY0Lg==" isEqualToString:encodedString]);
    
    NSString *decodedString = [CUCode BASE64DecodeWithString:encodedString];
    XCTAssertTrue([decodedString isEqualToString:sourceString]);
    
    NSString *path = @"/Volumes/Data/Documents/GitHub_Code/personal/iOS/CUtilDev/CUtilDemo/images/cut.png";
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    XCTAssertTrue([@"48ee371f2994ef69e5cd5bb5d1835d51" isEqualToString:[CUCode MD5CodeWithData:data]]);
    XCTAssertTrue([@"22df248ead75d4a95cae001344417fb464168582" isEqualToString:[CUCode SHA1CodeWithData:data]]);
    XCTAssertTrue([@"48ee371f2994ef69e5cd5bb5d1835d51" isEqualToString:[CUCode MD5CodeWithFileAtPath:path]]);
    XCTAssertTrue([@"22df248ead75d4a95cae001344417fb464168582" isEqualToString:[CUCode SHA1CodeWithFileAtPath:path]]);
    XCTAssertTrue([@"48ee371f2994ef69e5cd5bb5d1835d51" isEqualToString:[CUCode MD5CodeWithFileAtURL:url]]);
    XCTAssertTrue([@"22df248ead75d4a95cae001344417fb464168582" isEqualToString:[CUCode SHA1CodeWithFileAtURL:url]]);
    
    path = @"file:///Volumes/Data/Documents/GitHub_Code/personal/iOS/CUtilDev/CUtilDemo/images/cut.png";
    url = [NSURL URLWithString:path];
    data = [NSData dataWithContentsOfFile:path];
    XCTAssertFalse([@"48ee371f2994ef69e5cd5bb5d1835d51" isEqualToString:[CUCode MD5CodeWithData:data]]);
    XCTAssertFalse([@"22df248ead75d4a95cae001344417fb464168582" isEqualToString:[CUCode SHA1CodeWithData:data]]);
    XCTAssertTrue([@"48ee371f2994ef69e5cd5bb5d1835d51" isEqualToString:[CUCode MD5CodeWithFileAtPath:path]]);
    XCTAssertTrue([@"22df248ead75d4a95cae001344417fb464168582" isEqualToString:[CUCode SHA1CodeWithFileAtPath:path]]);
    XCTAssertTrue([@"48ee371f2994ef69e5cd5bb5d1835d51" isEqualToString:[CUCode MD5CodeWithFileAtURL:url]]);
    XCTAssertTrue([@"22df248ead75d4a95cae001344417fb464168582" isEqualToString:[CUCode SHA1CodeWithFileAtURL:url]]);
    
}

- (void)testCUColor {
    UIColor *stringColor = [CUColor colorWithHexString:@"#00FF00"];
    XCTAssertTrue(CGColorEqualToColor(stringColor.CGColor, [UIColor greenColor].CGColor));
    
    UIColor *stringColorWithAlpha = [CUColor colorWithHexString:@"#00FF00" alpha:1];
    XCTAssertTrue(CGColorEqualToColor(stringColorWithAlpha.CGColor, [UIColor greenColor].CGColor));
    
    UIColor *hexColor = [CUColor colorWithHex:0x00FF00];
    XCTAssertTrue(CGColorEqualToColor(hexColor.CGColor, [UIColor greenColor].CGColor));
    
    UIColor *hexColorWithAlpha = [CUColor colorWithHex:0x00FF00 alpha:1];
    XCTAssertTrue(CGColorEqualToColor(hexColorWithAlpha.CGColor, [UIColor greenColor].CGColor));
}

- (void)testCUDate {
    long long timestamp = [CUDate generateMillisecondTime];
    XCTAssertEqual((long)[NSDate dateWithTimeIntervalSince1970:timestamp].timeIntervalSince1970 * 1000, (long)[CUDate generateDateWithMilliseconds:timestamp].timeIntervalSince1970 * 1000);
    
    NSDate *now = [NSDate date];
    XCTAssertEqual([CUDate generateMillisecondTimeWithDate:now], (long long)([now timeIntervalSince1970] * 1000));
    
    NSString *nilDateString = [CUDate stringOfDate:now withFormat:nil];
    XCTAssertTrue([nilDateString isEqualToString:[CUDate stringOfDate:now withFormat:@"yyyy-MM-dd HH:mm:ss"]]);
}

- (void)testCUFile {
    NSString *docPath = [CUFile getDocumentsDirectory].path;
    NSLog(@"%@", docPath);
    XCTAssertTrue([docPath rangeOfString:@"data/Documents"].length == NSMakeRange(docPath.length - @"data/Documents".length, @"data/Documents".length).length);
    XCTAssertTrue([docPath rangeOfString:@"data/Documents"].location == NSMakeRange(docPath.length - @"data/Documents".length, @"data/Documents".length).location);
    
    BOOL result = [CUFile createDirectoryAtPath:[NSString stringWithFormat:@"%@/majinshou/videos/", docPath]];
    XCTAssertTrue(result);
    
    result = [CUFile saveFile:[NSData dataWithBytes:[docPath UTF8String] length:docPath.length] atPath:[NSString stringWithFormat:@"%@/stringBytes.txts", docPath]];
    XCTAssertTrue(result);
    
    result = [CUFile saveFile:[NSData dataWithBytes:[docPath UTF8String] length:docPath.length] atPath:docPath withName:@"anotherStringBytes.txtddd"];
    XCTAssertTrue(result);
}

- (void)testCUConfig {
    NSString *lang = [CUConfig getDeviceLanguage];
    XCTAssertTrue([lang isEqualToString:@"en"]);
    
    NSString *langCode = [CUConfig getDeviceLanguageCode];
    XCTAssertTrue([langCode isEqualToString:@"en"]);
    
    NSString *countryCode = [CUConfig getDeviceCountryCode];
    XCTAssertTrue([countryCode isEqualToString:@"US"]);
    
    NSString *i18N = [CUConfig getLocalStringIni18N];
    XCTAssertTrue([i18N isEqualToString:@"en_US"]);
    
    XCTAssertTrue(![CUConfig isChineseLang]);
    XCTAssertTrue(![CUConfig isArabicLang]);
    XCTAssertTrue(![CUConfig isFrenchLang]);
}

- (void)testCUJSON {
    NSArray *array = @[@"A", @"B", @"C", @"D", @"E"];
    XCTAssertNotNil([CUJSON JSONStringFromArray:array]);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:4];
    [dic setValue:@"Value1" forKey:@"key1"];
    [dic setValue:[NSNumber numberWithInt:2] forKey:@"key2"];
    [dic setValue:array forKey:@"key3"];
    [dic setValue:@"Value4" forKey:@"key4"];
    XCTAssertNotNil([CUJSON JSONStringFromDictionary:dic]);
}

- (void)testCUString {
    NSString *source = @"Hello,Hello,Hello,How are you!";
    NSString *pattern = @"Hello";
    
    XCTAssertTrue([source indexOf:pattern] == 0);
    XCTAssertTrue([source lastIndexOf:pattern] == 12);
    
    XCTAssertTrue([[source replaceFirst:pattern with:@""] isEqualToString:@",Hello,Hello,How are you!"]);
    XCTAssertTrue([[source replaceLast:pattern with:@""] isEqualToString:@"Hello,Hello,,How are you!"]);
    XCTAssertTrue([[source replaceAll:pattern with:@""] isEqualToString:@",,,How are you!"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 测试性能例子
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 需要测试性能的代码
    }];
}
@end
