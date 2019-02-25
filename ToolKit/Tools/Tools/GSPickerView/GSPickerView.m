//
//  GSPickerView.m
//  GSPickerView
//
//  Created by ijointoo on 2017/10/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "GSPickerView.h"
#import "FSUtils.h"

@interface GSPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,assign)CGFloat insetBottom;
@property (nonatomic,assign)GSPickerType pickerType;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSArray *subTitles;
@property (nonatomic,strong)void(^sure)(NSInteger path,NSString *pathStr);
@property (nonatomic,strong)void(^cancle)(void);


@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIPickerView *picker;
@property (nonatomic,assign)NSInteger selectedRow;

@end

# define GSLog(fmt, ...) NSLog((@"[方法:%s____" "行:%d]\n " fmt),  __FUNCTION__, __LINE__, ##__VA_ARGS__);
/** 宽高*/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** window*/
#define kWindow [UIApplication sharedApplication].keyWindow

@implementation GSPickerView

- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(15, 0, 100, 40);
        _cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:GTFixWidthFlaot(17)];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancleBtn setTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"SelectPhotoPage_Cancle"] forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:HexRGB(0x007aff) forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (void)cancleBtnAction{
    if (self.cancle) {
        self.cancle();
    }
    [self disAppear];
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - 95, 0, 80, 40);
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:GTFixWidthFlaot(17)];
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sureBtn setTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"ProfilePage_Confirm"] forState:UIControlStateNormal];
        [_sureBtn setTitleColor:HexRGB(0x007aff) forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureBtn;
}
- (void)sureBtnAction{
    if (self.sure) {
        if (_pickerType != GSPickerTypeDatePicker) {
            self.sure(_selectedRow, _subTitles[_selectedRow]);
        }
        else{
            NSString *str = [[FSUtils profileDateFormatter] stringFromDate: _datePicker.date];
            self.sure(-1, str);
        }
    }
    [self disAppear];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 0, CGRectGetWidth(self.bounds) - 150, 40)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:GTFixWidthFlaot(17)];
        _titleLabel.textColor = HexRGB(0x000000);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.bounds), 200)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
//        NSArray *locals= [NSLocale ISOLanguageCodes];
        
        NSString *localId = [FSSharedLanguages SharedLanguage].language;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:localId];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        _datePicker.calendar = calendar;
        
        NSDate *currentDate = [NSDate date];

        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:0];//设置最大时间为：当前时间推后十年
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [comps setYear:-50];//设置最小时间为：当前时间前推十年
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [_datePicker setMaximumDate:maxDate];
        [_datePicker setMinimumDate:minDate];
        
//        // 12-60 最大时间
//        NSDateComponents *maxComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
//        maxComponents.year = maxComponents.year;
//        maxComponents.day = maxComponents.day;
//        _datePicker.maximumDate = [calendar dateFromComponents:maxComponents];
//        // 最小时间
//        NSDateComponents *minComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
//        minComponents.year = minComponents.year - 49;
//        minComponents.day = minComponents.day;
//        _datePicker.minimumDate = [calendar dateFromComponents:minComponents];
//        _datePicker.date = _datePicker.maximumDate;
    }
    return _datePicker;
}
- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.bounds), 200)];
        _picker.backgroundColor = [UIColor whiteColor];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 240,  CGRectGetWidth(self.bounds), 240+_insetBottom)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (instancetype)initWithFrame:(CGRect)frame insetBottom:(CGFloat)insetBottom {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _insetBottom = insetBottom;

        [self addSubview:self.contentView];
        [self.contentView addSubview:self.cancleBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sureBtn];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.cancleBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sureBtn];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)tapView:(UIGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self];
    if (!CGRectContainsPoint(self.contentView.frame, point)) {
        [self disAppear];
    }
}

- (void)appearWithTitle:(NSString *)title pickerType:(GSPickerType)pickerType subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle{
    _titleLabel.text = title;
    
    _pickerType = pickerType;
    _subTitles = subTitles;
    _sure = sure;
    _cancle = cancle;
    if (_pickerType != GSPickerTypeDatePicker) {
        if (_subTitles.count == 0)GSLog(@"GSPickerView数据源不可为空");
        if ([_subTitles containsObject:selectedStr]) {
            _selectedRow = [_subTitles indexOfObject:selectedStr];
            [self.picker selectRow:_selectedRow inComponent:0 animated:YES];
        }
        [self.contentView addSubview:self.picker];
        if ([self.contentView.subviews containsObject:self.datePicker]) {
            [self.datePicker removeFromSuperview];
        }
    }
    else{
        if (selectedStr && selectedStr.length != 0) {
            NSDate *date = [[FSUtils profileDateFormatter] dateFromString:selectedStr];
            [self.datePicker setDate:date];
        }
        [self.contentView addSubview:self.datePicker];
        if ([self.contentView.subviews containsObject:self.picker]) {
            [self.picker removeFromSuperview];
        }
    }
    [kWindow addSubview:self];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    [self.contentView setTransform:CGAffineTransformMakeTranslation(0,CGRectGetHeight(self.contentView.frame))];
    [UIView animateWithDuration:0.25 animations:^{
        [self.contentView setTransform:CGAffineTransformIdentity];
    } completion:^(BOOL finished) {
    }];
}
- (void)disAppear{
    [self removeFromSuperview];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _subTitles.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _subTitles[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedRow = row;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
