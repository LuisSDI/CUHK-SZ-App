
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class PageIndex extends StatelessWidget {
  bool currentPage;
  PageIndex(this.currentPage);

  Widget pageIndexIndicator(bool isCurrentPage){
    ScreenScaler scaler = ScreenScaler();

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: scaler.getWidth(.5)
      ),
      height: scaler.getWidth(.75),
      width: scaler.getWidth(.75),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrentPage ? Color(0xff6747CD) : Color(0xffE5E5E5)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageIndexIndicator(currentPage);
  }
}


