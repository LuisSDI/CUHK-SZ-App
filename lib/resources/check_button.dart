import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class CheckButtom extends StatelessWidget {
  final GestureTapCallback onTap;

  const CheckButtom({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Container(
      height: scaler.getWidth(24),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          height: scaler.getWidth(15),
          decoration: BoxDecoration(color: Color(0xCC6747CD)),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment(0.8, -1),
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(scaler.getWidth(0)),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 35,
                    )),
              ),
              width: scaler.getWidth(15),
              height: scaler.getWidth(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff5534C1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4.0,
                    // soften the shadow//extend the shadow
                    offset: Offset(
                      0,
                      6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
