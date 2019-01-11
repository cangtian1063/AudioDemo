//
//  ViewController.m
//  AudioDemo
//
//  Created by TianMeng on 2019/1/10.
//  Copyright © 2019年 TianMeng. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+TMKit.h"
#import "UIButton+TMChain.h"


@interface ViewController ()<AVAudioPlayerDelegate>
#pragma mark --- 音频采集
@property (nonatomic, strong) AVAudioRecorder* audioRecorder;
@property (nonatomic, strong) AVAudioSession* audioSession;
@property (nonatomic, strong) UIButton* audioButton;
//音频播放
@property (nonatomic, strong) AVAudioPlayer* audioPlayer;
@property (nonatomic, strong) NSString* currentFilePath;


#pragma mark ---- 做混响效果
@property (nonatomic, strong) AVAudioEngine* engine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioButton = [UIButton buttonWithType:UIButtonTypeCustom].TM_TitleColorNormal([UIColor blackColor])
    .TM_TitleNormal(@"开始录音").TM_TitleSelected(@"停止录音");
    self.audioButton.frame = CGRectMake(0, 0, 100, 50);
    self.audioButton.center = self.view.center;
    [self.view addSubview:self.audioButton];
    [self.audioButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    /*
    @weakify(self);
    [[self.audioButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //开始录音  停止录音
        self.audioButton.selected = !self.audioButton.selected;
        if (self.audioButton.selected) {
            //开始录音
            if (self.audioRecorder == nil) {
                [self prepareRecoder];
                
            }
        }else{
            //停止录音
            [self.audioRecorder stop];
            self.audioRecorder = nil;
            
            //播放
            
            [self audioToPlay:[NSURL fileURLWithPath:self.currentFilePath]];
            [self addAudioEngine];
            //获取音频列表
            NSLog(@"音频列表%@",[self getAllAudios]);
        }
    }];
     */
    
    
    //创建音频会话
    self.audioSession = [AVAudioSession sharedInstance];
    /*
     Category enum                                           是否打断其他不支持混音APP         是否会被静音键或锁屏键静音
     AVAudioSessionCategoryAmbient          只支持播放                      否                            是
     AVAudioSessionCategoryAudioProcessing  不支持播放，不支持录制             是                           否
     AVAudioSessionCategoryMultiRoute       支持播放，支持录制                是                            否
     AVAudioSessionCategoryPlayAndRecord    支持播放，支持录制         默认YES，可以重写为NO                  否
     AVAudioSessionCategoryPlayback         只支持播放               默认YES，可以重写为NO                   否
     AVAudioSessionCategoryRecord           只支持录制                       是                   否（锁屏下仍可录制）
     AVAudioSessionCategorySoloAmbient      只支持播放                       是                           是
     */
    NSError* error;
    [self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"--%@",error);
        return;
    }
    [self.audioSession setActive:YES error:nil];
    
}

//播放音频
- (void)audioToPlay:(NSURL*)url {
    if (self.audioPlayer != nil) {
        self.audioPlayer = nil;
        self.audioPlayer.delegate = nil;
    }
    NSError* error;
    //初始化
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error) {
        NSLog(@"--%@--",error);
        return;
    }
    self.audioPlayer.delegate = self;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
}


//保存录音完成路径
-(NSString*)saveAudioPath{
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //加时间戳保证音频不被覆盖
    NSString* audioName = [[NSString TM_time_getCurrentDateTransformTimeStampYMDHMS] stringByAppendingString:@".pcm"];
    
    NSString* currentFilePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",audioName]];
    self.currentFilePath = currentFilePath;
    return currentFilePath;
}

//创建录音对象,开始录音
- (void)prepareRecoder {
    NSError* error;
    /*
     AVFormatIDKey:  设置录音格式
     AVSampleRateKey: 设置录音采样率(Hz) 8000/44100/96000（影响音频的质量）
     AVNumberOfChannelsKey: 设置通道
     AVLinearPCMBitDepthKey:  设置采样点位数,分别 8、16、24、32
     AVLinearPCMIsFloatKey:   是否使用浮点数采样
     AVEncoderAudioQualityKey:  设置录音质量
     */
    
    self.audioRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:[self saveAudioPath]] settings:@{AVSampleRateKey:@8000,AVEncoderAudioQualityKey:@(AVAudioQualityMedium),AVFormatIDKey:@(kAudioFormatLinearPCM)} error:&error];
    if (!error) {
        //加载到缓冲区
        [self.audioRecorder prepareToRecord];
        //开始录音
        [self.audioRecorder record];
    }
}

//获取所有的音频数据
- (NSMutableArray*)getAllAudios {
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray* filePaths = [manager subpathsAtPath:path];
    NSMutableArray* audiosArray = [NSMutableArray array];
    for (NSString* item in filePaths) {
        if ([item.pathExtension isEqualToString:@"pcm"]) {
            [audiosArray addObject:item];
        }
    }
    return audiosArray;
}


#pragma mark --  播放音频的代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    //播放完成
    self.audioButton.userInteractionEnabled = YES;
    NSLog(@"播放完成----");
    //如果添加了音效，播放完要把音效移除
    [self removeAudioEngine];
    
    
}

- (void)clickBtn:(UIButton*)button {
    self.audioButton.selected = !self.audioButton.selected;
    if (self.audioButton.selected) {
        //开始录音
        if (self.audioRecorder == nil) {
            [self prepareRecoder];
        }
    }else{
        //停止录音
        [self.audioRecorder stop];
        self.audioRecorder = nil;
        self.audioButton.userInteractionEnabled = NO;
        //自动播放录音
        [self audioToPlay:[NSURL fileURLWithPath:self.currentFilePath]];
        [self addAudioEngine];
        //获取音频列表
        NSLog(@"音频列表%@",[self getAllAudios]);
    }
}

//添加音效
- (void)addAudioEngine {
    self.engine = [[AVAudioEngine alloc]init];
    AVAudioInputNode* input = self.engine.inputNode;
    AVAudioOutputNode* output = self.engine.outputNode;
    //添加失真效果
    AVAudioUnitDistortion* distortion = [[AVAudioUnitDistortion alloc]init];
    [distortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechCosmicInterference];
    distortion.preGain = 10.0f;
    distortion.wetDryMix = 100.0f;
    //将distortion附着到 音频引擎
    [self.engine attachNode:distortion];
    
    //添加混响效果
    AVAudioUnitReverb* reverb = [[AVAudioUnitReverb alloc]init];
    [reverb loadFactoryPreset:AVAudioUnitReverbPresetLargeRoom];
    reverb.wetDryMix = 50.f;
    [self.engine attachNode:reverb];
    
    
    //    AVAudioUnitReverb
    
    //连接节点
    [self.engine connect:input to:distortion format:[input inputFormatForBus:0]];
    [self.engine connect:distortion to:reverb format:[input inputFormatForBus:0]];
    [self.engine connect:reverb to:output format:[input inputFormatForBus:0]];
    
    //开启引擎
    [self.engine startAndReturnError:nil];
}

//移除音效
- (void)removeAudioEngine {
    if (self.engine.isRunning) {
        [self.engine stop];
    }
}



@end
