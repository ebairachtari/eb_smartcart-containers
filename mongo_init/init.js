db = db.getSiblingDB('smartcart_db');

db.users.drop();
db.products.drop();
db.categories.drop();
db.carts.drop();
db.cart_items.drop();

db.users.insertMany(require('/docker-entrypoint-initdb.d/smartcart_db.users.json'));
db.products.insertMany(require('/docker-entrypoint-initdb.d/smartcart_db.products.json'));
db.categories.insertMany(require('/docker-entrypoint-initdb.d/smartcart_db.categories.json'));
db.carts.insertMany(require('/docker-entrypoint-initdb.d/smartcart_db.carts.json'));
db.cart_items.insertMany(require('/docker-entrypoint-initdb.d/smartcart_db.cart_items.json'));

