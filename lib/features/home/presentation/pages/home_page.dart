import 'package:flutter/material.dart';
import 'package:islamic_app/features/pray/presentation/pages/pray_page.dart';
import 'package:islamic_app/features/learn/presentation/pages/learn_page.dart';
import 'package:islamic_app/features/community/presentation/pages/community_page.dart';
import 'package:islamic_app/features/store/presentation/pages/store_page.dart';
import 'package:islamic_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:islamic_app/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PrayPage(),
    const LearnPage(),
    const DashboardPage(), // Center tab
    const CommunityPage(),
    const StorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: AppAnimations.normal,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white, // White background for bottom nav
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0D9488).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppTheme.primaryColor, // Teal highlight
          unselectedItemColor: const Color(0xFF4B5563), // text-secondary
          selectedFontSize: 13,
          unselectedFontSize: 11,
          elevation: 0,
          iconSize: 26,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.mosque_outlined),
              activeIcon: Icon(Icons.mosque),
              label: 'Pray',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.nights_stay_outlined), // Moon and star icon
              activeIcon: Icon(Icons.nights_stay),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
