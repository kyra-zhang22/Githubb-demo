//
//  LoginViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/8.
//

#import "ZMXLoginViewController.h"
#import "ZMXHomePageViewController.h"

@interface ZMXLoginViewController () <UITextViewDelegate>

@end

@implementation ZMXLoginViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Test";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"github_icon.png"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"sign in" forState:UIControlStateNormal];
    //rounded corners
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    button.backgroundColor = UIColor.blackColor;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view).mas_offset(16);
        make.right.mas_equalTo(self.view).mas_offset(-16);
        make.height.mas_equalTo(30);
    }];
    [button addTarget:self action:@selector(didLoginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *a = @{
        @"text" : @"Terms of use",
        @"color" : [UIColor blueColor],
        @"link" : @"https://www.google.com"
    };
    NSDictionary *b = @{
        @"text": @"and Privacy policy",
        @"color" : [UIColor blueColor],
        @"link" : @"https://www.baidu.com"
    };
    NSArray *array = @[a,b];
    
    // 构造字符串
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"By signing in, you agree to "];
                   
    for (NSDictionary *dict in array) {
        [string appendString: dict[@"text"]];
    }
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, string.length)];
    
    for (NSUInteger i = 0; i < array.count; i++) {
        NSDictionary *dict = array[i];
        NSRange range = [string rangeOfString:dict[@"text"]];
        [attr addAttribute:NSLinkAttributeName
                     value:dict[@"link"]
                     range:range];
        [attr addAttribute:NSForegroundColorAttributeName value:dict[@"color"] range:range];
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:3];
    [attr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 80, 200, 0)];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:13];
    
    textView.linkTextAttributes = @{};
    textView.attributedText = attr;
    [textView sizeToFit];
    textView.delegate = self;
    [self.view addSubview:textView];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(nonnull NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:URL options:@{} completionHandler:nil];

    return NO;
}

#pragma mark - Action

- (void)didLoginButtonTapped
{
    ZMXHomePageViewController *homeVC = [ZMXHomePageViewController new];
    [self.navigationController pushViewController:homeVC animated:YES];
}





@end
