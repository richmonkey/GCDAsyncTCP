/*                                                                            
  Copyright (c) 2014-2015, GoBelieve     
    All rights reserved.		    				     			
 
  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree. An additional grant
  of patent rights can be found in the PATENTS file in the same directory.
*/

#import "MainViewController.h"
#import "AsyncTCP.h"

@interface MainViewController ()
@property(nonatomic, weak) UIButton *chatButton;

@property(nonatomic) AsyncTCP *tcp;
@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgImageView];
    
    float startHeight = [[UIScreen mainScreen] bounds].size.height >= 568.0 ? 180 : 100;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, startHeight, self.view.frame.size.width - 30, 48);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_blue"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(actionChat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.chatButton = btn;
}


- (void)actionChat {
    self.chatButton.userInteractionEnabled = NO;
    
    NSMutableData *result = [NSMutableData data];

#ifdef TEST_SSL
    int port = 443;
#else
    int port = 80;
#endif
    AsyncTCP *tcp = [[AsyncTCP alloc] init];
    [tcp connect:@"taobao.com" port:port cb:^(AsyncTCP *tcp, int err) {
        if (err != 0) {
            NSLog(@"connect err:%d", err);
            return;
        }
        
        [tcp startRead:^(AsyncTCP *tcp, NSData *data, int err) {
            if (err) {
                NSLog(@"read err:%d", err);
                [tcp close];
                self.chatButton.userInteractionEnabled = YES;
                NSString *t = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
                NSLog(@"response:%@", t);
                return;
            } else if (data.length == 0) {
                NSLog(@"read eof");
                [tcp close];
                self.chatButton.userInteractionEnabled = YES;
                NSString *t = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
                NSLog(@"response:%@", t);
                return;
            } else {
                [result appendData:data];
            }
        }];

        NSString *req = @"GET / HTTP/1.1\r\nHost: www.taobao.com\r\nConnection: close\r\n\r\n";
        [tcp write:[req dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    self.tcp = tcp;
}


@end
