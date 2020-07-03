import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpansionItem extends StatelessWidget {
  final String title;
  final String data;
  final RichText richText;
  final Container special;

  ExpansionItem(
      {Key key, @required this.title, this.data, this.richText, this.special});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    final theme = Theme.of(context).copyWith(
      dividerColor: Color(0xff6747CD),
    );
    return Padding(
      padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
      child: Container(
        child: Theme(
          data: theme,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff6747CD), width: 2),
              borderRadius: BorderRadius.circular(0),
            ),
            child: ExpansionTile(
              trailing: Padding(
                padding: EdgeInsets.only(
                  right: scaler.getHeight(2),
                ),
                child: Icon(
                  Entypo.chevron_down,
                  color: Color(0xff6747CD),
                ),
              ),
              title: Container(
                padding: EdgeInsets.only(left: scaler.getHeight(2)),
                child: Text(
                  title,
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              children: <Widget>[
                (data == null && richText == null)
                    ? special
                    : Container(
                        width: double.infinity,
                        color: Color(0xff6747CD),
                        child: (data == null)
                            ? richText
                            : Text(
                                data,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
