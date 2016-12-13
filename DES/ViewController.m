//
//  ViewController.m
//  DES
//
//  Created by LeadFair on 16/11/11.
//  Copyright © 2016年 LeadFair. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCryptor.h>

@interface ViewController ()

@end

@implementation ViewController

//const Byte iv[] = {1,2,3,4,5,6,7,8};


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *str = [self encryptUseDES:@"11111111" key1:@"12345678" key2:@"12345678"];
    NSLog(@"加密结果：%@",str);


}

- (NSString *) encryptUseDES:(NSString *)decoded key1:(NSString *)key1 key2:(NSString*)key2{

    NSData *inputData = [decoded dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key1 dataUsingEncoding:NSUTF8StringEncoding];
    NSData *key2Data = [key2 dataUsingEncoding:NSUTF8StringEncoding];
    size_t outLength;
    
    NSMutableData *outputData = [NSMutableData dataWithLength:(inputData.length  +  kCCBlockSize3DES)];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt, // operation
                                     kCCAlgorithmDES, // Algorithm
                                     kCCOptionPKCS7Padding, // options
                                     keyData.bytes, // key
                                     keyData.length, // keylength
                                     nil,// iv
                                     inputData.bytes, // dataIn
                                     inputData.length, // dataInLength,
                                     outputData.mutableBytes, // dataOut
                                     outputData.length, // dataOutAvailable
                                     &outLength); // dataOutMoved}
    
    NSMutableString *dataString;
    if (result == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:outputData.mutableBytes length:(NSUInteger)outLength];
//        NSLog(@"data = %@,result = %d",data,result);
        NSMutableData *outputData1 = [NSMutableData dataWithLength:(data.length  +  kCCBlockSize3DES)];
        CCCryptorStatus result1 = CCCrypt(kCCEncrypt, // operation
                                         kCCAlgorithmDES, // Algorithm
                                         kCCOptionPKCS7Padding, // options
                                         key2Data.bytes, // key
                                         key2Data.length, // keylength
                                         nil,// iv
                                         data.bytes, // dataIn
                                         data.length, // dataInLength,
                                         outputData1.mutableBytes, // dataOut
                                         outputData1.length, // dataOutAvailable
                                         &outLength); // dataOutMoved}
        if (result1 == kCCSuccess){
            
            NSData *data1 = [NSData dataWithBytes:outputData1.mutableBytes length:(NSUInteger)outLength];
            const unsigned char *rePtr = [data1 bytes];
            dataString = [NSMutableString stringWithCapacity:(data.length)];

            for (NSUInteger i = 0; i<data1.length; i++,rePtr++) {
                
                [dataString appendFormat:@"%02lX",(long)*rePtr];
                NSLog(@"%02lx",(long)*rePtr);
                NSLog(@"%@",dataString);
            }
//            const unsigned char *rePtr1 = [data1 bytes];
//            for (int i = 0; i <data1.length; i ++) {
//                NSLog(@"reptr:%d",rePtr1[i]&0XFF);
//            }
//            NSLog(@"data = %@",data1);
        }
    }
//    NSLog(@"dataString = %@",dataString);
    //36D4CB6F4F544D7D
        
    return dataString;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
