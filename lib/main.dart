
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:my_calendar/config/routes/router.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/data/di/module.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/splash/bloc/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PrefsService.init();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await HiveLocal.init();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppState appStateCubit = AppState();

  @override
  void initState() {
    super.initState();
    appStateCubit.getThemeApp();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      appState: appStateCubit,
      child: GetMaterialApp(
        title: 'tu vi',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        theme: ThemeData(
          primaryColor: AppTheme.getInstance().primaryColor(),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppTheme.getInstance().primaryColor(),
            selectionColor: AppTheme.getInstance().primaryColor(),
            selectionHandleColor: AppTheme.getInstance().primaryColor(),
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme
                .of(context)
                .textTheme,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppTheme.getInstance().accentColor(),
          ),
        ),
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          return const Locale.fromSubtags(languageCode: 'vi');
        },
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.main,
      ),
    );
  }
}
