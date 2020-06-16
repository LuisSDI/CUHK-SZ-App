import 'package:flutter/material.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoUrL;
  final String phone;
  final String country;
  final String type;
  final String description;

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoUrL,
    @required this.phone,
    @required this.country,
    @required this.type,
    @required this.description,
  });
}
