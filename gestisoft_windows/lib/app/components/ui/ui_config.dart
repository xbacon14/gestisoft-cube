import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_theme/system_theme.dart';

class UiConfig {
  static final themeData = ThemeData(
      accentColor: SystemTheme.accentColor.accent.toAccentColor(),
      scaffoldBackgroundColor: const Color(0xFFF5F2E5),
      brightness: Brightness.light,
      acrylicBackgroundColor: const Color(0xFFF5F2E5),
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
      typography: Typography.raw(
        body: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 14,
        ),
        bodyLarge: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 16,
        ),
        bodyStrong: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 16,
          letterSpacing: .7,
          fontWeight: FontWeight.bold,
        ),
        caption: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 16,
        ),
        display: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 36,
        ),
        subtitle: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 16,
        ),
        title: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.notoSans().copyWith(
          color: Colors.black.withOpacity(.8),
          fontSize: 28,
        ),
      ));
}
