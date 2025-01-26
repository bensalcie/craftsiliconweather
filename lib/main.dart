import 'package:craftsiliconweather/app.dart';
import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/di/injection.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/blocs_root.dart';
import 'package:craftsiliconweather/core/common/utils/app_global_observer.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = kDebugMode;
  if (kDebugMode) {
    await dotenv.load(fileName: ".dev.env");
  } else {
    await dotenv.load(fileName: ".env");
  }

  await configureDependencies();

  if (kDebugMode) {
    Bloc.observer = AppGlobalBlocObserver();
  }

  /// Please add all BloCs ref to [BlocsRoot]
  runApp(BlocsRoot());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_title,
      theme: AppTheme.main(Brightness.light),
      darkTheme: AppTheme.main(Brightness.dark),
      themeMode:
          ThemeMode.system, // Switches automatically based on system setting
      home: App(),
    );
  }
}
