import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/hostel_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => HostelProvider()..load(),
    child: const HostelTrackApp(),
  ));
}

class HostelTrackApp extends StatelessWidget {
  const HostelTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B5B)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        appBarTheme: const AppBarTheme(centerTitle: false),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
