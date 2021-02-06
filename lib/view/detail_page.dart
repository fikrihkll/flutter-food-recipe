import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/database/dbhelper.dart';
import 'package:first_flutter_app/meal_model.dart';
import 'package:first_flutter_app/model/meal_db_model.dart';

class StartDetailMeal extends StatelessWidget {
  final String id;
  final int indx;
  final String pic;

  StartDetailMeal({Key key, this.id, this.indx, this.pic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailMeal(id,indx,pic);
  }
}

class DetailMeal extends StatefulWidget {
  final String id;
  final int indx;
  final String pic;

  DetailMeal(this.id, this.indx, this.pic);

  @override
  _DetailMealState createState() => _DetailMealState();
}

class _DetailMealState extends State<DetailMeal> {

  bool vis1 = true;
  bool saved=false;
  bool loaded=false;
  bool checked=false;
  MealDBModel savedData;
  IconData ic = Icons.add;
  List<MealDBModel> dataFav=[];
  List<MealDetail> data = [
    MealDetail(id: "0", name: "", pict: "", ingridient: "")
  ];

  @override
  void initState() {
    saveDataCheck();
    loadData();
  }

  void saveDataCheck() async {
    // ignore: missing_return
    await DBHelper().getMeal().then((value){
        dataFav=value;
        print(dataFav.length.toString());
        for(int i=0;i<dataFav.length;i++){
          if(dataFav[i].uid == widget.id){
            saved=true;
            ic=Icons.delete;
            savedData=dataFav[i];
            setState(() {

            });
          }
        }
        checked=true;
    });

  }
  void loadData() {
    print("GDFRT... STARTED");
    MealDetail.getMealDetail(widget.id).then((meals) {
      loaded=true;
      data = meals;
      vis1 = false;
      print("GDFRT... LOADED");
      setState(() {});
    });
  }
  Future saveData() async {
    if(loaded&& checked){
      var now = DateTime.now();
      var db = DBHelper();

      var dataS =
      MealDBModel(data[0].name, data[0].pict, data[0].id, now.toString());

      await db.saveNote(dataS);
      saved=true;
      ic = Icons.delete;
      setState(() {

      });

      print("saved");
    }
  }
  void removeData(MealDBModel mealFav){
    var db = DBHelper();
    db.deleteMeal(mealFav);
    saved=false;
    ic = Icons.add;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Detail Bahan Makanan'),
            actions: <Widget>[
              IconButton(
                key: Key("Favbutton"),
                icon: Icon(
                  ic,
                  color: Colors.white,
                ),
                onPressed: () {
                  if(saved){
                    removeData(savedData);
                  }else{
                    saveData();
                  }
                },
              )
            ],
            leading: IconButton(
              key: Key("btnBackDetail"),
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Hero(
                      key: Key("imageDetail"),
                      tag: "dugong${widget.indx}",
                      child: Image.network(widget.pic, fit: BoxFit.cover),
                    ),
                  ),
                  Center(
                    child: Visibility(
                        maintainAnimation: vis1,
                        maintainState: vis1,
                        visible: vis1,
                        child: Container(child: CircularProgressIndicator())),
                  ),
                  Text(data[0].name,style: TextStyle(fontSize: 24)),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 50,top: 25),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("Ingridients :", style: TextStyle(fontSize: 20,color: Colors.black54),key: Key("ingri"),),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(data[0].ingridient, style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ])));
  }
}