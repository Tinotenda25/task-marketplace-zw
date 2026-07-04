import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'providers/providers.dart';
import 'screens/auth_screens.dart';
import 'screens/home_screens.dart';
import 'screens/post_task_screen.dart';
import 'screens/job_detail_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'models/models.dart';
import 'widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase when you add credentials
  // await FirebaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
        ChangeNotifierProvider(create: (_) => MessagingProvider()),
      ],
      child: MaterialApp(
        title: 'TaskLink - Task Marketplace',
        theme: AppTheme.lightTheme(),
        home: const MainApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? _currentScreen = 'splash';
  String? _userRole;
  String _currentTab = 'home';
  Job? _selectedJob;

  @override
  Widget build(BuildContext context) {
    // Splash/Auth Screens
    if (_currentScreen == 'splash') {
      return SplashScreen(
        onNavigate: (screen) => setState(() => _currentScreen = screen),
      );
    }

    if (_currentScreen == 'login') {
      return LoginScreen(
        onLogin: (role) {
          setState(() {
            _userRole = role;
            _currentScreen = 'main';
            _currentTab = role == 'worker' ? 'jobs' : 'home';
          });
        },
        onBack: () => setState(() => _currentScreen = 'splash'),
      );
    }

    if (_currentScreen == 'register') {
      return RegisterScreen(
        onRegister: (role) {
          setState(() {
            _userRole = role;
            _currentScreen = 'main';
            _currentTab = role == 'worker' ? 'jobs' : 'home';
          });
        },
        onBack: () => setState(() => _currentScreen = 'splash'),
      );
    }

    // Post Task Screen
    if (_currentScreen == 'post') {
      return PostTaskScreen(
        onBack: () => setState(() => _currentScreen = 'main'),
        onPosted: () => setState(() => _currentScreen = 'main'),
      );
    }

    // Job Detail Screen
    if (_selectedJob != null) {
      return JobDetailScreen(
        job: _selectedJob!,
        userRole: _userRole ?? 'client',
        onBack: () => setState(() => _selectedJob = null),
      );
    }

    // Main App with Bottom Nav
    return Scaffold(
      body: _buildMainContent(),
      bottomNavigationBar: BottomNavBar(
        currentTab: _currentTab,
        userRole: _userRole ?? 'client',
        onTabChanged: (tab) {
          if (tab == 'post') {
            setState(() => _currentScreen = 'post');
          } else {
            setState(() => _currentTab = tab);
          }
        },
      ),
    );
  }

  Widget _buildMainContent() {
    if (_userRole == null) {
      return const SplashScreen(onNavigate: null);
    }

    if (_userRole == 'client') {
      switch (_currentTab) {
        case 'home':
          return ClientHomeScreen(
            onNavigate: (screen) {
              if (screen == 'post') {
                setState(() => _currentScreen = 'post');
              }
            },
            onJobPress: (job) => setState(() => _selectedJob = job),
          );
        case 'messages':
          return const MessagesScreen();
        case 'profile':
          return ProfileScreen(userRole: _userRole!);
        default:
          return ClientHomeScreen(
            onNavigate: (screen) {},
            onJobPress: (job) => setState(() => _selectedJob = job),
          );
      }
    } else {
      // Worker
      switch (_currentTab) {
        case 'jobs':
          return WorkerJobsScreen(
            onJobPress: (job) => setState(() => _selectedJob = job),
          );
        case 'messages':
          return const MessagesScreen();
        case 'profile':
          return ProfileScreen(userRole: _userRole!);
        default:
          return WorkerJobsScreen(
            onJobPress: (job) => setState(() => _selectedJob = job),
          );
      }
    }
  }
}
