import 'package:flutter/material.dart';
import 'package:rol_fix/constants/categories.dart';
import 'package:rol_fix/constants/restaurants.dart';
import 'package:rol_fix/widgets/slide_item.dart';
import 'package:rol_fix/widgets/trending_item.dart';

import 'trending.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ScreenSize = MediaQuery.of(context).size;
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.0)),
                  hintText: 'type to search..',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
        ),
        preferredSize: Size(ScreenSize.width, 60.0),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Trending Restaurants',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
                FlatButton(
                  child: Text(
                    "Show All",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Trending();
                    }));
                  },
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: ScreenSize.height / 2.4,
              width: ScreenSize.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: (restaurants == null) ? 0 : restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  Map restaurant = restaurants[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: restaurant["img"],
                      title: restaurant["title"],
                      address: restaurant["address"],
                      rating: restaurant["rating"],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Category',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
                FlatButton(
                  child: Text(
                    'See All(' + (restaurants.length).toString() + ')',
                    style: TextStyle(
                        //   fontSize: 22,
                        //    fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    /*Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      //return DishesScreen();
                    }));*/
                  },
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: ScreenSize.height / 6,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: (categories == null) ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            cat["img"],
                            height: ScreenSize.height / 6,
                            width: ScreenSize.width / 6,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.2, 0.7],
                                colors: [
                                  cat['color1'],
                                  cat['color2'],
                                ],
                              ),
                            ),
                            height: ScreenSize.height / 6,
                            width: ScreenSize.width / 6,
                          ),
                          Center(
                            child: Container(
                              height: ScreenSize.height / 6,
                              width: ScreenSize.width / 6,
                              padding: EdgeInsets.all(1),
                              constraints:
                                  BoxConstraints(minWidth: 20, minHeight: 20),
                              child: Center(
                                child: Text(
                                  cat["name"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
           /* SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("Friends")],
            )*/
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
