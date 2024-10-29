import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import 'cart/cart_screen.dart';
import 'explore_scren.dart';
import 'favorurite_screen.dart';
import 'homescreen.dart';
import 'profile_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    controller = TabController(length: 5, vsync: this);

    // Listen to the animation for real-time tab updates
    controller?.animation?.addListener(() {
      setState(() {
        selectedTab =
            (controller?.animation?.value ?? 0).round(); // Update on swipe
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          HomeScreen(),
          ExploreScreen(),
          CartScreen(),
          FavoriteScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              // BoxShadow(
              //     color: AppColors.textcolor,
              //     blurRadius: 2,
              //     offset: Offset(0, -2)
              // )
            ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
            controller: controller,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent, // No underline
            indicatorWeight: 1,
            labelColor: AppColors.primaryBlack,
            labelStyle: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: AppColors.primaryBlack,
            unselectedLabelStyle: TextStyle(
              color: AppColors.secondaryGreen,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              _buildTab(Icons.storefront, 'Home', 0),
              _buildTab(CupertinoIcons.search, 'Explore', 1),
              _buildTab(Icons.shopping_cart_outlined, 'Cart', 2),
              _buildTab(Icons.favorite_border_outlined, 'Favorites', 3),
              _buildTab(Icons.person_outline_outlined, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build individual Tab widgets
  Tab _buildTab(IconData icon, String label, int index) {
    bool isSelected = selectedTab == index;

    return Tab(
      icon: GestureDetector(
        onTap: () {
          controller!.animateTo(index); // Manually handle the tab selection
          setState(() {
            selectedTab = index; // Update the selectedTab value
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Smooth transition
          curve: Curves.easeInOut,
          child: Icon(
            icon,
            size: isSelected ? 30 : 28, // Smoothly animate between sizes
            color:
                isSelected ? AppColors.secondaryGreen : AppColors.primaryBlack,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          controller!.animateTo(index); // Manually handle the tab selection
          setState(() {
            selectedTab = index; // Update the selectedTab value
          });
        },
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            color:
                isSelected ? AppColors.secondaryGreen : AppColors.primaryBlack,
            fontSize: isSelected ? 12 : 10, // Smoothly animate text size
            fontWeight: FontWeight.w600,
          ),
          duration: const Duration(milliseconds: 300), // Smooth transition
          curve: Curves.easeInOut,
          child: FittedBox(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis, // Avoid text wrapping
              maxLines: 1, // Only 1 line
              textAlign: TextAlign.center, // Center the text
            ),
          ),
        ),
      ),
    );
  }
}
