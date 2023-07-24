import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vici_technical_test/common/constants/router_constants.dart';

import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/discover/presentation/cubit/new_discover_cubit.dart';
import 'features/home/home_screen.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'route/router.dart';
import 'injection_container.dart' as di;
import 'utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  // await DBProvider.instance.init();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: _getProviders(),
        child: ScreenUtilInit(
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              initialRoute: RouteName.loginRoute,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.white,
                useMaterial3: true,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: const HomeScreen(),
            );
          },
        ));
  }

  List<BlocProvider> _getProviders() => [
        BlocProvider<LoginBloc>(
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => di.sl<RegisterBloc>(),
        ),
        BlocProvider<NewDiscoverCubit>(
          create: (context) => di.sl<NewDiscoverCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => di.sl<CartCubit>(),
        ),
      ];
}
