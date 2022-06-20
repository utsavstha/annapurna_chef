class OrderModel {
  late String tableName;
  late num orderId;
  late List<Items> items;

  OrderModel(
      {required this.tableName, required this.orderId, required this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json["table_name"] is String) tableName = json["table_name"];
    if (json["order_id"] is num) orderId = json["order_id"];
    if (json["items"] is List)
      items = (json["items"] == null
          ? null
          : (json["items"] as List).map((e) => Items.fromJson(e)).toList())!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["table_name"] = tableName;
    data["order_id"] = orderId;
    if (items != null) data["items"] = items.map((e) => e.toJson()).toList();
    return data;
  }
}

class Items {
  late int id;
  late String name;
  late int price;
  late int foodItemId;
  late int orderId;
  late String createdAt;
  late String updatedAt;
  late int quantity;
  late int isCooked;

  Items(
      {required this.id,
      required this.name,
      required this.price,
      required this.foodItemId,
      required this.orderId,
      required this.createdAt,
      required this.updatedAt,
      required this.quantity,
      required this.isCooked});

  Items.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) id = json["id"];
    if (json["name"] is String) name = json["name"];
    if (json["price"] is int) price = json["price"];
    if (json["food_item_id"] is int) foodItemId = json["food_item_id"];
    if (json["order_id"] is int) orderId = json["order_id"];
    if (json["created_at"] is String) createdAt = json["created_at"];
    if (json["updated_at"] is String) updatedAt = json["updated_at"];
    if (json["quantity"] is int) quantity = json["quantity"];
    if (json["is_cooked"] is int) isCooked = json["is_cooked"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["food_item_id"] = foodItemId;
    data["order_id"] = orderId;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["quantity"] = quantity;
    data["is_cooked"] = isCooked;
    return data;
  }
}
