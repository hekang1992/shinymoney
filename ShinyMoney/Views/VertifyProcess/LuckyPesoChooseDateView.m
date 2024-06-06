//
//  LuckyPesoChooseDateView.m
//  LuckyPesoProject
//
//  Created by Apple on 2023/12/19.
//

#import "LuckyPesoChooseDateView.h"
#import "Masonry.h"
#import "NSDate+JKExtension.h"
#import "Hue-Swift.h"
#import "ShinyMoney-Swift.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface LuckyPesoChooseDateView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)UIPickerView *pickerview;
@property (nonatomic, strong)NSString *currentYear;
@property (nonatomic, strong)NSString *currentMonth;
@property (nonatomic, strong)NSString *currentDay;
@property (nonatomic, strong)NSMutableArray *yearArr;
@property (nonatomic, strong)NSArray *monthArr;
@property (nonatomic, strong)NSMutableArray *dayArr;
@property (nonatomic, assign)NSCalendarUnit unitFlags;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic)NSInteger selectedMonthRow;
@property (nonatomic)NSInteger selectedYearRow;
@property (nonatomic)NSInteger selectedDayRow;
@end

@implementation LuckyPesoChooseDateView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.pesoContentView.layer.cornerRadius = 4.0;
    self.pesoContentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.pesoContentView.layer.borderWidth = 1.0;
    
    self.yearArr = [NSMutableArray array];
    self.monthArr = [NSMutableArray array];
    self.dayArr = [NSMutableArray array];
    [self.pesoContentView addSubview:self.pickerview];
    [self.pickerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(self.pesoChangeDateLabel.mas_bottom).mas_offset(0);
        make.bottom.mas_offset(-100);
    }];
}

-(void)setDateStr:(NSString *)dateStr{
    _dateStr = dateStr;
    [self getDateArr];
    [self.pickerview reloadAllComponents];
}

- (IBAction)pesoCloseAction:(id)sender {
    [self removeFromSuperview];
    if(self.cancelBlock){
        self.cancelBlock();
    }
}

-(UIPickerView *)pickerview{
    if(!_pickerview){
        _pickerview = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerview.backgroundColor = [UIColor clearColor];
        _pickerview.layer.masksToBounds = YES;
        _pickerview.delegate = self;
        _pickerview.dataSource = self;
    }
    return _pickerview;
}

-(void)getDateArr{
    NSArray *timeArr = [_dateStr componentsSeparatedByString:@"/"];
    self.currentYear = timeArr[0];
    self.currentMonth = timeArr[1];
    self.currentDay = timeArr[2];
    NSInteger currentYear = self.currentYear.intValue;
    for(int i=0;i<81;i++){
        [self.yearArr insertObject:[NSString stringWithFormat:@"%ld",(long)currentYear - i] atIndex:0];
    }
    for(int i=1;i<81;i++){
        [self.yearArr addObject:[NSString stringWithFormat:@"%ld",(long)currentYear + i]];
    }
    
    self.monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
   
    NSString *currentYeadAndMonth = [NSString stringWithFormat:@"%@-%@",self.currentYear,self.currentMonth];
    NSDate *selectedDate = [NSDate jk_dateWithString:currentYeadAndMonth format:@"yyyy-MM"];
    NSInteger daylength = [NSDate jk_daysInMonth:selectedDate];
    for(int i=1;i<=daylength;i++){
        NSString *dayStr;
        if(i<10){
            dayStr = [NSString stringWithFormat:@"0%ld",(long)i];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",(long)i];
        }
        [self.dayArr addObject:dayStr];
    }
    
    [self.pickerview reloadAllComponents];
    
    for(int i=0;i<self.dayArr.count;i++){
        NSString *day = self.dayArr[i];
        if(self.currentDay.intValue == day.intValue){
            self.selectedDayRow = i;
            [self.pickerview selectRow:i inComponent:0 animated:YES];
        }
    }
    
    for(int i=0;i<self.monthArr.count;i++){
        NSString *month = self.monthArr[i];
        if(self.currentMonth.intValue == month.intValue){
            self.selectedMonthRow = i;
            [self.pickerview selectRow:i inComponent:1 animated:YES];
        }
    }
    
    for(int i=0;i<self.yearArr.count;i++){
        NSString *year = self.yearArr[i];
        if(self.currentYear.integerValue == year.intValue){
            self.selectedYearRow = i;
            [self.pickerview selectRow:i inComponent:2 animated:YES];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.dayArr.count;
    }else if(component == 1){
        return self.monthArr.count;
    }else{
        return self.yearArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return self.dayArr[row];
    }else if(component == 1){
        return self.monthArr[row];
    }else{
        return self.yearArr[row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:[UIFont systemFontOfSize:14.f]];
        pickerLabel.textColor = [[UIColor alloc] initWithHex:@"888888"];
    }
    if((component == 2 && row == _selectedYearRow) || (component == 1 && row == _selectedMonthRow) || (component == 0 && row == _selectedDayRow)){
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
        pickerLabel.textColor = [[UIColor alloc] initWithHex:@"000000"];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *piketLabel =  (UILabel *)[pickerView viewForRow:row forComponent:component];
    piketLabel.textColor = [[UIColor alloc] initWithHex:@"FFC100"];
    if(component == 0){
        self.selectedDayRow = row;
    }else if(component == 1){
        self.selectedMonthRow = row;
        self.currentMonth = self.monthArr[row];
    }else if(component == 2){
        self.selectedYearRow = row;
        self.currentYear = self.yearArr[row];
    }
    
    [self.dayArr removeAllObjects];
    NSString *currentYeadAndMonth = [NSString stringWithFormat:@"%@-%@",self.currentYear,self.currentMonth];
    NSDate *selectedDate = [NSDate jk_dateWithString:currentYeadAndMonth format:@"yyyy-MM"];
    NSInteger daylength = [NSDate jk_daysInMonth:selectedDate];
    for(int i=1;i<=daylength;i++){
        NSString *dayStr;
        if(i<10){
            dayStr = [NSString stringWithFormat:@"0%ld",(long)i];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",(long)i];
        }
        [self.dayArr addObject:dayStr];
    }
    if(self.dayArr.count - 1 < self.selectedDayRow){
        self.selectedDayRow = self.dayArr.count - 1;
    }
    
    [self.pickerview reloadAllComponents];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
     return 40;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return (SCREEN_WIDTH - 30)/3;
}

- (IBAction)confirmAction:(id)sender {
    [self removeFromSuperview];
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@/%@",self.dayArr[_selectedDayRow],self.monthArr[_selectedMonthRow],self.yearArr[_selectedYearRow]];
    if(self.confirmBlock){
        self.confirmBlock(dateStr);
    }
}
@end
