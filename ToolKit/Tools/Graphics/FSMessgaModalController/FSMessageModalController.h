//
//  FSMessageModalController.h
//  Ready
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MessageModelComplete)(NSString *messageInfo);
typedef void(^MessageModelCancle)(void);
typedef void(^MessageModelArrivalMax)(void);

@interface FSMessageModalController : UIViewController

@property(nonatomic,strong)NSString *placeHolder;
@property(nonatomic,strong)NSString *placeHoldertext;
@property(nonatomic,assign)NSInteger minNum;
@property(nonatomic,assign)NSInteger limitedNum;
@property(nonatomic,assign)BOOL enableEnptyControl;
@property(nonatomic,copy)MessageModelCancle cancleBlock;
@property(nonatomic,copy)MessageModelArrivalMax arrivalMaxBlock;

- (instancetype)initWithTitle:(NSString *)title
            clickSureCallBack:(MessageModelComplete)complete;

- (void)beginEdit;
@end
