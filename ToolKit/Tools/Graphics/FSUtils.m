//
//  FSUtils.m
//  Lolly
//
//  Created by gongruike on 2017/12/1.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSUtils.h"

@implementation FSUtils

+ (NSDateFormatter *)profileDateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"dd/MM/yyyy"];
//    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
//    [NSDateFormatter dateFormatFromTemplate:@"dd, MMM, yyyy" options:0 locale:locale]
    return formatter;
}

+ (NSDateFormatter *)videoChatRecordDateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // 这个地方必须用en_US，因为存在数据库中的形式是2017-11
    // 如果使用了NSLocale，在阿语环境下会存成阿文，语言切换后会找不到之前的记录
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM"];
//    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
//    [NSDateFormatter dateFormatFromTemplate:@"dd, MMM, yyyy" options:0 locale:locale]
    return formatter;
}

+ (UIAlertController *)unfollowAlertController:(dispatch_block_t)comfirmBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:[FSSharedLanguages CustomLocalizedStringWithKey:@"FSFollowAreYouSure"]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"FSFollowCancel"]
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
    UIAlertAction *comfirmAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"FSFollowConfirm"]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (comfirmBlock) {
                                                                  comfirmBlock();
                                                              }
                                                           }];
    //
    [alertController addAction:cancelAction];
    [alertController addAction:comfirmAction];
    alertController.preferredAction = comfirmAction;
    return alertController;
}

+ (UIAlertController *)settingAlertController:(dispatch_block_t)settingBlock
                                  cancelBlock:(dispatch_block_t)cancelBlock {
    // 跳转到设置页面
    NSString *title = [FSSharedLanguages CustomLocalizedStringWithKey:@"VideoChatAccessTitle"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:title
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Cancel"]
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             //
                                                             if (cancelBlock) {
                                                                 cancelBlock();
                                                             }
                                                         }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"MineSetting"]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                               //
                                                               if (settingBlock) {
                                                                   settingBlock();
                                                               }
                                                           }];
    //
    [alertController addAction:cancelAction];
    [alertController addAction:settingAction];
    alertController.preferredAction = settingAction;
    //
    return alertController;
}

+ (UIAlertController *)unlockAlertController:(NSInteger)price
                                      unlock:(dispatch_block_t)unlockBlock {
    NSString *metaTitle = [FSSharedLanguages CustomLocalizedStringWithKey:@"UserCenterUnlockTitle"];
    NSString *title = [metaTitle stringByReplacingOccurrencesOfString:@"(XXX)"
                                                           withString:[NSString stringWithFormat:@"%ld", price]];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:title
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Cancel"]
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    UIAlertAction *unlockAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Confirm"]
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                               //
                                                             if (unlockBlock) {
                                                                 unlockBlock();
                                                             };
                                                           }];
    //
    [alertController addAction:cancelAction];
    [alertController addAction:unlockAction];
    alertController.preferredAction = unlockAction;
    return alertController;
}

+ (UIAlertController *)privateChatAlertController:(NSString *)title chatBlock:(dispatch_block_t)chatBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:title
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Cancel"]
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    UIAlertAction *chatAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"UserCenterPrivateChat"]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                              //
                                                              if (chatBlock) {
                                                                  chatBlock();
                                                              }
                                                          }];
    //
    [alertController addAction:cancelAction];
    [alertController addAction:chatAction];
    alertController.preferredAction = chatAction;
    //
    return alertController;
}

+ (NSString *)lastTimeStringFrom:(NSInteger)timeInterval {
    NSInteger duration = ABS(timeInterval);
    NSInteger seconds = duration % 60;
    NSInteger minutes = (duration / 60) % 60;
    NSInteger hours = (duration / 3600);
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02ld : %02ld : %02ld", (long)hours, (long)minutes, (long)seconds];
    } else {
        return [NSString stringWithFormat:@"%02ld : %02ld", (long)minutes, (long)seconds];
    }
}

@end
