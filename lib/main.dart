import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template_flutter/core/di/injection_container.dart';
import 'package:template_flutter/core/notifications/notification_service.dart';
import 'package:template_flutter/core/router/app_router.dart';
import 'package:template_flutter/generated/locale_keys.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await initDependencies();

  if (getIt.isRegistered<NotificationService>()) {
    try {
      final notificationService = getIt<NotificationService>();
      await notificationService.initialize();

      final token = await notificationService.getFCMToken();
      if (token != null) {
        print('FCM Token: $token');
        print(
            'Используйте этот токен для отправки тестовых уведомлений из Firebase Console');
      }
    } catch (e) {
      print('Ошибка инициализации уведомлений: $e');
    }
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: LocaleKeys.app_name,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
