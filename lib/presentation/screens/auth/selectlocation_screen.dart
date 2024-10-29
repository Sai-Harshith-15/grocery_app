import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/responsive.dart';
import '../../widgets/inkwell_button.dart';
import '../../widgets/mytext.dart';
import '../../widgets/paraText.dart';

class SelectlocationScreen extends StatefulWidget {
  const SelectlocationScreen({super.key});

  @override
  State<SelectlocationScreen> createState() => _SelectlocationScreenState();
}

class _SelectlocationScreenState extends State<SelectlocationScreen> {
  String? selectedZone = 'Banasree'; // Default value
  String? selectedArea = 'WoodWard Ave'; // Default value

  List<String> zones = ['Banasree', 'Gulshan', 'Dhanmondi', 'Uttara'];
  List<String> areas = [
    'WoodWard Ave',
    'Oak Street',
    'Pine Lane',
    'Maple Road'
  ];

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left),
          iconSize: 40.0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Image.asset(
                  'images/map.png',
                  // width: media.width * 0.6,
                ),
                SizedBox(
                  height: Responsive.isDesktop(context) ||
                          Responsive.isDesktopLarge(context)
                      ? 40
                      : Responsive.isTablet(context) ||
                              Responsive.isMobileLarge(context)
                          ? 30
                          : 70,
                ),
                // SizedBox(height: media.width * 0.1),
                const HeadText(
                  text: 'Select Your Location',
                  textSize: 26.0,
                  textWeight: FontWeight.w600,
                ),
                SizedBox(height: 20),
                Center(
                  child: ParaText(
                    isTextOverflow: false,
                    text:
                        'Switch on your location to stay in tune with  what\'s happening in your area',
                    textAlign: TextAlign.center,
                    textSize: 16.0,
                    textWeight: FontWeight.w400,
                  ),
                ),
                //  Responsive(mobile: mobile, desktop: desktop),
                const SizedBox(
                  height: 70,
                ),

                // Dropdown for Zone
                Align(
                  alignment: Alignment.centerLeft,
                  child: HeadText(
                    text: "Your Zone",
                    textSize: 16,
                    textWeight: FontWeight.w400,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedZone,
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    border: UnderlineInputBorder(),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(
                    //      ), // Transparent border when focused
                    // ),
                  ),
                  dropdownColor: Colors.white, // Set dropdown background color
                  items: zones.map((String zone) {
                    return DropdownMenuItem<String>(
                        value: zone,
                        child: ParaText(
                          text: zone,
                          textSize: 18,
                          textWeight: FontWeight.w400,
                          textColor: AppColors.primaryBlack,
                        ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedZone = newValue;
                    });
                  },
                  // Ensures no focus color appears
                ),

                SizedBox(height: 20),

                // Dropdown for Area
                Align(
                  alignment: Alignment.centerLeft,
                  child: HeadText(
                    text: "Your Area",
                    textSize: 16,
                    textWeight: FontWeight.w400,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedArea,
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    border: UnderlineInputBorder(),
                  ),
                  items: areas.map((String area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: ParaText(
                        text: area,
                        textSize: 18,
                        textWeight: FontWeight.w400,
                        textColor: AppColors.primaryBlack,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedArea = newValue;
                    });
                  },
                ),
                const SizedBox(height: 80),
                InkWellButton(text: 'Continue', onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
