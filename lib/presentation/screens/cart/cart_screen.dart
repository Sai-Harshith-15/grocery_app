import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/responsive.dart';
import '../../widgets/mytext.dart';
import '../../widgets/paraText.dart';
import 'tip_bottomsheet.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.primaryBlack,
            size: 36,
            weight: 20,
          ),
          onPressed: () {
            // Add your navigation or back function here
          },
        ),
        title: Center(
          child: HeadText(
            text: 'My Cart',
            textColor: AppColors.primaryBlack,
            textWeight: FontWeight.w700,
            textSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Changed for better layout
        child: Column(
          children: [
            // Cart items section
            Container(
              height: 400, // Changed for better layout
              child: ListView.builder(
                itemCount: 12, // Assuming 4 identical items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                            245, 245, 245, 1), // Background color
                        borderRadius: BorderRadius.circular(
                            12), // Border radius for rounded corners
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/fav.jpeg', // Image asset
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: HeadText(
                          text: 'Bell Peperr Red',
                          textColor: AppColors.primaryBlack,
                          textWeight: FontWeight.w800,
                          textSize: 12,
                          isTextOverflow: false,
                          maxLines: 2,
                        ),
                        subtitle: HeadText(text: '1kg, price'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryGreen,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: InkWell(
                                      onTap: () {
                                        // dec();
                                      },
                                      child: Icon(
                                        size: 14,
                                        Icons.remove,
                                        color: AppColors.background,
                                      ),
                                    )),

                                SizedBox(
                                  width: 10.0,
                                ),
                                HeadText(
                                  text: '56',
                                  textSize: 12,
                                  textWeight: FontWeight.w500,
                                ), //DISPLAY QUANTITY
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryGreen,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: InkWell(
                                      onTap: () {
                                        // inc();
                                      },
                                      child: Icon(
                                        size: 14,
                                        Icons.add,
                                        color: AppColors.background,
                                      ),
                                    )),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  child: HeadText(
                                    text: '\$4.99',
                                    textColor: AppColors.primaryBlack,
                                    textWeight: FontWeight.w600,
                                    textSize: 16.8,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      color: AppColors.secondaryBlack,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeadText(
                                text: 'Missed something?',
                                textColor: AppColors.primaryBlack,
                                textWeight: FontWeight.w600,
                                textSize: 14,
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryGreen,
                                    borderRadius: BorderRadius.circular(6)),
                                child: InkWell(
                                  onTap: () {
                                    // inc();
                                  },
                                  child: Icon(
                                    size: 14,
                                    Icons.add,
                                    color: AppColors.background,
                                  ),
                                ),
                              ),
                              HeadText(
                                text: 'Add More items',
                                textColor: AppColors.primaryGreen,
                                textWeight: FontWeight.w600,
                                textSize: 14,
                              )
                            ],
                          ),
                        ),

                        //apply coupon section
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/coupon.jpeg',
                                      height: 20,
                                      width: 16,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    HeadText(
                                      text: 'Apply Coupon',
                                      textColor: AppColors.primaryBlack,
                                      textWeight: FontWeight.w700,
                                      textSize: 14,
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 20.16,
                                    width: 20.16,
                                    decoration: BoxDecoration(
                                        color: AppColors.secondaryBlack,
                                        borderRadius:
                                            BorderRadius.circular(36)),
                                    child: InkWell(
                                      onTap: () {
                                        //apply coupon logic here
                                      },
                                      child: Icon(
                                        size: 20,
                                        Icons.add,
                                        color: AppColors.background,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    // Coupon section
                    Padding(
                      padding: EdgeInsets.all(
                          16.0), // You can set a default padding for other cases, like tablet

                      child: Container(
                        height: 37.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(127, 198, 160, 2),

                          borderRadius:
                              BorderRadius.circular(10), // Corrected this part
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? 1500
                                : Responsive.isTablet(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 500
                                    : 400,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadText(
                                  text: 'Coupon Applied!',
                                  textColor: AppColors.background,
                                  textSize: 14,
                                  textWeight: FontWeight.w500,
                                ),
                                HeadText(
                                  text: 'ORGANOFRESH',
                                  textColor: AppColors.background,
                                  textSize: 11.67,
                                  textWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 500,
                        child: GestureDetector(
                          onTap: () {
                            TipBottomSheet(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  HeadText(
                                    text: 'Delivery  driver tip ',
                                    textColor: AppColors.primaryBlack,
                                    textSize: 17,
                                    textWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ParaText(
                                    text: 'This goes to the delivery driver',
                                    textColor: AppColors.secondaryBlack,
                                    textSize: 12,
                                    textWeight: FontWeight.w500,
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    TipBottomSheet(context);
                                  },
                                  icon: Icon(Icons.chevron_right)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        Responsive.isDesktop(context) ||
                                Responsive.isDesktopLarge(context)
                            ? 40
                            : Responsive.isMobile(context)
                                ? 40
                                : 32,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadText(
                              text: 'Your Bill',
                              textColor: AppColors.primaryBlack,
                              textWeight: FontWeight.w700,
                              textSize: 16.8,
                            ),
                            Divider(
                              color: AppColors.primaryBlack,
                            ),
                            // Cart row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadText(
                                  text: 'Cart',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 11.8,
                                ),
                                HeadText(
                                  text: '\$4.99',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 11.8,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Taxes row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadText(
                                  text: 'taxes',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 11.8,
                                ),
                                HeadText(
                                  text: '\$4.99',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 11.8,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Delivery & Handling row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadText(
                                  text: 'Delivery & Handling',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 11.8,
                                ),
                                HeadText(
                                  text: '\$4.99',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 11.8,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Total row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadText(
                                  text: 'TOTAL',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 14.8,
                                ),
                                HeadText(
                                  text: '\$4.99',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w700,
                                  textSize: 14.8,
                                ),
                              ],
                            ),
                          ]),
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadText(
                                  text: 'Ordering for someone else?',
                                  textColor: AppColors.primaryBlack,
                                  textWeight: FontWeight.w600,
                                  textSize: 17,
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                        border: Border.all(
                                          color: AppColors.primaryGreen,
                                        )),
                                    child: HeadText(
                                      text: 'Add Details',
                                      textColor: AppColors.primaryGreen,
                                      textWeight: FontWeight.w600,
                                      textSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.call_outlined),
                              SizedBox(width: 10),
                              HeadText(
                                text: 'Call when you arrive',
                                textHeight: 14,
                                textWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 280),
                              // Static Checkbox (no functionality)
                              Container(
                                padding: EdgeInsets.all(4.0),
                                child: Checkbox(
                                  value: false, // This will always be unchecked
                                  onChanged: null, // No functionality
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.door_front_door_outlined),
                              SizedBox(width: 10),
                              HeadText(
                                text: 'Leave at the door',
                                textHeight: 18,
                                textWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 295),
                              // Static Checkbox (no functionality)
                              Container(
                                padding: EdgeInsets.all(4.0),
                                child: Checkbox(
                                  value: false, // This will always be unchecked
                                  onChanged: null, // No functionality
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.do_not_disturb_alt_outlined),
                              SizedBox(width: 10),
                              HeadText(
                                text: 'Don\'t  ring the bell',
                                textHeight: 14,
                                textWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 295),
                              // Static Checkbox (no functionality)
                              Container(
                                padding: EdgeInsets.all(4.0),
                                child: Checkbox(
                                  value: false, // This will always be unchecked
                                  onChanged: null, // No functionality
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Add notes for the driver',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide.none, // Removes the outline border
                        ),
                        filled: true, // Ensures the background color is applied
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ParaText(text: 'Max 50 Charcters'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Take the minimum space needed
                          children: [
                            ListTile(
                              leading: Image.asset(
                                'assets/images/delivery.jpeg',
                                width: 24,
                                height: 24,
                              ),
                              title: HeadText(
                                text: 'Delivery',
                                textColor: AppColors.primaryBlack,
                                textSize: 17,
                                textWeight: FontWeight.w600,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Use min to wrap the contents tightly
                                children: [
                                  ParaText(
                                    text: 'Select Method',
                                    textColor: AppColors.secondaryBlack,
                                    textSize: 15,
                                    textWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                      width: 8), // Space between text and icon
                                  Icon(
                                    Icons.chevron_right,
                                    color: AppColors.secondaryBlack,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              leading: Icon(
                                Icons.payment_outlined,
                                color: AppColors.primaryGreen,
                              ),
                              title: HeadText(
                                text: 'Payment',
                                textColor: AppColors.primaryBlack,
                                textSize: 17,
                                textWeight: FontWeight.w600,
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '*****4321',
                                    style: TextStyle(
                                      color: AppColors.primaryGreen,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ParaText(
                                          text: 'Change',
                                          textColor: AppColors.secondaryBlack,
                                          textSize: 15,
                                          textWeight: FontWeight.w500,
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.chevron_right,
                                          color: AppColors.secondaryBlack,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              leading: Icon(Icons.attach_money_rounded),
                              title: HeadText(
                                text: 'Total cost',
                                textColor: AppColors.primaryBlack,
                                textSize: 17,
                                textWeight: FontWeight.w600,
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  HeadText(
                                    text: '\$22.99',
                                    textColor: AppColors.primaryGreen,
                                    textSize: 17,
                                    textWeight: FontWeight.w600,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ParaText(
                                          text: 'View Order Details',
                                          textColor: AppColors.secondaryBlack,
                                          textSize: 15,
                                          textWeight: FontWeight.w500,
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.chevron_right,
                                          color: AppColors.secondaryBlack,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
