import 'package:flutter/material.dart';
import 'package:my_news_app/theme/theme.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  Widget _headerWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: customAdvanceNetworkImage(
                    'https://instagram.fbom26-1.fna.fbcdn.net/v/t51.2885-19/s150x150/153528906_874730533313174_1105060530992836691_n.jpg?tp=1&_nc_ht=instagram.fbom26-1.fna.fbcdn.net&_nc_ohc=TZ1i7qyxlEgAX_C9kh1&edm=AB32dywBAAAA&ccb=7-4&oh=9644e14e7f64f9b3570e13897390b38e&oe=60BE1007&_nc_sid=c59781'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Kushal Biyani',
                      style: kh1Style.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('App Developer', style: kh4Style),
                ],
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: <Widget>[
              _estimateWidget('Followers', '826'),
              _estimateWidget('Following', '251'),
              _estimateWidget('News Read', '81K'),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _estimateWidget(String text, String count) {
    return Expanded(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(count, style: kh4Style.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(text, style: kh5Style),
        ],
      )),
    );
  }

  Widget _settingRow(
    BuildContext context,
    IconData icon1,
    String text,
    bool isEnable,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Icon(
            icon1,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: kh3Style.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(child: SizedBox()),
          isEnable == null
              ? Container()
              : Switch(
                  activeColor: Colors.teal[400],
                  inactiveThumbColor: Colors.white,
                  onChanged: (_) {},
                  value: isEnable,
                )
        ],
      ),
    );
  }

  Widget _logout(BuildContext context, IconData icon1, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(
            icon1,
            color: Colors.teal,
          ),
          SizedBox(width: 10),
          Text(text,
              style: kh3Style.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.teal)),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: _headerWidget(context),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  children: <Widget>[
                    buildDivider(),
                    _settingRow(
                        context, Icons.lightbulb_outline, 'Night', true),
                    buildDivider(),
                    _settingRow(
                        context, Icons.notifications, 'Notification', false),
                    buildDivider(),
                    _settingRow(context, Icons.share, 'Social Media', false),
                    SizedBox(height: 5),
                    buildDivider(),
                    SizedBox(height: 5),
                    _logout(context, Icons.exit_to_app, 'Logout'),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}

Widget buildDivider() {
  return Divider(
    thickness: 0.5,
    color: Colors.white38,
  );
}
