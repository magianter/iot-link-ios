//
//  RegistVC.m
//  QCFrameworkDemo
//
//  Created by Wp on 2020/3/5.
//  Copyright © 2020 Reo. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
@property (weak, nonatomic) IBOutlet UITextField *pnT;
@property (weak, nonatomic) IBOutlet UITextField *passwordT;
@property (weak, nonatomic) IBOutlet UITextField *codeT;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.doneBtn setTitle:self.title forState:UIControlStateNormal];
    
}


- (IBAction)getOneTimeCode:(id)sender {
    if (!self.pnT.hasText) {
        return;
    }
    
    switch (self.seg.selectedSegmentIndex) {
        case 0://手机号
        {
            if ([self.title isEqualToString:NSLocalizedString(@"register", @"注册")]) {
                [[TIoTCoreAccountSet shared] sendVerificationCodeWithCountryCode:@"86" phoneNumber:self.pnT.text success:^(id  _Nonnull responseObject) {
                    
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
            else
            {
                [[TIoTCoreAccountSet shared] sendCodeForResetWithCountryCode:@"86" phoneNumber:self.pnT.text success:^(id  _Nonnull responseObject) {
                    
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
        }
            break;
        case 1://邮箱
        {
            if ([self.title isEqualToString:NSLocalizedString(@"register", @"注册")]) {
                [[TIoTCoreAccountSet shared] sendVerificationCodeWithEmail:self.pnT.text success:^(id  _Nonnull responseObject) {
                    
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
            else
            {
                [[TIoTCoreAccountSet shared] sendCodeForResetWithEmail:self.pnT.text success:^(id  _Nonnull responseObject) {
                    
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
        }
            break;
        default:
            break;
    }
    
}

- (IBAction)regist:(id)sender {
    
    if (!(self.pnT.hasText && self.codeT.hasText && self.passwordT.hasText)) {
        
        return;
    }
    
    switch (self.seg.selectedSegmentIndex) {
        case 0://手机号
        {
            if ([self.title isEqualToString:NSLocalizedString(@"register", @"注册")]){
                [[TIoTCoreAccountSet shared] createPhoneUserWithCountryCode:@"86" phoneNumber:self.pnT.text verificationCode:self.codeT.text password:self.passwordT.text success:^(id  _Nonnull responseObject) {
                    [MBProgressHUD showSuccess:NSLocalizedString(@"region_success", @"注册成功")];
                    [self.navigationController popViewControllerAnimated:YES];
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
            else
            {
                [[TIoTCoreAccountSet shared] ResetPasswordWithCountryCode:@"86" phoneNumber:self.pnT.text verificationCode:self.codeT.text password:self.passwordT.text success:^(id  _Nonnull responseObject) {
                    
                    [MBProgressHUD showSuccess:NSLocalizedString(@"reset_password_success", @"重置密码成功")];
                    [self.navigationController popViewControllerAnimated:YES];
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
        }
            break;
        case 1:
        {
            if ([self.title isEqualToString:NSLocalizedString(@"register", @"注册")]){
                [[TIoTCoreAccountSet shared] createEmailUserWithEmail:self.pnT.text verificationCode:self.codeT.text password:self.passwordT.text success:^(id  _Nonnull responseObject) {
                    [MBProgressHUD showSuccess:NSLocalizedString(@"region_success", @"注册成功")];
                    [self.navigationController popViewControllerAnimated:YES];
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
            else
            {
                [[TIoTCoreAccountSet shared] resetPasswordByEmail:self.pnT.text verificationCode:self.codeT.text password:self.passwordT.text success:^(id  _Nonnull responseObject) {
                    
                    [MBProgressHUD showSuccess:NSLocalizedString(@"reset_password_success", @"重置密码成功")];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
                    
                }];
            }
        }
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
