//
//  ViewController.h
//  OCInteractionJSDemo
//
//  Created by LYPC on 2017/9/13.
//  Copyright © 2017年 cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
// AndroidWebView对象调用的JavaScript方法，必须声明！！！
- (int)indexOfMap;

@end

@interface ViewController : UIViewController <UIWebViewDelegate,JSObjcDelegate>

@property (nonatomic, strong) JSContext *context;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

