import 'package:first_flutter_app/meal_model.dart';
import 'package:first_flutter_app/view/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchPage();
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final cQuery = TextEditingController();
  List<MealSearch> listSearch = [];
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = new Text(
    "Search Sample",
    style: new TextStyle(color: Colors.white),
  );
  final TextEditingController _searchQuery = new TextEditingController();

  void loadData(String query) {
    MealSearch.getMeal(query).then((meals) {
      for (int i = 0; i < meals.length; i++) {
        listSearch.add(MealSearch(
            name: meals[i].name, id: meals[i].id, pict: meals[i].pict));
      }
      setState(() {});
    });
  }

  void setSearchView(){
    this.actionIcon =  Icon(
      Icons.search,
      color: Colors.white,
    );
    this.appBarTitle =  TextField(
      controller: _searchQuery,
      key: Key('searchBar'),
      style:  TextStyle(
        color: Colors.white,
      ),
      decoration:  InputDecoration(
          hintText: "Search...",
          hintStyle:  TextStyle(color: Colors.white)),
    );
    setState(() {

    });
  }


  @override
  void initState() {
    setSearchView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Search Page",
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: appBarTitle,
            leading: IconButton(
              key: Key('searchBack'),
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context, false);
              },
            ),
            actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            key: Key('searchButton'),
            onPressed: () {
              loadData(_searchQuery.text);
            },
          ),
        ]),
        body: SearchList(listSearch),
      ),
    );
  }
}

class SearchList extends StatefulWidget {
  List<MealSearch> listSearch = [];

  SearchList(this.listSearch);

  @override
  _SearchListState createState() => _SearchListState(listSearch);
}

class _SearchListState extends State<SearchList> {
  List<MealSearch> listSearch = [];

  _SearchListState(this.listSearch);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: Key("searchList"
      ),
        itemCount: listSearch.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
              key: Key("searchitem$index"),
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
                          listSearch[index].pict,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      listSearch[index].name,
                      maxLines: 1,
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
                    id: listSearch[index].id,
                    indx: index,
                    pic: listSearch[index].pict,
                  ),
                ),
              );
            },
          );
        });
  }
}
