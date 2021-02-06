import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Home Screen Test', () {
    final btn = find.byValueKey('field');
    final field = find.byValueKey('item3');

    final btnSearch = find.byValueKey('search');
    final searchBar = find.byValueKey('searchBar');
    final btnGoSearch = find.byValueKey('searchButton');
    final ingridient = find.byValueKey('ingri');
    final searchListItem = find.byValueKey('searchitem1');
    final imageDetail = find.byValueKey('imageDetail');
    final btnFav = find.byValueKey('Favbutton');
    final btnBackDetail = find.byValueKey('btnBackDetail');
    final btnFavHome = find.byValueKey('fav');
    final favitem = find.byValueKey('favitem0');
    final btnSearchBack = find.byValueKey('searchBack');

    FlutterDriver driver;
    setUpAll(() async {

      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {

        driver.close();
      }
    });

    test("widget is available", () async {
      await Future.delayed(Duration(seconds: 8));
      await driver.waitFor(btn);
      await driver.waitFor(field);

    });

    test("tap item", () async {
      await driver.tap(field);
      await driver.waitFor(ingridient);
      await driver.tap(btnFav);
      await Future.delayed(Duration(seconds: 4));
      await driver.tap(btnBackDetail);
    });

    test("tap search btn", () async {
      await driver.waitFor(btnSearch);
      await driver.tap(btnSearch);
      await driver.waitFor(searchBar);
      await driver.tap(searchBar);
      await driver.enterText("Cheese");
      await driver.tap(btnGoSearch);
      await Future.delayed(Duration(seconds: 4));
      await driver.waitFor(searchListItem);
      await driver.tap(searchListItem);
    });

    test("tap item", () async {
      await driver.waitFor(ingridient);
      await driver.tap(btnFav);
      await Future.delayed(Duration(seconds: 4));
      await driver.tap(btnBackDetail);
    });

    test("back search", () async {
      await driver.waitFor(btnSearchBack);
      await driver.tap(btnSearchBack);
    });

    test("back home", () async {
      await driver.waitFor(btnFavHome);
      await driver.tap(btnFavHome);
    });


    test("tap a Fav", () async {
      await driver.waitFor(favitem);
      await driver.tap(favitem);
    });

    test("tap item", () async {
      await driver.waitFor(ingridient);
      await driver.tap(btnFav);
      await Future.delayed(Duration(seconds: 4));
      await driver.tap(btnBackDetail);
    });
  });
}