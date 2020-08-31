//
//  TIoTBindAccountView.m
//  LinkApp
//
//  Created by ccharlesren on 2020/7/30.
//  Copyright © 2020 Winext. All rights reserved.
//

#import "TIoTBindAccountView.h"

@interface TIoTBindAccountView ()

@property (nonatomic, strong) UIView        *contentView;

@end

@implementation TIoTBindAccountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat kSpace = 15;
    CGFloat kPadding = 30;
    CGFloat kHeight = 50;
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contentView addSubview:self.phoneOrEmailTF];
    [self.phoneOrEmailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kSpace * kScreenAllHeightScale);
        make.leading.equalTo(self.contentView.mas_leading).offset(kPadding);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-kPadding);
        make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.phoneOrEmailTF.mas_bottom);
    }];
    
    [self.contentView addSubview:self.verificationButton];
    [self.verificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-kPadding);
        make.top.equalTo(line1.mas_bottom).offset(kSpace);
        make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
    }];
    
    [self.contentView addSubview:self.verificationCodeTF];
    [self.verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationButton.mas_top);
       make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
       make.trailing.equalTo(self.verificationButton.mas_leading);
       make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.verificationCodeTF.mas_bottom);
    }];
    
    [self.contentView addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
        make.top.equalTo(line2.mas_bottom).offset(kSpace);
    }];
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.contentView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.passwordTF.mas_bottom);
    }];
    
    [self.contentView addSubview:self.passwordConfirmTF];
    [self.passwordConfirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
        make.top.equalTo(line3.mas_bottom).offset(kSpace);
    }];
    
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.contentView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.passwordConfirmTF.mas_bottom);
    }];
    
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(60 * kScreenAllHeightScale);
        make.leading.equalTo(self.contentView.mas_leading).offset(kPadding);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-kPadding);
        make.height.mas_equalTo(48);
    }];
    
    if ([[TIoTCoreUserManage shared].hasPassword isEqualToString:@"1"]) {
        self.passwordTF.hidden = YES;
        self.passwordConfirmTF.hidden = YES;
        [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.mas_bottom).offset(60 * kScreenAllHeightScale);
        }];
    }else {
        self.passwordTF.hidden = NO;
        self.passwordConfirmTF.hidden = NO;
        [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line4.mas_bottom).offset(60 * kScreenAllHeightScale);
        }];
    }

}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSString *placeHoldString = @"";
    if (self.bindAccoutType == BindAccountPhoneType) {
        placeHoldString = @"请输入手机号";
        _phoneOrEmailTF.keyboardType = UIKeyboardTypeNumberPad;
    }else if (self.bindAccoutType == BindAccountEmailType) {
        placeHoldString = @"请输入邮箱";
        _phoneOrEmailTF.keyboardType = UIKeyboardTypeEmailAddress;
    }
    NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:placeHoldString attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.phoneOrEmailTF.attributedPlaceholder = attriStr;
    
}

#pragma mark - setter and getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return _contentView;
}

- (UITextField *)phoneOrEmailTF {
    if (!_phoneOrEmailTF) {
        _phoneOrEmailTF = [[UITextField alloc]init];
        _phoneOrEmailTF.textColor = [UIColor blackColor];
        _phoneOrEmailTF.font = [UIFont wcPfRegularFontOfSize:16];
        _phoneOrEmailTF.keyboardType = UIKeyboardTypeNumberPad;
        NSAttributedString *ap = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _phoneOrEmailTF.attributedPlaceholder = ap;
        _phoneOrEmailTF.clearButtonMode = UITextFieldViewModeAlways;
        [_phoneOrEmailTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneOrEmailTF;
  
}

- (UIButton *)verificationButton {
    if (!_verificationButton) {
        _verificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificationButton setTitleColor:kMainColor forState:UIControlStateNormal];
        _verificationButton.titleLabel.font = [UIFont wcPfRegularFontOfSize:16];
        [_verificationButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationButton;
}

- (UITextField *)verificationCodeTF {
    if (!_verificationCodeTF) {
        _verificationCodeTF = [[UITextField alloc]init];
        _verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _verificationCodeTF.textColor = [UIColor blackColor];
        _verificationCodeTF.font = [UIFont wcPfRegularFontOfSize:16];
        NSAttributedString *apVerification = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _verificationCodeTF.attributedPlaceholder = apVerification;
        _verificationCodeTF.clearButtonMode = UITextFieldViewModeAlways;
        [_verificationCodeTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verificationCodeTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc]init];
        _passwordTF.keyboardType = UITextFieldViewModeAlways;
        _passwordTF.textColor = [UIColor blackColor];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.font = [UIFont wcPfRegularFontOfSize:16];
        NSAttributedString *passwordAttStr = [[NSAttributedString alloc] initWithString:@"请设置您的密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _passwordTF.attributedPlaceholder = passwordAttStr;
        _passwordTF.clearButtonMode = UITextFieldViewModeAlways;
        [_passwordTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTF;
}

- (UITextField *)passwordConfirmTF {
    if (!_passwordConfirmTF) {
        _passwordConfirmTF = [[UITextField alloc]init];
        _passwordConfirmTF = [[UITextField alloc]init];
        _passwordConfirmTF.keyboardType = UITextFieldViewModeAlways;
        _passwordConfirmTF.textColor = [UIColor blackColor];
        _passwordConfirmTF.secureTextEntry = YES;
        _passwordConfirmTF.font = [UIFont wcPfRegularFontOfSize:16];
        NSAttributedString *passwordAttStr = [[NSAttributedString alloc] initWithString:@"请再次确认您的密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _passwordConfirmTF.attributedPlaceholder = passwordAttStr;
        _passwordConfirmTF.clearButtonMode = UITextFieldViewModeAlways;
        [_passwordConfirmTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordConfirmTF;;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认绑定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:kMainColorDisable];
        _confirmButton.enabled = NO;
        _confirmButton.titleLabel.font = [UIFont wcPfRegularFontOfSize:20];
        [_confirmButton addTarget:self action:@selector(confirmClickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)confirmClickButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bindAccountConfirmClickButtonWithAccountType:)]) {
        [self.delegate bindAccountConfirmClickButtonWithAccountType:self.bindAccoutType];
    }
}

-(void)changedTextField:(UITextField *)textField {

    if (self.delegate && [self.delegate respondsToSelector:@selector(bindAccountChangedTextFieldWithAccountType:)]) {
        [self.delegate bindAccountChangedTextFieldWithAccountType:self.bindAccoutType];
    }
}

- (void)sendCode:(UIButton *)button {

    if (self.delegate && [self.delegate respondsToSelector:@selector(bindAccountSendCodeWithAccountType:)]) {
        [self.delegate bindAccountSendCodeWithAccountType:self.bindAccoutType];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end