import 'package:fluent_ui/fluent_ui.dart';

class UiConfig {
  static final themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: ButtonThemeData(
      defaultButtonStyle: ButtonStyle(
        backgroundColor: ButtonState.all(
          const Color(0xFF733924),
        ),
      ),
      filledButtonStyle: ButtonStyle(
        backgroundColor: ButtonState.all(
          const Color(0xFF733924),
        ),
      ),
      textButtonStyle: ButtonStyle(
        backgroundColor: ButtonState.all(
          const Color(0xFF733924),
        ),
      ),
    ),
    iconTheme: const IconThemeData(size: 24),
  );
}
