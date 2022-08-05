import 'package:fluent_ui/fluent_ui.dart';
import 'package:gestisoft_windows/app/components/helpers/enviroments.dart';

class ApplicationStarterConfig {
  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _loadEnvs();
  }

  Future<void> _loadEnvs() => Enviroments.loadEnvs();
}
