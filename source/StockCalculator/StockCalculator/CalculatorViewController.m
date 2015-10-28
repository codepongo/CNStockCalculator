//
//  CalculatorViewController.m
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/13.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "CalculatorViewController.h"
#import "InputCell.h"
#import "InputCellWithUnit.h"
#import "OutputCell.h"
#import "ButtonCell.h"
#import "CalculateFooter.h"
#import "SimulateActionSheet.h"
#import "SaveFooter.h"
#import "SimulateActionSheet.h"
#import "CalculateBrain.h"

@interface CalculatorViewController ()
@property NSArray* all;
@property NSMutableArray* cur;
@property NSArray* pickerData;
@property(nonatomic, strong) SimulateActionSheet *sheet;
@property(nonatomic, strong) CalculateBrain* brain;
@property id value;
@property (nonatomic, weak) UIButton* marketOfStock;

@end

@implementation CalculatorViewController
@synthesize sheet;

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.brain = [[CalculateBrain alloc] init];
    [self.brain setCalculateForGainOrLoss:YES];
    // Do any additional setup after loading the view, typically from a nib.
    self.keyBoardBackground = [[UIButton alloc]initWithFrame:self.layout.frame];
    self.keyBoardBackground.backgroundColor = [UIColor clearColor];
    [self.keyBoardBackground addTarget:self action:@selector(hideKeyBoard:) forControlEvents:UIControlEventTouchDown];
    self.keyBoardBackground.hidden = YES;
    [self.layout registerNib:[UINib nibWithNibName:@"InputCell" bundle:nil]forCellReuseIdentifier:@"InputCell"];
    [self.layout registerNib:[UINib nibWithNibName:@"InputCellWithUnit" bundle:nil] forCellReuseIdentifier:@"InputCellWithUnit"];
    [self.layout registerNib:[UINib nibWithNibName:@"OutputCell" bundle:nil] forCellReuseIdentifier:@"OutputCell"];
    [self.layout registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:nil] forCellReuseIdentifier:@"ButtonCell"];
    [self.layout registerNib:[UINib nibWithNibName:@"CalculateFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"CalculateFooter"];
    [self.layout registerNib:[UINib nibWithNibName:@"SaveFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SaveFooter"];
    self.pickerData = @[@"上海A股", @"深圳A股"];
    self.all = @[
                 @[
                     @{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"股票代码"
                         ,@"placeholder":@"代码／名称"
                         ,@"keyboardtype":[NSNumber numberWithInt:UIKeyboardTypeDefault]
                         ,@"value":@"code"
                         }
                     ,@{
                         @"cellReuseIdentifier":@"ButtonCell"
                         ,@"title":@"股票类型"
                         ,@"value":@"inSZ"
                         }
                     ,@{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"买入价格"
                         ,@"placeholder":@"0.00"
                         ,@"unit":@"元／股"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"buy.price"
                         }
                     ,@{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"买入数量"
                         ,@"placeholder":@"0"
                         ,@"unit":@"股"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"buy.quantity"
                         }
                     ,@{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"卖出价格"
                         ,@"placeholder":@"0.00"
                         ,@"unit":@"元／股"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"sell.price"
                         }
                     ,@{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"卖出数量"
                         ,@"placeholder":@"0"
                         ,@"unit":@"股"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"sell.quantity"
                         }
                     ,@{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"佣金比率"
                         ,@"placeholder":@"‰（不足5元，按5元收取）"
                         ,@"unit":@"‰"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"rate.commission"
                         },@{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"印花税率"
                         ,@"placeholder":@"0.1‰（仅在卖出征收）"
                         ,@"unit":@"‰"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"rate.stamp"
                         },
                     @{
                         @"cellReuseIdentifier":@"InputCell"
                         ,@"title":@"过户费率"
                         ,@"placeholder":@"1元／千股（最低1元收取）"
                         ,@"unit":@"元／千股"
                         ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                         ,@"value":@"rate.transfer"
                         }
                     ]
                 ,@[
                     [NSMutableDictionary dictionaryWithDictionary:@{
                                                                     @"cellReuseIdentifier":@"OutputCell"
                                                                     ,@"title": @"过户费"
                                                                     ,@"value": @"0.00"
                                                                     ,@"unit":@"元"
                                                                     }]
                     ,[NSMutableDictionary dictionaryWithDictionary:@{
                                                                      @"cellReuseIdentifier":@"OutputCell"
                                                                      ,@"title": @"印花税"
                                                                      ,@"value": @"0.00"
                                                                      ,@"unit":@"元"
                                                                      }]
                     ,[NSMutableDictionary dictionaryWithDictionary:@{
                                                                      @"cellReuseIdentifier":@"OutputCell"
                                                                      ,@"title": @"券商佣金"
                                                                      ,@"value": @"0.00"
                                                                      ,@"unit":@"元"
                                                                      }]
                     ,[NSMutableDictionary dictionaryWithDictionary:@{
                                                                      @"cellReuseIdentifier":@"OutputCell"
                                                                      ,@"title": @"税费合计"
                                                                      ,@"value": @"0.00"
                                                                      ,@"unit":@"元"
                                                                      }]
                     ,[NSMutableDictionary dictionaryWithDictionary:@{
                                                                      @"cellReuseIdentifier":@"OutputCell"
                                                                      ,@"titleForGainOrLoss": @"投资损益"
                                                                      ,@"titleForBreakevenPrice": @"保本价格"
                                                                      ,@"value": @"0.00"
                                                                      ,@"unitForGainOrLoss":@"元"
                                                                      ,@"unitForBreakevenPrice": @"元／股"
                                                                      }]
                     ]
                 ];
    self.cur = [NSMutableArray array];
    [self.cur addObject:[NSMutableArray arrayWithArray:[self.all objectAtIndex:0]]];
    [self.cur[0] removeLastObject];
}


#pragma mark -
#pragma mark KeyBoard Methods

-(void)hideKeyBoard:(id)sender {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
#pragma clang diagnostic pop
    [firstResponder resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    if (self.keyBoardBackground.hidden == NO) {
        return;
    }
    [self.view addSubview:self.keyBoardBackground];
    self.keyBoardBackground.hidden = NO;
 #define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")
    CGRect keyboardRect = [self.view convertRect:[[[note userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
    if (CGRectIsEmpty(keyboardRect)) {
        return;
    }
    
    self.layoutOriginContentOffset = self.layout.contentOffset;
    CGRect frame = self.layout.frame;
    frame.size.height = keyboardRect.origin.y - self.layout.frame.origin.y - 10;
    NSValue* duration = [[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval interval;
    [duration getValue:&interval];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:interval];
    self.layout.frame = frame;
}

- (void)keyboardWillHide:(NSNotification*)note {
    if (self.keyBoardBackground.hidden == YES) {
        return;
    }
    self.keyBoardBackground.hidden = YES;
    [self.keyBoardBackground removeFromSuperview];
    
    
    NSValue* duration = [[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval interval;
    [duration getValue:&interval];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:interval];
    self.layout.contentOffset = self.layoutOriginContentOffset;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cur.count;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.cur[section] count];
}

#pragma mark -
#pragma mark Table View Delegate Methods

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    return 30;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* item = self.cur[indexPath.section][indexPath.row];
    NSString* cellId = item[@"cellReuseIdentifier"];
    if (cellId == nil) {
        return nil;
    }
    if ([cellId  isEqual: @"InputCell"]) {
        InputCell* c = [tableView dequeueReusableCellWithIdentifier:cellId];
        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
        c.input.delegate = self;
        NSNumber* v = (NSNumber*)[self.brain valueForKeyPath:item[@"value"]];
        if (v != nil && [v floatValue] != 0) {
            c.input.text = [NSString stringWithFormat:@"%g %@",[v floatValue], item[@"unit"]];
        }
        else {
            c.input.text = @"";
        }
        c.input.placeholder = item[@"placeholder"];
        c.input.keyboardType = [item[@"inputtype"] integerValue];
        return c;
    }
    if ([cellId  isEqual: @"InputCellWithUnit"]) {
        InputCellWithUnit* c = [tableView dequeueReusableCellWithIdentifier:cellId];
        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
        c.input.delegate = self;
        c.input.placeholder = [NSString stringWithFormat:@"%@%@", item[@"placeholder"],item[@"unit"]];
        c.input.keyboardType = [item[@"inputtype"] integerValue];
        c.unit.text = item[@"unit"];
        return c;
    }
    if ([cellId  isEqual: @"ButtonCell"]) {
        ButtonCell* c = [tableView dequeueReusableCellWithIdentifier:cellId];
        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
        self.marketOfStock = c.button;
        [c.button addTarget:self action:@selector(selectMarketOfStock:) forControlEvents:UIControlEventTouchUpInside];
//        c.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [c.button setTitle:self.pickerData[1] forState:UIControlStateNormal];
        
        return c;
    }
    if ([cellId  isEqual: @"OutputCell"]) {
        OutputCell* c = [tableView dequeueReusableCellWithIdentifier:@"OutputCell"];
        NSString* title = self.cur[indexPath.section][indexPath.row][@"title"];
        if (nil != title) {
            c.title.text = title;
            c.unit.text = self.cur[indexPath.section][indexPath.row][@"unit"];
        }
        else {
            if ([self.brain calculateForGainOrLoss]) {
                c.title.text = self.cur[indexPath.section][indexPath.row][@"titleForGainOrLoss"];
                c.unit.text = self.cur[indexPath.section][indexPath.row][@"unitForGainOrLoss"];
            }
            else {
                c.title.text = self.cur[indexPath.section][indexPath.row][@"titleForBreakevenPrice"];
                c.unit.text = self.cur[indexPath.section][indexPath.row][@"unitForBreakevenPrice"];
            }
        }
        
        c.result.text = self.cur[indexPath.section][indexPath.row][@"value"];
        return c;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //if (section == 2) {
    return 0.001;
    //}
    //return tableView.sectionHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CalculateFooter"].frame.size.height;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        CalculateFooter* footer = (CalculateFooter*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CalculateFooter"];
        [footer.contentView setFrame:CGRectMake(0, 0, footer.frame.size.width, 44)];
        
        //[cell.reset.layer setMasksToBounds:YES];
        footer.reset.layer.cornerRadius = 5.0; //设置矩形四个圆角半径
        footer.reset.layer.borderWidth = 1.0; //边框宽度
        footer.reset.layer.borderColor = footer.reset.titleLabel.textColor.CGColor;
        [footer.reset addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
        footer.calculate.layer.cornerRadius = 5.0; //设置矩形四个圆角半径
        footer.calculate.layer.borderWidth = 1.0; //边框宽度
        footer.calculate.layer.borderColor = footer.calculate.backgroundColor.CGColor;
        [footer.calculate addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
        
        return (UIView*)footer;
    }
    if (section == 1) {
        SaveFooter* footer = (SaveFooter*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SaveFooter"];
        footer.save.layer.cornerRadius = 5.0; //设置矩形四个圆角半径
        footer.save.layer.borderWidth = 1.0; //边框宽度
        footer.save.layer.borderColor = footer.save.backgroundColor.CGColor;
        [footer.save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        return (UIView*)footer;
    }
    return tableView.tableFooterView;
}


#pragma mark -
#pragma mark Outlet Action Methods

-(void) selectMarketOfStock:(id)sender{
    UIButton* button = sender;
    if (self.sheet == nil) {
        self.sheet = [SimulateActionSheet styleDefault];
    }
    
    self.sheet.delegate = self;
    //    //必须在设置delegate之后调用，否则无法选中指定的行
    if (button.currentTitle == [self.pickerData objectAtIndex:0]) {
        [self.sheet selectRow:0 inComponent:0 animated:YES];
    }
    else {
        [self.sheet selectRow:1 inComponent:0 animated:YES];
    }
    [self.sheet show:self];
}

-(void) calculate:(id)sender{
    if (self.cur.count == 1) {
        [self.cur addObject:[self.all objectAtIndex:1]];
    }
    //brain calculates.
    float transfer = [self.brain transferOfTrade];
    float stamp = [self.brain stampOfTrade];
    float commission = [self.brain commissionOfTrade];
    float taxesAndDuties = [self.brain taxesAndDutiesOfTrade];
    float result = [self.brain resultOfTrade];
    [self.cur[1][0] setObject:[NSString stringWithFormat:@"%.2f", transfer] forKey:@"value"];
    self.cur[1][1][@"value"] = [NSString stringWithFormat:@"%.2f", stamp];
    self.cur[1][2][@"value"] = [NSString stringWithFormat:@"%.2f", commission];
    self.cur[1][3][@"value"] = [NSString stringWithFormat:@"%.2f", taxesAndDuties];
    self.cur[1][4][@"value"] = [NSString stringWithFormat:@"%.2f", result];
    [self.layout reloadData];
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.layout scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) reset {
    if (self.cur.count == 2) {
        [self.cur removeObjectAtIndex:1];
    }
    [self.brain reset];
    [self.layout reloadData];
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.layout scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) save:(id)sender{
    
}

- (IBAction)selectCalculateType:(id)sender {
    [self.brain setCalculateForGainOrLoss: ![self.brain calculateForGainOrLoss]];
    if (!self.brain.calculateForGainOrLoss) {
        [self.cur[0] removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4,2)]];
    }
    else {
        [self.cur[0] insertObject:self.all[0][4] atIndex:4];
        [self.cur[0] insertObject:self.all[0][5] atIndex:5];
    }
    if ([self.cur count] == 2) {
        [self.cur removeObjectAtIndex:1];
    }
    [self.layout reloadData];
    
}

#pragma mark -
#pragma mark Text Field Delegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath* path = [self.layout indexPathForCell:(UITableViewCell*)textField.superview.superview];
    [self.brain setValue:[NSNumber numberWithFloat:textField.text.floatValue] forKeyPath:self.cur[path.section][path.row][@"value"]];
    
    if (![textField.text  isEqual: @""]) {
        textField.text = [NSString stringWithFormat:@"%@ %@",textField.text, self.cur[path.section][path.row][@"unit"]];
    }
}

/*
 - (void)textFieldDidBeginEditing:(UITextField *)textField
 {
 self.currentTextField = textField;
 NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) [self.tableView viewWithTag:self.currentTextField.tag]];
 UITableViewCell *cell = (UITableViewCell *) [textField superview];
 indexPath = [self.tableView indexPathForCell:cell];
 //[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
 //int currentIndex = textField.tag;
 CGRect frame = textField.frame;
 CGFloat rowHeight = self.tableView.rowHeight;
 //下面的代码只是为了判断是哪一个textField,可以根据自己的情况进行修改，我为了测试加了7个
 if (indexPath.row == 0) {
 frame.origin.y += rowHeight * 0;
 } else if (indexPath.row==1) {
 frame.origin.y += rowHeight * 1;
 } else if (indexPath.row == 2) {
 frame.origin.y += rowHeight * 2;
 } else if (indexPath.row ==3){
 frame.origin.y += rowHeight * 3;
 }else if(indexPath.row==4)
 {
 frame.origin.y +=rowHeight *4;
 } else if(indexPath.row==5)
 {
 frame.origin.y +=rowHeight *5;
 } else if(indexPath.row==6)
 {
 frame.origin.y +=rowHeight *6;
 }
 CGFloat viewHeight = self.tableView.frame.size.height;
 CGFloat halfHeight = viewHeight / 2;
 CGFloat halfh= frame.origin.y +(textField.frame.size.height / 2);
 if(halfh<halfHeight){
 frame.origin.y = 0;
 frame.size.height =halfh;
 }else{
 frame.origin.y =halfh;
 frame.size.height =halfh;
 }
 [self.tableView scrollRectToVisible:frame animated:YES ];
 }
 */

#pragma mark -
#pragma mark Picker Data Source Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

#pragma mark -
#pragma mark Picker Delegate Methods

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

#pragma mark -
#pragma mark Picker Outlet Action Methods

-(void)actionCancle{
    [sheet dismiss:self];
}

-(void)actionDone{
    [sheet dismiss:self];
    
    NSUInteger index = [sheet selectedRowInComponent:0];
    
    self.brain.inSZ = index == 0 ? NO:YES;
    [self.marketOfStock setTitle:self.pickerData[index] forState:UIControlStateNormal];
    if (self.brain.inSZ) {
        [self.cur[0] removeLastObject];
    }
    else {
        [self.cur[0] addObject:self.all[0][[self.all[0]     count]-1]];
    }
    [self.layout reloadData];
}
@end
