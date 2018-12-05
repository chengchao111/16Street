//
//  CCDetailView.m
//  16Street
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCDetailView.h"

@implementation CCDetailView

-(instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString{
    self = [super initWithFrame:frame];
    if (self) {
        urlString = urlString !=nil?urlString:@"";
        [self addSubview:self.webView];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = YES;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.delegate = self;
//        _webView.scalesPageToFit = YES;
    }
    return _webView;
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] floatValue];

    NSLog(@"==%.2f",height);
    if (self.GetWebHeightBlock) {
        self.GetWebHeightBlock(height);
    }
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBManager dismiss];
}

-(void)dealloc{
    NSLog(@"我释放了吗");
}


@end
