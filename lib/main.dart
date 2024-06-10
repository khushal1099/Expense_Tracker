import 'package:expense_tracker/widgets/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var kColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 119, 90, 246),
  );

  var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 5, 99, 125),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: kDarkColorScheme,
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.primary.withOpacity(0.65),
          foregroundColor: Colors.white,
        ),
        iconTheme: IconThemeData().copyWith(
          color: Colors.black,
        ),
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.primaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData().copyWith(
          backgroundColor: kDarkColorScheme.primaryContainer,
        ),
        dialogTheme: DialogTheme()
            .copyWith(backgroundColor: kDarkColorScheme.primaryContainer),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
        bottomSheetTheme: BottomSheetThemeData().copyWith(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter ExpenseTracker'),
    );
  }
}
