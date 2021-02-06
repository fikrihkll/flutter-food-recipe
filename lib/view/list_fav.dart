import 'package:first_flutter_app/database/dbhelper.dart';
import 'package:first_flutter_app/view/detail_page.dart';
import 'package:first_flutter_app/model/meal_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartAppFav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foodies",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text('List Fav'),
        ),
      ),
      body: FutureBuilder(
        future: db.getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          return snapshot.hasData
              ? ListFavMealPage(data)
              : Center(
            child: Text("No Data"),
          );
        },
      ),
    );
  }
}

class ListFavMealPage extends StatefulWidget {

  final List<MealDBModel> mealdata;

  ListFavMealPage(this.mealdata, {Key key});

  @override
  _ListFavMealPageState createState() => _ListFavMealPageState();
}

class _ListFavMealPageState extends State<ListFavMealPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 2
                : 3),
        itemCount: widget.mealdata.length == null ? 0 : widget.mealdata.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            child: Card(
              key: Key("favitem$index"),
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
                          widget.mealdata[index].picture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      widget.mealdata[index].name,
                      maxLines : 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartDetailMeal(
                    id: widget.mealdata[index].uid,
                    indx: index,
                    pic: widget.mealdata[index].picture,
                  ),
                ),
              );
            },
          );
        });
  }
}
