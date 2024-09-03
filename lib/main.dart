import 'package:dobesthabit/modules/auth/manager.dart';
import 'package:dobesthabit/product/gemini/gemini_viewmodel.dart';
import 'package:dobesthabit/product/habits/habits_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'core/base/util/color.dart';
import 'core/modules/alert/manager.dart';
import 'core/modules/memory/memory_manager.dart';
import 'core/modules/navigate/manager.dart';
import 'core/modules/provider/manager.dart';
import 'modules/habits/habits_manager.dart';
import 'product/habits/widgets/checkedHabits_provider.dart';
import 'product/splash/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MemoryManager.instance.init();
  initializeDateFormatting('tr_TR');
  runApp(
    MultiProvider(
      providers: [
        ...ProviderManager.instance.dependItems,
        ChangeNotifierProvider(create: (_) => HabitsModelManager()),
        ChangeNotifierProvider(create: (_) => CheckedHabitsProvider()),
        ChangeNotifierProvider(create: (_) => HabitsViewmodel()),
        ChangeNotifierProvider(create: (_)=> GeminiViewmodel()),
        Provider(create: (_) => AuthManager()), // AuthManager'i sağlayıcı olarak ekledik
      ],
      child: DoBestHabit(),
    ),
  );
}

class DoBestHabit extends StatelessWidget {
  DoBestHabit({super.key});
  @override
  Widget build(BuildContext context) {
    prepareSystem();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NextHabit",
      theme: Provider.of<ThemeNotifier>(context, listen: true).currentTheme,
      navigatorKey: NavigationManager.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      scaffoldMessengerKey: AlertManager.instance.scaffoldMessengerKey,
      home: const SplashView(),
    );
  }

  prepareSystem() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: ColorUtility.background);
  }
}
