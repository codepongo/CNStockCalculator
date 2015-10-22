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

@interface CalculatorViewController ()
@property NSArray* all;
@property NSMutableArray* cur;
@property NSArray* pickerData;
@property SimulateActionSheet *sheet;
 //CalculateBrain* brain;
@property id value;
@end

@implementation CalculatorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.brain = [[CalculateBrain alloc] init];
//    self.brain.inSZ = NO;
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
                            ,@"key":@"code"
                        }
                        ,@{
                            @"cellReuseIdentifier":@"InputCell"
                            ,@"title":@"股票类型"
                            ,@"value":@"inSZ"
                        }
                        ,@{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"买入价格"
                            ,@"placeholder":@"0.00"
                            ,@"unit":@"元"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.buy.price"
                        }
                       ,@{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"买入数量"
                            ,@"placeholder":@"0"
                            ,@"unit":@"股"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.buy.quantity"
                       }
                       ,@{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"卖出价格"
                            ,@"placeholder":@"0.00"
                            ,@"unit":@"元"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.sell.price"
                       }
                       ,@{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"卖出数量"
                            ,@"placeholder":@"0"
                            ,@"unit":@"股"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.sell.quantity"
                       }
                       ,@{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"券商佣金比率"
                            ,@"placeholder":@"0"
                            ,@"unit":@"%"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.rate.commission"
                       },@{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"印花税税率"
                            ,@"placeholder":@"0"
                            ,@"unit":@"%"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.rate.stamp"
                       },
                       @{
                            @"cellReuseIdentifier":@"InputCellWithUnit"
                            ,@"title":@"过户费费率"
                            ,@"placeholder":@"0"
                            ,@"unit":@"%"
                            ,@"inputtype":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]
                            ,@"value":@"brain.rate.transfer"
                        }
                    ]
                    ,@[
                    @{
                            @"cellReuseIdentifier":@"OutputCell"
                            ,@"title": @"过户费"
                            ,@"value": @"0.00"
                            ,@"value":@"brain.transfer"
                    }
                    ,@{
                        @"cellReuseIdentifier":@"OutputCell"
                        ,@"title": @"印花税"
                            ,@"value": @"0.00"
                            ,@"value":@"brain.stamp"
                    }
                    ,@{
                        @"cellReuseIdentifier":@"OutputCell"
                        ,@"title": @"券商佣金"
                            ,@"value": @"0.00"
                            ,@"value":@"brain.commission"
                    }
                    ,@{
                        @"cellReuseIdentifier":@"OutputCell"
                        ,@"title": @"税费合计"
                            ,@"value": @"0.00"
                            ,@"value":@"brain.cost"
                    }
                    ,@{
                        @"cellReuseIdentifier":@"OutputCell"
                        ,@"title": @"投资损益"
                            ,@"value": @"0.00"
                            ,@"value":@"brain."
                    }
                   ]
                ];
    self.cur = [NSMutableArray array];
    [self.cur addObject:[NSMutableArray arrayWithArray:[self.all objectAtIndex:0]]];
    
}


#pragma mark -
#pragma mark KeyBoard

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

- (NSString * _Nullable)tableView:(UITableView * _Nonnull)tableView
          titleForHeaderInSection:(NSInteger)section {
    return nil;//[NSString stringWithFormat:@"%ld", section];
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.cur[section] count];
}

- (NSArray<NSString *>*)sectionIndexcurForTableView:(UITableView * _Nonnull)tableView {
    return nil;
}

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
        self.value = item[@"value"];
        c.input.placeholder = item[@"placeholder"];
        c.input.keyboardType = [item[@"keyboardtype"] integerValue];
        return c;
    }
    if ([cellId  isEqual: @"InputCellWithUnit"]) {
        InputCellWithUnit* c = [tableView dequeueReusableCellWithIdentifier:cellId];
        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
        c.input.delegate = self;
        c.input.placeholder = item[@"placeholder"];
        c.input.keyboardType = [item[@"keyboardtype"] integerValue];
        c.unit.text = item[@"unit"];
        return c;
    }
    if ([cellId  isEqual: @"ButtonCell"]) {
        ButtonCell* c = [tableView dequeueReusableCellWithIdentifier:cellId];
        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
        [c.button addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        return c;
    }
    if ([cellId  isEqual: @"OutputCell"]) {
        OutputCell* c = [tableView dequeueReusableCellWithIdentifier:@"OutputCell"];
        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
        c.result.text = self.cur[indexPath.section][indexPath.row][@"value"];
        return c;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //if (section == 2) {
        return 0.01;
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
        [footer.reset addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
        footer.calculate.layer.cornerRadius = 5.0; //设置矩形四个圆角半径
        footer.calculate.layer.borderWidth = 1.0; //边框宽度
        footer.calculate.layer.borderColor = footer.calculate.backgroundColor.CGColor;
        [footer.calculate addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
        
        return (UIView*)footer;
    }
   if (section == 1) {
//        SaveFooter* save = (CalculateFooter*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SaveFooter"];
//        save.save.layer.cornerRadius = 5.0; //设置矩形四个圆角半径
//        save.save.layer.borderWidth = 1.0; //边框宽度
//        save.save.layer.borderColor = footer.reset.titleLabel.textColor.CGColor;
//        [save.save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
//        return (UIView*)footer;
   }
    return tableView.tableFooterView;
}

-(void) select:(id)sender{
//    sheet = [SimulateActionSheet styleDefault];
//    sheet.delegate = self;
//    //必须在设置delegate之后调用，否则无法选中指定的行
//    if (sender.labelText == self.pickerData objectAtIndex(0)) {
//        [sheet selectRow:0 inComponent:0 animated:YES];
//    }
//    else {
//        [sheet selectRow:1 inComponent:0 animated:YES];
//    }
//   
//    [sheet show:self];
//    [sender.labelText = self.pickerData objectAtIndex:self.type];
}

-(void) calculate:(id)sender{
    if (self.cur.count == 1) {
        [self.cur addObject:[self.all objectAtIndex:1]];
    }
    //brain calculates.
    [self.layout reloadData];
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.layout scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) reset:(id)sender {
    //for (UITableViewCell* c in [self.layout ])
    if (self.cur.count == 2) {
        [self.cur removeObjectAtIndex:1];
    }
    [self.layout reloadData];
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.layout scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) save:(id)sender{

}
#pragma mark -
#pragma mark Text Field Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSIndexPath* path = [self.layout indexPathForCell:(UITableViewCell*)textField.superview.superview];
    if (self.cur[path.section][path.row][@"placeholder"] == nil) {
        return NO;
    }
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.value = textField.text;
}

#pragma mark -
#pragma mark Table View Delegate


- (IBAction)changeTradeType:(id)sender {
//    self.brain.inSZ = !self.brain.inSZ;
//    if (!self.brain.inSZ) {
//        [self.cur[0] removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4,2)]];
//    }
//    else {
//        [self.cur[0] insertObject:self.all[0][3] atIndex:4];
//        [self.cur[0] insertObject:self.all[0][3] atIndex:5];
//    }
//    [self.layout reloadData];

}

-(void)actionCancle{
    //[sheet dismiss:self];
}

-(void)actionDone{
    //[sheet dismiss:self];
    
    //NSUInteger index = [sheet selectedRowInComponent:0];
    //self.type = index;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerData.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

@end