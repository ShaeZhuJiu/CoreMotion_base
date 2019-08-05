//
//  ViewController.m
//  CoreMotion框架
//
//  Created by 谢鑫 on 2019/8/5.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
@property (nonatomic,strong) CMMotionManager *motionMgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)start:(UIButton *)sender {
   // [self startAccPush];
   //[self  startAccPull];
   //[self startGyroPush];
   // [self startGyroPull];
   // [self startMagnetoPush];
   // [self startMagnetoPull];
   // [self  rotationRateDeviceMotionPull];
    [self  startRotationRateDeviceMotionPush];
}

- (IBAction)stop:(UIButton *)sender {
   // [self stopAccPush];
   // [self stopGyroPush];
    //[self stopMagetoPush];
    [self stopRotationRateDeviceMotionPush];
}
/* 1.1      加速计的裸数据Push模式          */
- (CMMotionManager *)motionMgr{
    if (_motionMgr==nil) {
        _motionMgr=[[CMMotionManager alloc]init];
    }
    return _motionMgr;
}
-(void)startAccPush{
    //设置采样间隔
    self.motionMgr.accelerometerUpdateInterval=1.0;
    //开始采样
    [self.motionMgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        NSLog(@"x:%f,y:%f,z:%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
    }];
}
-(void)stopAccPush{
    [self.motionMgr stopAccelerometerUpdates];
}

/* 1.2       加速计的裸数据Pull模式              */
-(void)startAccPull{
    //pull模式--加速计Accelerometer
    if (self.motionMgr.isAccelerometerAvailable) {
        //  启动采样
        [self.motionMgr startAccelerometerUpdates];
    }else{
        NSLog(@"加速计Accelerometer不可用");
    }
    
    //获取加速计当前状态
    CMAcceleration acceleration=self.motionMgr.accelerometerData.acceleration;
    NSLog(@"accelerometer current state：x:%f, y:%f, z:%f",acceleration.x,acceleration.y,acceleration.z);
}

/*2.1         陀螺仪的裸数据Push模式              */
-(void)startGyroPush{
    //设置采样间隔
    self.motionMgr.gyroUpdateInterval = 1.0;
    //开始采样
    [self.motionMgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        NSLog(@"x:%f, y:%f, z:%f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z);
    }];
}
-(void)stopGyroPush{
     [self.motionMgr stopGyroUpdates];
}
/*2.2         陀螺仪的裸数据Pull模式              */
-(void)startGyroPull{
    //Pull模式--陀螺仪
    if (self.motionMgr.isGyroAvailable) {
        [self.motionMgr startGyroUpdates];
    }else {
        NSLog(@"陀螺仪GyroScope不可用");
    }
    //获取陀螺仪当前状态
    CMRotationRate rationRate = self.motionMgr.gyroData.rotationRate;
    NSLog(@"gyroscope current state: x:%f, y:%f, z:%f", rationRate.x, rationRate.y, rationRate.z);
}

/*3.1         磁力计的裸数据Push模式              */
-(void)startMagnetoPush{
    //设置采样间隔
    self.motionMgr.magnetometerUpdateInterval = 1.0;
    //开始采样
    [self.motionMgr startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
        NSLog(@"x:%f, y:%f, z:%f", magnetometerData.magneticField.x, magnetometerData.magneticField.y, magnetometerData.magneticField.z);
    }];
}
-(void)stopMagetoPush{
    [self.motionMgr stopMagnetometerUpdates];
}
/*3.2         磁力计的裸数据Pull模式              */
-(void)startMagnetoPull{
    //Pull模式--磁力计
    if (self.motionMgr.isMagnetometerAvailable) {
        [self.motionMgr startMagnetometerUpdates];
    }else {
        NSLog(@"磁力计Magnetometer不可用");
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取磁力计当前状态
    CMMagneticField magneticField = self.motionMgr.magnetometerData.magneticField;
    NSLog(@"magnetometer current state: x:%f, y:%f, z:%f", magneticField.x,magneticField.y,magneticField.z);
}
/*4.1        deviceMotion 陀螺仪的Push模式              */
-(void)startRotationRateDeviceMotionPush{
    //设置采样间隔
    self.motionMgr.deviceMotionUpdateInterval = 1.0;
    //开始采样
    [self.motionMgr startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        NSLog(@"x:%f, y:%f, z:%f", motion.rotationRate.x, motion.rotationRate.y, motion.rotationRate.z);
    }];
}
-(void)stopRotationRateDeviceMotionPush{
    [self.motionMgr stopDeviceMotionUpdates];
}
/*4.2        deviceMotion 陀螺仪的Pull模式              */
-(void)rotationRateDeviceMotionPull{
    //Pull模式--device motion
    if (self.motionMgr.isDeviceMotionAvailable) {
        [self.motionMgr startDeviceMotionUpdates];
    }else {
        NSLog(@"device motion不可用");
    }
    //通过deviceMotion获取陀螺仪当前状态
    CMDeviceMotion * deviceMotion = self.motionMgr.deviceMotion;
    NSLog(@"device motion rationRate: x:%f, y:%f, z:%f",deviceMotion.rotationRate.x, deviceMotion.rotationRate.y,deviceMotion.rotationRate.z);
}

@end
