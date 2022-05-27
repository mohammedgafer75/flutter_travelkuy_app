import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelkuy_app/constants/color_constant.dart';
import 'package:flutter_travelkuy_app/screens/home_screen.dart';
import 'package:flutter_travelkuy_app/screens/wallet.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class BottomNavigationTravelkuy extends StatefulWidget {
  const BottomNavigationTravelkuy({Key? key}) : super(key: key);

  @override
  _BottomNavigationTravelkuyState createState() =>
      _BottomNavigationTravelkuyState();
}

class _BottomNavigationTravelkuyState extends State<BottomNavigationTravelkuy> {
  int _selectedIndex = 0;
  /*var bottomTextStyle =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);*/
  final AuthController controller = Get.put(AuthController());
  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (index == 0) {
      Get.to(() => const HomeScreen());
    } else if (index == 1) {
      Get.to(() => const Wallet());
    } else if (index == 2) {
      controller.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: mFillColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 5))
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? SvgPicture.asset('assets/icons/home_colored.svg')
                : SvgPicture.asset('assets/icons/home.svg'),
            label: 'الصفحة الرئسية',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(Icons.wallet_travel)
                : const Icon(Icons.wallet_travel),
            label: 'المحفظة',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? SvgPicture.asset('assets/icons/account_colored.svg')
                : SvgPicture.asset('assets/icons/account.svg'),
            label: 'تسجيل خروج',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: mBlueColor,
        unselectedItemColor: mSubtitleColor,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }
}
