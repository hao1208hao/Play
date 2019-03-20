//
//  VideoLoginVC.m
//  Play
//
//  Created by haohao on 2019/3/20.
//  Copyright © 2019 haohao. All rights reserved.
//

#import "VideoLoginVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>



#import "QDBTabBarVC.h"
#import "GuideVC.h"

@interface VideoLoginVC ()

@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;

@property(nonatomic,strong)AVPlayerViewController* avplayer;


@property(nonatomic ,strong)NSTimer *timer;
@property(nonatomic ,strong)AVAudioSession *avaudioSession;


@end

@implementation VideoLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = YES;
    /**
     *  设置其他音乐软件播放的音乐不被打断
     */
    
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    
    
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"mp4"];
    
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    if([sysVersion doubleValue]<=9.0){
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
        [_moviePlayer play];
        [_moviePlayer.view setFrame:self.view.bounds];
    
        [self.view addSubview:_moviePlayer.view];
        _moviePlayer.shouldAutoplay = YES;
        [_moviePlayer setControlStyle:MPMovieControlStyleNone];
        [_moviePlayer setFullscreen:YES];
    
        [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
     
        [self.view addSubview:_moviePlayer];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerPlaybackStateDidChangeNotification object:_moviePlayer];
     
     }else{
         _avplayer =  [[AVPlayerViewController alloc]init];
         _avplayer.player = [AVPlayer playerWithURL:url];
     
     
         _avplayer.view.frame = self.view.bounds;
         [self.view addSubview:_avplayer.view];
     
         [_avplayer.player play];
         [_avplayer setShowsPlaybackControls:YES];
         [_avplayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
     
     
         _avplayer.showsPlaybackControls = NO;
     
         //完成
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification  object:nil];
         //后台->前台
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name: UIApplicationWillEnterForegroundNotification  object:nil];
     
        }
    
    CGFloat leading = 25;
    CGFloat width = 50;
    
    UIButton* loginBtn = [self getBtn:@"登录"];
    [loginBtn setBackgroundColor:[UIColor blackColor]];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setFrame:CGRectMake(leading, SCREEN_HEIGHT-width-20, (SCREEN_WIDTH-leading*3)/2, width)];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    UIButton* regBtn = [self getBtn:@"注册"];
    [regBtn setBackgroundColor:[UIColor whiteColor]];
    [regBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [regBtn setFrame:CGRectMake((SCREEN_WIDTH-leading*3)/2+leading*2, SCREEN_HEIGHT-width-20, (SCREEN_WIDTH-leading*3)/2, width)];
    [regBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    
}

-(void)loginAction{
    NSLog(@"点击登录了");
    
    QDBTabBarVC *mainTabbar = [[QDBTabBarVC alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbar;
    
}

-(void)registerAction{
    NSLog(@"点击注册了");
    
    GuideVC* guide = [[GuideVC alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = guide;
    
}

- (void)playbackFinished:(NSNotification *)notifation {
    // 回到视频的播放起点 -> 播放
    [self.avplayer.player seekToTime:kCMTimeZero];
    [self.avplayer.player play];
}


-(void)playbackStateChanged{
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;
            
        default:
            NSLog(@"无法辨识的状态");
            break;
    }
}



//白色状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//获取按钮
-(UIButton*)getBtn:(NSString*)title{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    btn.layer.cornerRadius = 6.0f;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.alpha = 0.4;
    return btn;
}


@end
