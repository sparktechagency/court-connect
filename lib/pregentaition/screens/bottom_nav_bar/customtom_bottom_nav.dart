import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.blue[900], // Dark Blue for Selected
      unselectedItemColor: Colors.grey, // Grey for Unselected
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            colorFilter: ColorFilter.mode(
              _selectedIndex == 0 ? Colors.blue[900]! : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/network.svg',
            colorFilter: ColorFilter.mode(
              _selectedIndex == 1 ? Colors.blue[900]! : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Network',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/chat.svg',
            colorFilter: ColorFilter.mode(
              _selectedIndex == 2 ? Colors.blue[900]! : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/profile.svg',
            colorFilter: ColorFilter.mode(
              _selectedIndex == 3 ? Colors.blue[900]! : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
