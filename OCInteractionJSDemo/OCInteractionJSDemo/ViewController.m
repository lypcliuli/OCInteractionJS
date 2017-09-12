//
//  ViewController.m
//  OCInteractionJSDemo
//
//  Created by LYPC on 2017/9/13.
//  Copyright © 2017年 cattsoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    // 加载本地的html测试js
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testJsFunc" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:baseURL];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 获取context对象
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //将AndroidWebView对象指向自身 js里面写window.AndroidWebView.indexOfMap() 就会调用原生里的indexOfMap方法
    self.context[@"AndroidWebView"] = self;
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    // 获取到点击js按钮的事件
        self.context[@"clickAction0"] = ^(){
            NSLog(@"获取到点击js按钮的事件");
        };
    // oc调用js函数 并传参 js无返回值
        NSString *jsAction = @"clickAction1(555)";
        [self.context evaluateScript:jsAction];
    
    // oc调用js函数 并传参 接收js返回值
        NSString *str1 = [webView stringByEvaluatingJavaScriptFromString:@"clickAction2(666);"];
        NSLog(@"js函数给我的返回值：%@", str1);
}

/**
 待js调用
 */
- (int)indexOfMap {
    NSLog(@"我被js调用了");
    return 110;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
