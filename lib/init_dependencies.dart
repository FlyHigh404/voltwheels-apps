import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:voltwheels_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:voltwheels_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_register.dart';
import 'package:voltwheels_mobile/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:voltwheels_mobile/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/usecases/get_onboarding_content.dart';
import 'package:voltwheels_mobile/features/volt-air/data/datasources/air_quality_remote_datasource.dart';
import 'package:voltwheels_mobile/features/volt-air/data/repositories/air_quality_repository_impl.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/repositories/air_quality_repository.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_forecast.dart';
import 'package:voltwheels_mobile/features/volt-rent/data/datasources/volt_rent_order_remote_datasource.dart';
import 'package:voltwheels_mobile/features/volt-rent/data/repositories/volt_rent_order_repository_impl.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/repositories/volt_rent_order_repository.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/usecases/get_user_order.dart';

import 'features/auth/domain/usecases/user_login.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");

  await initializeDateFormatting('id_ID', null);

  _initOnboarding();

  _initAuth();

  _initVoltAir();

  _initVoltRent();

  _initEasyLoading();

  _initMidtransSDK();

  serviceLocator.registerLazySingleton<Dio>(() => Dio());
}

void _initEasyLoading() {
  EasyLoading.instance
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = AppPallete.whiteColor
    ..maskColor = AppPallete.blackGrayColor.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorColor = AppPallete.primaryColor
    ..textColor = AppPallete.primaryColor
    ..textStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryColor,
    )
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..indicatorType = EasyLoadingIndicatorType.ring;
}

void _initAuth() {
  serviceLocator
    // datasource
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDatasourceImpl())
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // usecase
    ..registerFactory(
      () => UserRegister(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    );
}

void _initVoltAir() {
  serviceLocator
    // datasource
    ..registerFactory<AirQualityRemoteDatasource>(
      () => AirQualityRemoteDataSourceImpl(),
    )
    // repository
    ..registerFactory<AirQualityRepository>(
      () => AirQualityRepositoryImpl(
        serviceLocator(),
      ),
    )
    // usecases
    ..registerFactory(
      () => GetAirQuality(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetForecastAirQuality(
        serviceLocator(),
      ),
    );
}

void _initVoltRent() {
  serviceLocator
    ..registerFactory<VoltRentOrderRemoteDatasource>(
      () => VoltRentOrderRemoteDatasourceImpl(),
    )
    ..registerFactory<VoltRentOrderRepository>(
      () => VoltRentOrderRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUserOrder(
        serviceLocator(),
      ),
    );
}

void _initOnboarding() {
  serviceLocator
    // datasource
    ..registerFactory<OnboardingLocalDatasource>(
      () => OnboardingLocalDatasourceImpl(),
    )
    // repository
    ..registerFactory<OnboardingRepository>(
      () => OnboardingRepositoryImpl(
        serviceLocator(),
      ),
    )
    // usecases
    ..registerFactory(
      () => GetOnboardingContent(
        serviceLocator(),
      ),
    );
}

void _initMidtransSDK() async {
  MidtransSDK midtrans = await MidtransSDK.init(
    config: MidtransConfig(
      clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
      merchantBaseUrl: "",
      colorTheme: ColorTheme(
        colorPrimary: AppPallete.primaryColor,
        colorPrimaryDark: AppPallete.primaryColor,
        colorSecondary: AppPallete.secondaryColor,
      ),
    ),
  );

  midtrans.setUIKitCustomSetting(
    skipCustomerDetailsPages: true,
    showPaymentStatus: true,
  );

  serviceLocator.registerLazySingleton<MidtransSDK>(() => midtrans);
}
