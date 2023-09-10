import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/core/application/di/injection_container.dart';
import 'package:handover/core/application/locale/locale_cubit.dart';
import 'package:handover/core/application/locale/locale_state.dart';
import 'package:handover/core/application/theme/colors.dart';
import 'package:handover/features/tracking/presentation/controllers/shipments/shipments_cubit.dart';
import 'package:handover/features/tracking/presentation/pages/shipments_page.dart';
import 'package:handover/generated/l10n.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimatedMapController _controller;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => getIt<LocaleCubit>(),
        ),
        BlocProvider(create: (_) => ShipmentsCubit(getIt()))
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            final localeCubit = context.read<LocaleCubit>();
            localeCubit.getCurrentDeviceLocale();
            return ScreenUtilInit(
                // The size of the smallest iphone ie iPhone 6's
                designSize: const Size(375, 667),
                minTextAdapt: true,
                useInheritedMediaQuery: true,
                builder: (context, child) {
                  return MaterialApp(
                    onGenerateTitle: (context) {
                      return S.of(context).appName;
                    },
                    supportedLocales: localeCubit.supportedLocales,
                    localizationsDelegates: const [
                      DefaultMaterialLocalizations.delegate,
                      ...GlobalMaterialLocalizations.delegates,
                      S.delegate
                    ],
                    locale: localeCubit.state.locale,
                    theme: ThemeData(
                        colorSchemeSeed: seedColor, useMaterial3: true),
                    home: Builder(builder: (context) {
                      return const ShipmentsPage();
                    }),
                  );
                });
          },
        );
      }),
    );
  }
}




