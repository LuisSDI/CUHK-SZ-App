import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/resources/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  final User user;
  UserBloc userBloc;

  EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name;
  String dropdownValue;
  String description;
  String countryField;
  String photoUrL;
  Country country;
  final GlobalKey<ScaffoldState> _scaffkey = GlobalKey();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    photoUrL ??= widget.user.photoUrL;
    dropdownValue ??= widget.user.type;
    countryField ??= widget.user.country;
    country = CountryPickerUtils.getCountryByName(countryField);
    return BlocProvider(
      bloc: UserBloc(),
      child: Scaffold(
        key: _scaffkey,
        body: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                  left: scaler.getHeight(2), right: scaler.getHeight(2)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: scaler.getHeight(7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Exit Button
                          Container(
                            width: scaler.getHeight(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff6747CD),
                                    Color(0x8C3300D6)
                                  ]),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          //Edit Profile Button
                          Container(
                            height: scaler.getHeight(5),
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Edit Profile",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 36,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          //Save Button
                          Container(
                            width: scaler.getHeight(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff6747CD),
                                    Color(0x8C3300D6)
                                  ]),
                            ),
                            child: IconButton(
                              onPressed: () {
                                updateUser();
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Profile Picture
                    Padding(
                      padding: EdgeInsets.only(top: scaler.getHeight(2)),
                      child: Stack(
                        children: [
                          Container(
                            height: scaler.getWidth(40),
                            width: scaler.getWidth(40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(scaler.getWidth(20))),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image(
                                  image: NetworkImage(photoUrL),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: scaler.getWidth(40),
                                      width: scaler.getWidth(40),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: scaler.getWidth(28),
                            left: scaler.getWidth(29),
                            child: Container(
                              width: scaler.getHeight(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff6747CD),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff6747CD),
                                      Color(0x8C3300D6)
                                    ]),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  widget.userBloc = BlocProvider.of(context);
                                  Async_Loader.showLoadingDialog(context);
                                  String photo = await widget.userBloc
                                      .getImageUrl(widget.user.uid);
                                  Navigator.of(context).pop();
                                  setState(() {
                                    photoUrL = photo;
                                  });
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Name Text Field
                    Padding(
                      padding: EdgeInsets.only(top: scaler.getHeight(2)),
                      child: Stack(children: [
                        Container(
                          height: scaler.getHeight(5),
                          width: scaler.getHeight(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                'Name',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: scaler.getHeight(.5)),
                          alignment: Alignment.centerRight,
                          height: scaler.getHeight(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff6747CD),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            height: scaler.getHeight(5),
                            child: TextFormField(
                              maxLength: 30,
                              textAlign: TextAlign.right,
                              validator: (input) {
                                if (input.isEmpty) {
                                  _scaffkey.currentState.showSnackBar(SnackBar(
                                    content: Container(
                                      alignment: Alignment.center,
                                      height: scaler.getHeight(2),
                                      child: Text(
                                        "Please dont leave any field empty",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                          fontSize: 14,
                                        )),
                                      ),
                                    ),
                                  ));
                                  return '';
                                }
                              },
                              onSaved: (input) {
                                name = input;
                              },
                              initialValue: widget.user.name,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(height: 0),
                                hintText: 'Aa',
                                focusedErrorBorder: InputBorder.none,
                                hintStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                  fontSize: 18,
                                )),
                                counterText: '',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    //Country Text Field
                    Padding(
                      padding: EdgeInsets.only(top: scaler.getHeight(2)),
                      child: Stack(children: [
                        Container(
                          height: scaler.getHeight(5),
                          width: scaler.getHeight(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Country',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            padding:
                                EdgeInsets.only(right: scaler.getHeight(.5)),
                            alignment: Alignment.centerRight,
                            height: scaler.getHeight(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff6747CD),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              child: Container(
                                width: scaler.getHeight(33),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    CountryPickerUtils.getDefaultFlagImage(
                                        country),
                                    SizedBox(width: 8.0),
                                    Flexible(
                                        child: Text(
                                      country.name,
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    )),
                                    SizedBox(width: 8.0),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff6747CD),
                                    )
                                  ],
                                ),
                              ),
                              onTap: _openCountryPickerDialog,
                            )),
                      ]),
                    ),
                    // I am Text Field
                    Padding(
                      padding: EdgeInsets.only(top: scaler.getHeight(2)),
                      child: Stack(children: [
                        Container(
                          height: scaler.getHeight(5),
                          width: scaler.getHeight(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                'I am a ...',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.only(right: scaler.getHeight(.5)),
                          alignment: Alignment.centerRight,
                          height: scaler.getHeight(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff6747CD),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: scaler.getHeight(14),
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                value: dropdownValue,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff6747CD),
                                ),
                                iconSize: 24,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Student',
                                  'Parent',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    // Description Text Field
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(2),
                          bottom: scaler.getHeight(2)),
                      child: Container(
                        child: Stack(children: [
                          Container(
                            height: scaler.getHeight(5),
                            alignment: Alignment(0, .5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff6747CD),
                                    Color(0x8C3300D6)
                                  ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'Description',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: scaler.getHeight(.5)),
                            alignment: Alignment.topLeft,
                            height: scaler.getHeight(20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff6747CD),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: scaler.getHeight(4)),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty || input.trim().length == 0) {
                                    _scaffkey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: scaler.getHeight(2),
                                        child: Text(
                                          "Please dont leave any field empty",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                            fontSize: 14,
                                          )),
                                        ),
                                      ),
                                    ));
                                    return '';
                                  }
                                },
                                onSaved: (input) {
                                  description = input;
                                },
                                maxLength: 170,
                                maxLines: 5,
                                initialValue: widget.user.description,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 16)),
                                decoration: InputDecoration(
                                  hintText: 'Aa',
                                  hintStyle: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontSize: 16,
                                  )),
                                  counterText: '',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: scaler.getHeight(9),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
        ),
      ),
    );
  }

  Future<void> updateUser() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          User user = User(
              email: widget.user.email,
              name: name,
              photoUrL: photoUrL,
              uid: widget.user.uid,
              country: countryField,
              description: description,
              phone: widget.user.phone,
              type: dropdownValue);
          widget.userBloc.updateUserData(user);
          Navigator.pop(context);
        } catch (e) {
          print(e.message);
        }
      }
    }
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      );
  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Color(0xff6747CD)),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Color(0xff6747CD),
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select country'),
            onValuePicked: (Country country) =>
                setState(() => countryField = country.name),
            itemBuilder: _buildDialogItem,
          ),
        ),
      );
}
