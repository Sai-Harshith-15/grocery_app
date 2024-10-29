import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive.dart';
import '../widgets/mytext.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  //int counter = 0;

  // void inc() {
  //   setState(() {
  //     counter++; // Increment the counter
  //   });
  // }

  // Function to decrement the counter
  // void dec() {
  //   setState(() {
  //     if (counter > 0) {
  //       counter--; // Decrement the counter (check to avoid going negative)
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Center(
          child: HeadText(
            text: 'Favorites',
            textColor: AppColors.primaryBlack,
            textWeight: FontWeight.w700,
            textSize: 20,
            textHeight: 18,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 20, // Assuming 4 identical items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/images/fav.jpeg', // Image asset
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: HeadText(
                        text: 'Bell Pepper Red',
                        textColor: AppColors.primaryBlack,
                        textWeight: FontWeight.w800,
                        textSize: 12,
                        isTextOverflow: false,
                        maxLines: 2,
                      ),
                      subtitle: const HeadText(text: 'Weight'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryGreen,
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  size: 14,
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              )),

                          Container(
                            width: 24,
                            child: const HeadText(
                              textAlign: TextAlign.center,
                              text: '1',
                              textSize: 12,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryGreen,
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  size: 14,
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )), // Display quantity

                          const SizedBox(
                            width: 30,
                          ),
                          HeadText(
                            text: '\$4.99',
                            textColor: AppColors.primaryBlack,
                            textWeight: FontWeight.w600,
                            textSize: 16.8,
                          ),

                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.chevron_right,
                                color: AppColors.primaryBlack,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            // Checkout button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                onPressed: () {},
                height: 70,
                color: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeadText(
                          text: 'Add All to Cart',
                          textColor: AppColors.background,
                          textWeight: FontWeight.w400,
                          textSize: 18.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: HeadText(
                            text: '\$12.99',
                            textColor: AppColors.background,
                            textWeight: FontWeight.w600,
                            textSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
