import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/helper/firebaseHelper.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/widgets/bloc/bloc.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User currentUser = FirebaseAuth.instance.currentUser;

  Widget _headerWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      customAdvanceNetworkImage(currentUser.photoURL)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        currentUser.displayName,
                        style: kh2Style.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      Text(
                        currentUser.email,
                        style: kh4Style,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Divider(height: 15, thickness: 4),
          Center(
            child: Text(
              "Saved News",
              style: kh1Style.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 15, thickness: 4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Container(),
        title: Text(
          'Profile',
          style: kAppbarText,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                size: 40,
              ),
              onPressed: () async {
                await logOut();
                BlocProvider.of<NavigationBloc>(context)
                    .add(Navigate(pageIndex: 0));
                Navigator.popAndPushNamed(context, '/login');
              }),
          SizedBox(width: 15)
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder(
        stream: getSaved(currentUser.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Text('No Saved News', style: kh2Style);
          }
          if (snapshot.hasError) {
            return Text('Something went wrong', style: kh2Style);
          } else {
            return CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: _headerWidget(context),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => FavouriteCard(
                    data: snapshot.data.docs[index].data(),
                  ),
                  childCount: snapshot.data.docs.length,
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}

class FavouriteCard extends StatefulWidget {
  final Map data;
  const FavouriteCard({this.data}) : super();

  @override
  _FavouriteCardState createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  @override
  Widget build(BuildContext context) {
    Article artical = toArticle(widget.data);
    return InkWell(
      onTap: () {
        BlocProvider.of<DetailBloc>(context)
            .add(SelectNewsForDetail(article: artical));
        Navigator.pushNamed(context, '/detail');
      },
      child: Dismissible(
        key: Key(artical.title),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          color: Colors.teal,
          padding: EdgeInsets.only(right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                size: 30,
              ),
              Text('Remove',
                  style: kh3Style.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        onDismissed: (direction) {
          deleteItem(artical.url);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 110,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    child: artical.urlToImage == null ||
                            artical.urlToImage.isEmpty
                        ? customImage('noImage.jpg',
                            fit: BoxFit.cover, asset: true)
                        : customImage(artical.urlToImage, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 65,
                      child: Text(
                        artical.title,
                        style: kh4Style,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Text(
                        artical.source.name ?? '',
                        style: kh5Style.copyWith(color: Colors.teal),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
