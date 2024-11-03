import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/responsive.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/mytext.dart';
import '../widgets/paraText.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = true;

  ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HeadText(
          text: 'Profile',
          textColor: AppColors.primaryBlack,
          textSize: 20,
          textWeight: FontWeight.w700,
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
            title: const HeadText(
              text: 'Viprat',
              textSize: 18,
              textWeight: FontWeight.bold,
            ),
            subtitle: ParaText(
              text: 'Viprat@example.com',
              textSize: 16,
              textColor: AppColors.primaryBlack,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          const SectionHeader(title: 'Account'),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: AppColors.primaryBlack,
              size: 30,
            ),
            title: const HeadText(
              text: 'Edit Profile',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.primaryBlack),
            onTap: () {},
          ),
          ListTile(
            leading:
                Icon(Icons.vpn_key_outlined, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'Change Password',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.primaryBlack),
            onTap: () {},
          ),
          const SectionHeader(title: 'General'),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined,
                color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'Orders',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.primaryBlack),
            onTap: () {},
          ),
          ListTile(
            leading:
                Icon(Icons.favorite_outline, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'Favorites',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.primaryBlack),
            onTap: () {},
          ),
          ListTile(
            leading:
                Icon(Icons.location_on_outlined, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'My Addresses',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.primaryBlack),
            onTap: () {},
          ),
          ListTile(
            leading:
                Icon(Icons.credit_card_outlined, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'My Cards',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.primaryBlack),
            onTap: () {},
          ),
          const SectionHeader(title: 'App Settings'),

          ExpansionTile(
            leading:
                Icon(Icons.notifications_none, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'Notifications',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            // ignore: sort_child_properties_last
            children: [
              ListTile(
                title: const HeadText(
                  text: 'Enable Notifications',
                  textSize: 16,
                  textWeight: FontWeight.bold,
                ),
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
            ],
            tilePadding: const EdgeInsets.symmetric(
                horizontal:
                    16), // Optional: remove padding for a more compact look
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.transparent), // Remove top and bottom borders
            ),
          ),

          ListTile(
            leading:
                Icon(Icons.dark_mode_outlined, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'Dark Mode',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            trailing: Switch(
              value: darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  darkModeEnabled = value;
                });
              },
              activeColor: AppColors.TertiaryGreen,
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.language, color:AppColors.primaryBlack),
          //   title: const Text('Language'),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: const [
          //       Text('English', style: TextStyle(color:AppColors.primaryBlack)),
          //       Icon(Icons.chevron_right, color:AppColors.primaryBlack),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.primaryBlack),
            title: const HeadText(
              text: 'Logout',
              textSize: 16,
              textWeight: FontWeight.bold,
            ),
            onTap: () async {
              await controller.logout();
            },
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: HeadText(
          text: title,
          textColor: AppColors.secondaryGreen,
          textSize: 16,
          textWeight: FontWeight.bold,
        ));
  }
}
