//
//  ViewController.m
//  gpuimage-demo
//
//  Created by zhangpeng on 6/1/17.
//  Copyright © 2017 zhangpeng. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImageFramework.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()

@property(strong, nonatomic) GPUImageStillCamera *mCamera;
@property(strong, nonatomic) GPUImageFilter *mFilter;
@property(strong, nonatomic) GPUImageView *mGPUImgView;
@property(strong, nonatomic) NSArray *mAllFilters;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAllFilters];
    // Do any additional setup after loading the view, typically from a nib.
    //步骤--------------1
    //第一个参数表示相片的尺寸，第二个参数表示前、后摄像头
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    //竖屏方向
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    //步骤--------------2
    //这个滤镜你可以换其它的，官方给出了不少滤镜
    Class filterClass = NSClassFromString(_mAllFilters[1]);
    _mFilter = [[filterClass alloc] init];
    //步骤--------------3
    _mGPUImgView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    //步骤--------------4
    [_mCamera addTarget:_mFilter];
    [_mFilter addTarget:_mGPUImgView];
    //步骤--------------5
    [self.view addSubview:_mGPUImgView];
    //步骤--------------6
    [_mCamera startCameraCapture];
    
    //添加一个按钮触发拍照
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-80)*0.5, self.view.bounds.size.height-60, 80, 40)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"capture" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
}

-(void)takePhoto{
    //步骤--------------7
    [_mCamera capturePhotoAsJPEGProcessedUpToFilter:_mFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
        //将相片保存到手机相册（iOS8及以上，该方法过期但是可以用，不想用请搜索PhotoKit）
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library writeImageDataToSavedPhotosAlbum:processedJPEG metadata:_mCamera.currentCaptureMetadata completionBlock:^(NSURL *assetURL, NSError *error2)
         {
             if (error2) {
                 NSLog(@"ERROR: the image failed to be written");
             }
             else {
                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             }
             
         }];
    }];
}

-(void)loadAllFilters{
    _mAllFilters = [NSArray arrayWithObjects:@"GPUImage3x3ConvolutionFilter",
                    @"GPUImage3x3TextureSamplingFilter",
                    @"GPUImageAdaptiveThresholdFilter",
                    @"GPUImageAddBlendFilter",
                    @"GPUImageAlphaBlendFilter",
                    @"GPUImageAmatorkaFilter",
                    @"GPUImageAverageLuminanceThresholdFilter",
                    @"GPUImageBilateralFilter",
                    @"GPUImageBoxBlurFilter",
                    @"GPUImageBrightnessFilter",
                    @"GPUImageBulgeDistortionFilter",
                    @"GPUImageCGAColorspaceFilter",
                    @"GPUImageCannyEdgeDetectionFilter",
                    @"GPUImageChromaKeyBlendFilter",
                    @"GPUImageChromaKeyFilter",
                    @"GPUImageClosingFilter",
                    @"GPUImageColorBlendFilter",
                    @"GPUImageColorBurnBlendFilter",
                    @"GPUImageColorDodgeBlendFilter",
                    @"GPUImageColorInvertFilter",
                    @"GPUImageColorMatrixFilter",
                    @"GPUImageColorPackingFilter",
                    @"GPUImageContrastFilter",
                    @"GPUImageCropFilter",
                    @"GPUImageCrosshatchFilter",
                    @"GPUImageDarkenBlendFilter",
                    @"GPUImageDifferenceBlendFilter",
                    @"GPUImageDilationFilter",
                    @"GPUImageDirectionalNonMaximumSuppressionFilter",
                    @"GPUImageDirectionalSobelEdgeDetectionFilter",
                    @"GPUImageDissolveBlendFilter",
                    @"GPUImageDivideBlendFilter",
                    @"GPUImageEmbossFilter",
                    @"GPUImageErosionFilter",
                    @"GPUImageExclusionBlendFilter",
                    @"GPUImageExposureFilter",
                    @"GPUImageFASTCornerDetectionFilter",
                    @"GPUImageFalseColorFilter",
                    @"GPUImageFilter",
                    @"GPUImageGammaFilter",
                    @"GPUImageGaussianBlurFilter",
                    @"GPUImageGaussianBlurPositionFilter",
                    @"GPUImageGaussianSelectiveBlurFilter",
                    @"GPUImageGlassSphereFilter",
                    @"GPUImageGrayscaleFilter",
                    @"GPUImageHSBFilter",
                    @"GPUImageHalftoneFilter",
                    @"GPUImageHardLightBlendFilter",
                    @"GPUImageHarrisCornerDetectionFilter",
                    @"GPUImageHazeFilter",
                    @"GPUImageHighPassFilter",
                    @"GPUImageHighlightShadowFilter",
                    @"GPUImageHistogramEqualizationFilter",
                    @"GPUImageHistogramFilter",
                    @"GPUImageHueBlendFilter",
                    @"GPUImageHueFilter",
                    @"GPUImageJFAVoronoiFilter",
                    @"GPUImageKuwaharaFilter",
                    @"GPUImageKuwaharaRadius3Filter",
                    @"GPUImageLanczosResamplingFilter",
                    @"GPUImageLaplacianFilter",
                    @"GPUImageLevelsFilter",
                    @"GPUImageLightenBlendFilter",
                    @"GPUImageLinearBurnBlendFilter",
                    @"GPUImageLocalBinaryPatternFilter",
                    @"GPUImageLookupFilter",
                    @"GPUImageLowPassFilter",
                    @"GPUImageLuminanceRangeFilter",
                    @"GPUImageLuminanceThresholdFilter",
                    @"GPUImageLuminosityBlendFilter",
                    @"GPUImageMaskFilter",
                    @"GPUImageMedianFilter",
                    @"GPUImageMissEtikateFilter",
                    @"GPUImageMonochromeFilter",
                    @"GPUImageMosaicFilter",
                    @"GPUImageMotionBlurFilter",
                    @"GPUImageMultiplyBlendFilter",
                    @"GPUImageNobleCornerDetectionFilter",
                    @"GPUImageNonMaximumSuppressionFilter",
                    @"GPUImageNormalBlendFilter",
                    @"GPUImageOpacityFilter",
                    @"GPUImageOpeningFilter",
                    @"GPUImageOverlayBlendFilter",
                    @"GPUImageParallelCoordinateLineTransformFilter",
                    @"GPUImagePerlinNoiseFilter",
                    @"GPUImagePinchDistortionFilter",
                    @"GPUImagePixellateFilter",
                    @"GPUImagePixellatePositionFilter",
                    @"GPUImagePoissonBlendFilter",
                    @"GPUImagePolarPixellateFilter",
                    @"GPUImagePolkaDotFilter",
                    @"GPUImagePosterizeFilter",
                    @"GPUImagePrewittEdgeDetectionFilter",
                    @"GPUImageRGBClosingFilter",
                    @"GPUImageRGBDilationFilter",
                    @"GPUImageRGBErosionFilter",
                    @"GPUImageRGBFilter",
                    @"GPUImageRGBOpeningFilter",
                    @"GPUImageSaturationBlendFilter",
                    @"GPUImageSaturationFilter",
                    @"GPUImageScreenBlendFilter",
                    @"GPUImageSepiaFilter",
                    @"GPUImageSharpenFilter",
                    @"GPUImageShiTomasiFeatureDetectionFilter",
                    @"GPUImageSingleComponentGaussianBlurFilter",
                    @"GPUImageSketchFilter",
                    @"GPUImageSmoothToonFilter",
                    @"GPUImageSobelEdgeDetectionFilter",
                    @"GPUImageSoftEleganceFilter",
                    @"GPUImageSoftLightBlendFilter",
                    @"GPUImageSourceOverBlendFilter",
                    @"GPUImageSphereRefractionFilter",
                    @"GPUImageStretchDistortionFilter",
                    @"GPUImageSubtractBlendFilter",
                    @"GPUImageSwirlFilter",
                    @"GPUImageThreeInputFilter",
                    @"GPUImageThresholdEdgeDetectionFilter",
                    @"GPUImageThresholdSketchFilter",
                    @"GPUImageThresholdedNonMaximumSuppressionFilter",
                    @"GPUImageTiltShiftFilter",
                    @"GPUImageToneCurveFilter",
                    @"GPUImageToonFilter",
                    @"GPUImageTransformFilter",
                    @"GPUImageTwoInputCrossTextureSamplingFilter",
                    @"GPUImageTwoInputFilter",
                    @"GPUImageTwoPassFilter",
                    @"GPUImageTwoPassTextureSamplingFilter",
                    @"GPUImageUnsharpMaskFilter",
                    @"GPUImageVignetteFilter",
                    @"GPUImageVoronoiConsumerFilter",
                    @"GPUImageWeakPixelInclusionFilter",
                    @"GPUImageWhiteBalanceFilter",
                    @"GPUImageXYDerivativeFilter",
                    @"GPUImageZoomBlurFilter",
                    @"GPUImageiOSBlurFilter",
                    nil];
}
@end
