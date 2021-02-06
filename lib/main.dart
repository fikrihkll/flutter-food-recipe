import 'package:first_flutter_app/meal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/view/detail_page.dart';
import 'package:first_flutter_app/view/list_fav.dart';
import 'package:first_flutter_app/view/search_page.dart';
import 'config.dart';
import 'package:flutter/widgets.dart';


void main() => runApp(TabBarTest2());

class TabBarTest2 extends StatefulWidget {
  @override
  _TabBarTestState2 createState() => _TabBarTestState2();
}

class _TabBarTestState2 extends State<TabBarTest2> {

  List<Meal> listDesert = [];
  List<Meal> listBreakfast = [];

  String stat="loading";
  bool vis1 = true;
  bool vis2 = true;

  List<String> itPict = [];
  List<String> it=[];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context)=> DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(leading: Config.appIcon,
              title: Text(Config.appString),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    key: Key("TabDes"),
                    text: "Desert",
                    icon: Icon(Icons.restaurant_menu),
                  ),
                  Tab(
                    key: Key("TabSea"),
                    text: "Seafood",
                    icon: Icon(Icons.free_breakfast),
                  )
                ],
              ),
              actions: <Widget>[
                IconButton(
                  key: Key('search'),
                  icon: Icon(Icons.search),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartSearchPage()
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  key: Key('fav'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartAppFav()
                      ),
                    );
                  },
                )
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: Visibility(
                          maintainSize: vis1,
                          maintainAnimation: vis1,
                          maintainState: vis1,
                          visible: vis1,
                          child: CircularProgressIndicator()),
                    ),
                    GridView.builder(
                        key: Key("field"),
                        itemCount: listDesert.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Card(
                              key: Key("item$index"),
                              child:
                              Column(
                                children: <Widget>[
                                  Hero(
                                    tag: "dugong$index",
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,

                                            spreadRadius: 35.0,
                                            // has the effect of extending the shadow
                                            offset: Offset(
                                              20.0,
                                              // horizontal, move right 10
                                              20.0, // vertical, move down 10
                                            ),
                                          )
                                        ],
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 3.0),
                                      child: Image.network(
                                        listDesert[index].pict,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text("${listDesert[index].name}"),
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartDetailMeal(
                                    id: listDesert[index].id,
                                    indx: index,
                                    pic: listDesert[index].pict,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: vis2,
                          child: Container(
                              margin: EdgeInsets.only(top: 50, bottom: 30),
                              child: CircularProgressIndicator())),
                    ),
                    GridView.builder(
                        itemCount: listBreakfast.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Card(
                              color: Colors.white,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: "dugong$index",
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5.0,

                                              spreadRadius: 35.0,
                                              // has the effect of extending the shadow
                                              offset: Offset(
                                                20.0,
                                                // horizontal, move right 10
                                                20.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 3.0),
                                        child: Image.network(
                                          listBreakfast[index].pict,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(listBreakfast[index].name,
                                        maxLines : 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartDetailMeal(
                                    id: listBreakfast[index].id,
                                    indx: index,
                                    pic: listBreakfast[index].pict,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ],
                )

              ],
            ),
          ),
        ),
      )
    );
  }

  void tapped(){
    print("CONGRATULATION!");
  }
  void loadData() {
    Meal.getMeal("Dessert").then((meals) {
      for (int i = 0; i < meals.length; i++) {
        listDesert.add(
            Meal(name: meals[i].name, id: meals[i].id, pict: meals[i].pict));
      }
      vis1 = false;
      stat="loaded";
      setState(() {});
    });

    Meal.getMeal("Seafood").then((meals) {
      for (int i = 0; i < meals.length; i++) {
        listBreakfast.add(
            Meal(name: meals[i].name, id: meals[i].id, pict: meals[i].pict));
      }
      vis2 = false;
      setState(() {});
    });
  }

  @override
  void initState() {
     loadData();
  }
}



