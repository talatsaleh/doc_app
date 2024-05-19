import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/navigation/routes.dart';
import 'package:doc_edit_flutter/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/utils/logger.dart';

void main() async {
  setupLogger();
  ThemeDataModel().init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}

final isAuthenticatedProvider =
    Provider<bool>((ref) => ref.watch(AppState.auth).isAuthenticated);
final isAuthLoading =
    Provider<bool>((ref) => ref.watch(AppState.auth).isLoading);

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeDataModel().getTheme(),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        final isAuth = ref.watch(isAuthenticatedProvider);
        return isAuth ? routesLoggedIn : routesLoggedOut;
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
