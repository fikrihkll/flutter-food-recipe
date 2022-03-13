const String PRODUCT_TYPE = 'PRODUCT_';
const String STORE_TYPE = 'STORE_';
const String SHOW_STORES = 'SHOW STORES';
const String SHOW_PRODUCTS = 'SHOW PRODUCTS';
const String EMPTY = 'PLEASE SELECT AN OPTION ABOVE';

String getStringKeyForListItem(String type, int index) {
return type + index.toString();
}