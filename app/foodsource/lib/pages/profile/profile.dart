import 'package:foodsource/common/colors.dart';
import 'package:foodsource/models/user.dart';
import 'package:flutter/material.dart';
import 'package:foodsource/pages/profile/profiledetails/header/profile_detail_header.dart';
import 'package:meta/meta.dart';
import 'package:foodsource/pages/profile/profiledetails/profile_detail_body.dart';
import 'package:foodsource/pages/profile/profiledetails/footer/profile_detail_footer.dart';

class ProfileDetails extends StatefulWidget {
  ProfileDetails(this.user, {@required this.avatarTag, Key key, this.title})
      : super(key: key);

  final String title;
  final User user;
  final Object avatarTag;

  @override
  ProfileDetailsState createState() => new ProfileDetailsState();
}

class ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          kAppBlue,
          kAppBlueDarker,
        ],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(title: new Text('Profile')),
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ProfileDetailHeader(
                widget.user,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new ProfileDetailBody(widget.user),
              ),
              new ProfileShowcase(widget.user),
            ],
          ),
        ),
      ),
    );
  }
}