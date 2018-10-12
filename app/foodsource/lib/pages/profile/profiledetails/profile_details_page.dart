import 'package:foodsource/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:foodsource/pages/profile/profiledetails/footer/profile_detail_footer.dart';
import 'package:foodsource/pages/profile/profiledetails/profile_detail_body.dart';
import 'package:foodsource/pages/profile/profiledetails/header/profile_detail_header.dart';
import 'package:meta/meta.dart';

class ProfileDetailsPage extends StatefulWidget {
  ProfileDetailsPage(
    this.profile, {
    @required this.avatarTag,
  });

  final String profile;
  final Object avatarTag;

  @override
  _ProfileDetailsPageState createState() => new _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
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
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ProfileDetailHeader(
                widget.profile,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new ProfileDetailBody(widget.profile),
              ),
              new ProfileShowcase(widget.profile),
            ],
          ),
        ),
      ),
    );
  }
}
