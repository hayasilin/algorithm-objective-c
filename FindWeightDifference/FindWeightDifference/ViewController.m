//
//  ViewController.m
//  FindWeightDifference
//
//  Created by Kuan-Wei on 2016/8/9.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *pickNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *runProgramButton;

@property (weak, nonatomic) IBOutlet UILabel *firstWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdWeightLabel;

@property (nonatomic, strong) NSMutableDictionary *ballDictsAll;
@property (nonatomic, strong) NSMutableDictionary *ballDicts1;
@property (nonatomic, strong) NSMutableDictionary *ballDicts2;
@property (nonatomic, strong) NSMutableDictionary *ballDicts3;

@property (nonatomic, strong) NSString *resultString;
@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) NSNumber *chosedNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"請選擇您希望的選項" style:UIBarButtonItemStyleDone target:self action:nil];
    
    //讓aboutButton置中
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace, aboutButton, flexibleSpace, nil]];
    
    self.pickerArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    self.pickNumberTextField.inputView = pickerView;
    self.pickNumberTextField.inputAccessoryView = toolBar;
    self.pickNumberTextField.delegate = self;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    //Key表示球的編號，Value表示球的重量
//    self.ballDictsAll = @{
//                       @1:@10,
//                       @2:@10,
//                       @3:@10,
//                       @4:@10,
//                       @5:@10,
//                       @6:@10,
//                       @7:@10,
//                       @8:@10,
//                       @9:@10,
//                       @10:@10,
//                       @11:@10,
//                       @12:@10,
//                       };
//    
//    //將12顆球分成3組
//    self.ballDicts1 = @{
//                        @1:@10,
//                        @2:@10,
//                        @3:@10,
//                        @4:@1,
//                        };
//    
//    self.ballDicts2 = @{
//                        @5:@10,
//                        @6:@10,
//                        @7:@10,
//                        @8:@10,
//                        };
//    
//    self.ballDicts3 = @{
//                        @9:@10,
//                        @10:@10,
//                        @11:@10,
//                        @12:@10,
//                        };

}

- (IBAction)pickNumberRandomlyButtonPressed:(UIButton *)sender {
    int randomNumber = [self generateRandomValue];
    self.chosedNumber = [NSNumber numberWithInt:randomNumber];
    self.pickNumberTextField.text = [NSString stringWithFormat:@"%i", randomNumber];
}

- (int)generateRandomValue{
    //亂數產生1~12的數值，總共12個數字變化
    u_int32_t n = arc4random() % 12 + 1;
    NSLog(@"%u", n);
    
    return n;
}

- (BOOL)checkTextFieldInput{
    if ([self.pickNumberTextField.text isEqualToString:@""] || [self.pickNumberTextField.text length] == 0 || self.pickNumberTextField.text == nil) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"選擇欄不能空白喔" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }else{
        return YES;
    }
}

- (IBAction)runProgramButtonPressed:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (![self checkTextFieldInput]) {
        return;
    }
    
    NSLog(@"Chosednumber = %@", self.chosedNumber);

    //重新求的Dictionary，Key是球的編號，Value是球的重量
    self.ballDictsAll = [NSMutableDictionary dictionary];
    
    NSNumber *num;
    //設定正常的球重是10
    NSNumber *weight = [NSNumber numberWithInt:10];
    //設定問題球的球重是9
    NSNumber *differntWeight = [NSNumber numberWithInt:9];
    
    for (int i = 1; i < 13 ; i++) {
        num = [NSNumber numberWithInt:i];
        if (i == [self.chosedNumber intValue]) {
            [self.ballDictsAll setObject:differntWeight forKey:num];
        }else{
            [self.ballDictsAll setObject:weight forKey:num];
        }
    }
        
    NSLog(@"%@", self.ballDictsAll);
    
    //將12顆球分成3組
    self.ballDicts1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.ballDictsAll[@1], @1, self.ballDictsAll[@2], @2, self.ballDictsAll[@3], @3, self.ballDictsAll[@4], @4, nil];
    
    NSLog(@"self.ballDicts1 = %@", self.ballDicts1);
    
    self.ballDicts2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.ballDictsAll[@5], @5, self.ballDictsAll[@6], @6, self.ballDictsAll[@7], @7, self.ballDictsAll[@8], @8, nil];
    
    NSLog(@"self.ballDicts2 = %@", self.ballDicts2);
    
    self.ballDicts3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.ballDictsAll[@9], @9, self.ballDictsAll[@10], @10, self.ballDictsAll[@11], @11, self.ballDictsAll[@12], @12, nil];
    
    NSLog(@"self.ballDicts3 = %@", self.ballDicts3);
    
    [self runCaculation];
}

- (void)runCaculation{

    //計算各組各自的重量
    int ballDicts1Sum = [self.ballDicts1[@1] intValue] + [self.ballDicts1[@2] intValue] + [self.ballDicts1[@3] intValue] + [self.ballDicts1[@4] intValue];
    
    int ballDicts2Sum = [self.ballDicts2[@5] intValue] + [self.ballDicts2[@6] intValue] + [self.ballDicts2[@7] intValue] + [self.ballDicts2[@8] intValue];
    
    self.firstWeightLabel.text = @"先將12個球從1至12編號，並將12個球分成3組，每組4顆球，並先秤重第一組及第二組";
    
    //先秤重第1組跟第2組
    if (ballDicts1Sum == ballDicts2Sum) {
        //第1組跟第2組重量一樣，表示有問題的球在第3組
        
        self.secondWeightLabel.text = @"第1組跟第2組重量一樣，表示有問題的球在第3組。接著從第1組挑前3個球，另外一邊從第3組挑前3個球，兩邊進行秤重";
        
        //隨機從第1組或第2組挑3個球求總重
        int pickThreeBallInNormalGroupSum = [self.ballDicts1[@1] intValue] + [self.ballDicts1[@2] intValue] + [self.ballDicts1[@3] intValue];
        
        //隨機從第3組挑3個球求總重
        int pickThreeBallInAbnormalGroupSum = [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue];
        
        if (pickThreeBallInNormalGroupSum == pickThreeBallInAbnormalGroupSum) {
            //此兩組重量一樣，代表問題球在第3組中沒被挑到的那顆
            
            NSArray *keyNameArray = [self.ballDicts3 allKeysForObject:self.ballDicts3[@12]];
            NSString *keyName = keyNameArray[0];
            
            self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts3[@12] intValue]];
            NSLog(@"%@", self.resultString);
            
            self.thirdWeightLabel.text = [NSString stringWithFormat:@"此兩組重量一樣，代表問題球在第3組中沒被挑到的那顆, %@", self.resultString];
            
        }else{
            //此兩組重量不同，代表問題球第3組被挑出來秤重的3個球之中
            
            //拿其中2個來秤重
            if ([self.ballDicts3[@9] intValue] == [self.ballDicts3[@10] intValue]) {
                //此兩顆球重量一樣，問題球在剩下那棵
                
                NSArray *keyNameArray = [self.ballDicts3 allKeysForObject:self.ballDicts3[@11]];
                NSString *keyName = keyNameArray[0];
                
                self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts3[@11] intValue]];
                NSLog(@"%@", self.resultString);
                
                self.thirdWeightLabel.text = [NSString stringWithFormat:@"此兩組重量不同，代表問題球第3組被挑出來秤重的3個球之中，接著拿第3組中別拿來秤中的3個球中的2個球秤中，此兩顆球重量一樣，則問題球在剩下的那一顆, %@", self.resultString];
                
            }else{
                //此兩顆球重量不同，問題球在其中一顆
                
                if ([self.ballDicts3[@9] intValue] != 10) {
                    
                    NSArray *keyNameArray = [self.ballDicts3 allKeysForObject:self.ballDicts3[@9]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts3[@9] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"此兩組重量不同，代表問題球在第3組被挑出來秤重的3個球之中，接著拿第3組中別拿來秤中的3個球中的2個球秤中，可得知問題球在哪顆, %@", self.resultString];
                }
                
                if ([self.ballDicts3[@10] intValue] != 10) {
                    
                    NSArray *keyNameArray = [self.ballDicts3 allKeysForObject:self.ballDicts3[@10]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts3[@10] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"此兩組重量不同，代表問題球在第3組被挑出來秤重的3個球之中，接著拿第3組中別拿來秤中的3個球中的2個球秤中，可得知問題球在哪顆, %@", self.resultString];
                }
            }
        }
    }else{
        //第1組和第2組重量不同，代表問題在2組中之中
        BOOL isHeavyer;
        
        if (ballDicts1Sum > ballDicts2Sum) {
            NSLog(@"ballDicts1Sum是重的那一側");
            isHeavyer = YES;
        }else{
            NSLog(@"ballDicts2Sum是重的那一側");
            isHeavyer = NO;
        }
        
        /*
         把重的一侧四个球记为A1A2A3A4，轻的记为B1B2B3B4。
         剩下的确定为四个正常的记为C。
         把A1B2B3B4放到一边，B1和三个正常的C小球放一边。（第二次）
         */
        
        self.secondWeightLabel.text = @"第1組跟第2組重量不同，代表問題球在2組的之中，把重的一側4個球記為A1A2A3A4，輕的記為B1B2B3B4，第3組確定全都是正常，記為C1C2C3C4。接著把A1B2B3B4放在一邊，B1和3個正常的C球放在另一邊秤重";
        
        if (isHeavyer) {
            
            if (([self.ballDicts1[@1] intValue] + [self.ballDicts2[@6] intValue] + [self.ballDicts2[@7] intValue] + [self.ballDicts2[@8] intValue]) == ([self.ballDicts2[@5] intValue] + [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue])) {
                
                /*情况一：天平平衡了。
                 特殊小球在A2A3A4里面，而且知道特殊小球比较重。 */
                
                //把A2A3称一下，就知道三个里面哪个是特殊的了。（第三次）
                if ([self.ballDicts1[@2] intValue] == [self.ballDicts1[@3] intValue]) {
                    //有問題的是剩下的球
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@4]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@4] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果兩邊平衡，代表問題球在A2A3A4裡面，且知道問題球比較重，接著秤A2A3兩顆球，兩顆重量相同，代表有問題的是剩下的A4球, %@", self.resultString];
                    
                }else if ([self.ballDicts1[@2] intValue] > [self.ballDicts1[@3] intValue]){
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@2]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@2] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果兩邊平衡，代表問題球在A2A3A4裡面，且知道問題球比較重，接著秤A2A3兩顆球，A2球重於A3，代表有問題的是A2球, %@", self.resultString];
                    
                }else{
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@3]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@3] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果兩邊平衡，代表問題球在A2A3A4裡面，且知道問題球比較重，接著秤A2A3兩顆球，A3球重於A2，代表有問題的是A3球, %@", self.resultString];
                }
                
            }else if (([self.ballDicts1[@1] intValue] + [self.ballDicts2[@6] intValue] + [self.ballDicts2[@7] intValue] + [self.ballDicts2[@8] intValue]) > ([self.ballDicts2[@5] intValue] + [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue])){
                /*情况二：天平是A1的那边比较重。
                 特殊的小球在A1和B1之间。
                 随便拿一个和正常的称，就知道哪个特殊了。（第三次） */
                
                if ([self.ballDicts1[@1] intValue] == [self.ballDicts3[@9] intValue]) {
                    //A1的球跟正常的球是一樣重，有問題的是B1
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@5]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@5] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果A1那邊比較重，代表問題球在A1或B1之中，隨便拿一個跟正常的C秤重，就能找出問題球, %@", self.resultString];
                }else{
                    //A1跟正常球的重量不一樣，有問題的是A1
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@1]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@1] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果A1那邊比較重，代表問題球在A1或B1之中，隨便拿一個跟正常的C秤重，就能找出問題球, %@", self.resultString];
                }
                
            }else if (([self.ballDicts1[@1] intValue] + [self.ballDicts2[@6] intValue] + [self.ballDicts2[@7] intValue] + [self.ballDicts2[@8] intValue]) < ([self.ballDicts2[@5] intValue] + [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue])){
                
                /*情况三：天平反过来，B1那边比较重了。
                 特殊小球在B2B3B4中间，而且知道特殊小球比较轻。 */
                
                //把B2B3称一下，就知道哪个是特殊的了。（第三次）
                if ([self.ballDicts2[@6] intValue] == [self.ballDicts2[@7] intValue]) {
                    //有問題的是剩下的球
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@8]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@8] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果B1那邊比較重，代表問題球在B2B3B4之中，而且問題球比較輕，把B2及B3互秤，就能找出問題球,此情況B2及B3重量一樣，因此問題球是B4 %@", self.resultString];
                    
                }else if ([self.ballDicts2[@6] intValue] > [self.ballDicts2[@7] intValue]){
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@7]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@7] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果B1那邊比較重，代表問題球在B2B3B4之中，而且問題球比較輕，把B2及B3互秤，就能找出問題球,此情況B2重量大於B3，代表問題球是B3 %@", self.resultString];
                    
                }else{
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@6]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@6] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果B1那邊比較重，代表問題球在B2B3B4之中，而且問題球比較輕，把B2及B3互秤，就能找出問題球,此情況B3重量大於B2，代表問題球是B2 %@", self.resultString];
                }
                
            }
            
        }else{
            //反過來ballDictsSum2比較重
            
            /*
             把重的一侧四个球记为A1A2A3A4，轻的记为B1B2B3B4。
             剩下的确定为四个正常的记为C。
             把A1B2B3B4放到一边，B1和三个正常的C小球放一边。（第二次）
             */
            
            if (([self.ballDicts2[@5] intValue] + [self.ballDicts1[@2] intValue] + [self.ballDicts1[@3] intValue] + [self.ballDicts1[@4] intValue]) == ([self.ballDicts1[@1] intValue] + [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue])) {
                
                /*情况一：天平平衡了。
                 特殊小球在A2A3A4里面，而且知道特殊小球比较重。 */
                
                //把A2A3称一下，就知道三个里面哪个是特殊的了。（第三次）
                if ([self.ballDicts2[@6] intValue] == [self.ballDicts2[@7] intValue]) {
                    //有問題的是剩下的球
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@8]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@8] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果兩邊平衡，代表問題球在A2A3A4裡面，且知道問題球比較重，接著秤A2A3兩顆球，兩顆重量相同，代表有問題的是剩下的A4球, %@", self.resultString];
                    
                }else if ([self.ballDicts2[@6] intValue] > [self.ballDicts2[@7] intValue]){
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@6]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@6] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果兩邊平衡，代表問題球在A2A3A4裡面，且知道問題球比較重，接著秤A2A3兩顆球，A2球重於A3，代表有問題的是A2球, %@", self.resultString];
                    
                }else{
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@7]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@7] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果兩邊平衡，代表問題球在A2A3A4裡面，且知道問題球比較重，接著秤A2A3兩顆球，A3球重於A2，代表有問題的是A3球, %@", self.resultString];
                }
                
            }else if (([self.ballDicts2[@5] intValue] + [self.ballDicts1[@2] intValue] + [self.ballDicts1[@3] intValue] + [self.ballDicts1[@4] intValue]) > ([self.ballDicts1[@1] intValue] + [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue])){
                /*情况二：天平依然是A1的那边比较重。
                 特殊的小球在A1和B1之间。
                 随便拿一个和正常的称，就知道哪个特殊了。（第三次） */
                
                if ([self.ballDicts2[@5] intValue] == [self.ballDicts3[@9] intValue]) {
                    //A1的球跟正常的球是一樣重，有問題的是B1
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@1]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@1] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果A1那邊比較重，代表問題球在A1或B1之中，隨便拿一個跟正常的C秤重，就能找出問題球, %@", self.resultString];
                    
                }else{
                    //A1跟正常球的重量不一樣，有問題的是A1
                    NSArray *keyNameArray = [self.ballDicts2 allKeysForObject:self.ballDicts2[@5]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts2[@5] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果A1那邊比較重，代表問題球在A1或B1之中，隨便拿一個跟正常的C秤重，就能找出問題球, %@", self.resultString];
                }
            }else if (([self.ballDicts2[@5] intValue] + [self.ballDicts1[@2] intValue] + [self.ballDicts1[@3] intValue] + [self.ballDicts1[@4] intValue]) < ([self.ballDicts1[@1] intValue] + [self.ballDicts3[@9] intValue] + [self.ballDicts3[@10] intValue] + [self.ballDicts3[@11] intValue])){
                
                /*情况三：天平反过来，B1那边比较重了。
                 特殊小球在B2B3B4中间，而且知道特殊小球比较轻。 */
                
                //把B2B3称一下，就知道哪个是特殊的了。（第三次）
                if ([self.ballDicts1[@2] intValue] == [self.ballDicts1[@3] intValue]) {
                    //有問題的是剩下的球
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@4]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@4] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果B1那邊比較重，代表問題球在B2B3B4之中，而且問題球比較輕，把B2及B3互秤，就能找出問題球,此情況B2及B3重量一樣，因此問題球是B4 %@", self.resultString];
                    
                }else if ([self.ballDicts1[@2] intValue] > [self.ballDicts1[@3] intValue]){
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@3]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@3] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果B1那邊比較重，代表問題球在B2B3B4之中，而且問題球比較輕，把B2及B3互秤，就能找出問題球,此情況B2重量大於B3，代表問題球是B3 %@", self.resultString];
                    
                }else{
                    NSArray *keyNameArray = [self.ballDicts1 allKeysForObject:self.ballDicts1[@2]];
                    NSString *keyName = keyNameArray[0];
                    
                    self.resultString = [NSString stringWithFormat:@"The ball which has different weight is ball number %@, and the weight is %i", keyName, [self.ballDicts1[@2] intValue]];
                    NSLog(@"%@", self.resultString);
                    
                    self.thirdWeightLabel.text = [NSString stringWithFormat:@"上次秤重結果B1那邊比較重，代表問題球在B2B3B4之中，而且問題球比較輕，把B2及B3互秤，就能找出問題球,此情況B3重量大於B2，代表問題球是B2 %@", self.resultString];
                }
                
            }
        }
    }
}

#pragma make - Dismiss keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickNumberTextField.text = [self.pickerArray objectAtIndex:row];
    
    NSLog(@"The number you chose is %i", [self.pickNumberTextField.text intValue]);
    self.chosedNumber = [NSNumber numberWithInt:[self.pickNumberTextField.text intValue]];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        textField.text = [self.pickerArray objectAtIndex:0];
        
        NSLog(@"The number you chose is %i", [self.pickNumberTextField.text intValue]);
        self.chosedNumber = [NSNumber numberWithInt:[self.pickNumberTextField.text intValue]];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


@end
