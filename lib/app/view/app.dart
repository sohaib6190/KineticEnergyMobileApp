import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_repository/general_repository.dart';
import 'package:localization/localization.dart';

import '../../utils/utils.dart';
import '../app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authenticationRepository,
    required this.generalRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final GeneralRepository generalRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: generalRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppCubit(authenticationRepository)..initializeApp(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "KE",
      navigatorKey: navigatorKey,
      theme:
          context.isDarkTheme
              ? KineticEnergyTheme().darkThemeData
              : KineticEnergyTheme().lightThemeData,
      locale: context.locale,
      supportedLocales: LocalizationSetup.supportedLocales,
      localizationsDelegates: LocalizationSetup.localizationsDelegates,
      localeResolutionCallback: LocalizationSetup.localeResolutionCallback,
      builder:
          (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
              boldText: false,
            ),
            child: child!,
          ),
      // home: _buildPages(context),
    );
  }

  // Widget _buildPages(BuildContext context) {
  //   if (context.showOnboarding == false) {
  //     return const HomePage();
  //   } else {
  //     return const OnboardingPage();
  //   }
  // }
}
