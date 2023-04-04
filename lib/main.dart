import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/presentaion/landing_page.dart';
import 'package:scrumit/core/presentaion/redirecting_screen.dart';
import 'package:scrumit/core/presentaion/splash_page.dart';
import 'injection_container.dart' as di;
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // di.init();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scrumit',
      // This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
      // FlexColorScheme is not in use!
      // Here is a default Material 2 starting point theme setup for you.
      //

      theme: FlexThemeData.light(
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.light,
        //   primary: Color(0xff4496e0),
        //   onPrimary: Color(0xffffffff),
        //   primaryContainer: Color(0xffb4e6ff),
        //   onPrimaryContainer: Color(0xff0f1314),
        //   secondary: Color(0xff202b6d),
        //   onSecondary: Color(0xffffffff),
        //   secondaryContainer: Color(0xff99ccf9),
        //   onSecondaryContainer: Color(0xff0d1114),
        //   tertiary: Color(0xff514239),
        //   onTertiary: Color(0xffffffff),
        //   tertiaryContainer: Color(0xffbaa99d),
        //   onTertiaryContainer: Color(0xff100e0d),
        //   error: Color(0xffb00020),
        //   onError: Color(0xffffffff),
        //   errorContainer: Color(0xfffcd8df),
        //   onErrorContainer: Color(0xff141213),
        //   background: Color(0xfff8fbfd),
        //   onBackground: Color(0xff090909),
        //   surface: Color(0xfff8fbfd),
        //   onSurface: Color(0xff090909),
        //   surfaceVariant: Color(0xfff1f7fc),
        //   onSurfaceVariant: Color(0xff121313),
        //   outline: Color(0xff565656),
        //   shadow: Color(0xff000000),
        //   inverseSurface: Color(0xff121518),
        //   onInverseSurface: Color(0xfff5f5f5),
        //   inversePrimary: Color(0xffddfeff),
        //   surfaceTint: Color(0xff4496e0),
        // ),
        scheme: FlexScheme.aquaBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          outlinedButtonRadius: 7.0,
          sliderTrackHeight: 6,
          fabSchemeColor: SchemeColor.primary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),

      darkTheme: FlexThemeData.dark(
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.dark,
        //   primary: Color(0xffb4e6ff),
        //   onPrimary: Color(0xff121414),
        //   primaryContainer: Color(0xff1e8fdb),
        //   onPrimaryContainer: Color(0xffe4f6ff),
        //   secondary: Color(0xff99ccf9),
        //   onSecondary: Color(0xff101414),
        //   secondaryContainer: Color(0xff202b6d),
        //   onSecondaryContainer: Color(0xffe4e6f0),
        //   tertiary: Color(0xffbaa99d),
        //   onTertiary: Color(0xff121110),
        //   tertiaryContainer: Color(0xff514239),
        //   onTertiaryContainer: Color(0xffeceae8),
        //   error: Color(0xffcf6679),
        //   onError: Color(0xff140c0d),
        //   errorContainer: Color(0xffb1384e),
        //   onErrorContainer: Color(0xfffbe8ec),
        //   background: Color(0xff1a1d1f),
        //   onBackground: Color(0xffededed),
        //   surface: Color(0xff1a1d1f),
        //   onSurface: Color(0xffededed),
        //   surfaceVariant: Color(0xff242a2d),
        //   onSurfaceVariant: Color(0xffdcddde),
        //   outline: Color(0xffa1a1a1),
        //   shadow: Color(0xff000000),
        //   inverseSurface: Color(0xfffafdff),
        //   onInverseSurface: Color(0xff131314),
        //   inversePrimary: Color(0xff5c7278),
        //   surfaceTint: Color(0xffb4e6ff),
        // ),
        scheme: FlexScheme.flutterDash,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          defaultRadius: 4,
          blendOnLevel: 20,
          outlinedButtonRadius: 7.0,
          sliderTrackHeight: 6,
          fabSchemeColor: SchemeColor.primary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
      themeMode: ThemeMode.system,
      // home: RedirectingScreen(),
      home: const LandingPage(),
      // home: ProjectListScreen(title: 'Project List Page'),
    );
  }
}
