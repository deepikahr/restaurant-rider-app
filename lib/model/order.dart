class OrderData {
  OrderData({
    this.responseCode,
    this.responseData,
  });

  int responseCode;
  ResponseData responseData;

  factory OrderData.fromMap(Map<String, dynamic> json) => OrderData(
        responseCode:
            json["response_code"] == null ? null : json["response_code"],
        responseData: json["response_data"] == null
            ? null
            : ResponseData.fromMap(json["response_data"]),
      );

  Map<String, dynamic> toMap() => {
        "response_code": responseCode == null ? null : responseCode,
        "response_data": responseData == null ? null : responseData.toMap(),
      };
}

class ResponseData {
  ResponseData({
    this.data,
    this.message,
  });

  List<OrderDetail> data;
  String message;

  factory ResponseData.fromMap(Map<String, dynamic> json) => ResponseData(
        data: json["data"] == null
            ? null
            : List<OrderDetail>.from(
                json["data"].map((x) => OrderDetail.fromMap(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message == null ? null : message,
      };
}

class OrderDetail {
  OrderDetail({
    this.payment,
    this.userInfo,
    this.productDetails,
    this.isForDineIn,
    this.note,
    this.tableNumber,
    this.productRating,
    this.assigned,
    this.userNotification,
    this.paymentStatus,
    this.status,
    this.orderUpdatedCount,
    this.updatedTotalAmount,
    this.id,
    this.deliveryCharge,
    this.grandTotal,
    this.location,
    this.locationName,
    this.orderType,
    this.payableAmount,
    this.paymentOption,
    this.position,
    this.shippingAddress,
    this.restaurantId,
    this.subTotal,
    this.pickupDate,
    this.pickupTime,
    this.coupon,
    this.taxPayer,
    this.createdAtTime,
    this.paymentMethodId,
    this.createdAt,
    this.date,
    this.month,
    this.year,
    this.day,
    this.user,
    this.pickupStamp,
    this.charges,
    this.orderId,
    this.v,
    this.updatedAt,
    this.assignedDate,
    this.deliveryBy,
    this.deliveryByName,
    this.loyalty,
    this.taxInfo,
  });

  Payment payment;
  UserInfo userInfo;
  List<ProductDetail> productDetails;
  bool isForDineIn;
  dynamic note;
  dynamic tableNumber;
  List<dynamic> productRating;
  bool assigned;
  List<UserNotification> userNotification;
  String paymentStatus;
  String status;
  int orderUpdatedCount;
  dynamic updatedTotalAmount;
  String id;
  String deliveryCharge;
  int grandTotal;
  DatumLocation location;
  String locationName;
  String orderType;
  int payableAmount;
  String paymentOption;
  Position position;
  ShippingAddress shippingAddress;
  String restaurantId;
  int subTotal;
  String pickupDate;
  String pickupTime;
  Coupon coupon;
  TaxPayer taxPayer;
  int createdAtTime;
  dynamic paymentMethodId;
  DateTime createdAt;
  int date;
  int month;
  int year;
  int day;
  String user;
  int pickupStamp;
  int charges;
  int orderId;
  int v;
  DateTime updatedAt;
  DateTime assignedDate;
  String deliveryBy;
  String deliveryByName;
  int loyalty;
  TaxInfo taxInfo;

  factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
        payment:
            json["payment"] == null ? null : Payment.fromMap(json["payment"]),
        userInfo: json["userInfo"] == null
            ? null
            : UserInfo.fromMap(json["userInfo"]),
        productDetails: json["productDetails"] == null
            ? null
            : List<ProductDetail>.from(
                json["productDetails"].map((x) => ProductDetail.fromMap(x))),
        isForDineIn: json["isForDineIn"] == null ? null : json["isForDineIn"],
        note: json["note"],
        tableNumber: json["tableNumber"],
        productRating: json["productRating"] == null
            ? null
            : List<dynamic>.from(json["productRating"].map((x) => x)),
        assigned: json["assigned"] == null ? null : json["assigned"],
        userNotification: json["userNotification"] == null
            ? null
            : List<UserNotification>.from(json["userNotification"]
                .map((x) => UserNotification.fromMap(x))),
        paymentStatus:
            json["paymentStatus"] == null ? null : json["paymentStatus"],
        status: json["status"] == null ? null : json["status"],
        orderUpdatedCount: json["orderUpdatedCount"] == null
            ? null
            : json["orderUpdatedCount"],
        updatedTotalAmount: json["updatedTotalAmount"],
        id: json["_id"] == null ? null : json["_id"],
        deliveryCharge:
            json["deliveryCharge"] == null ? null : json["deliveryCharge"],
        grandTotal: json["grandTotal"] == null ? null : json["grandTotal"],
        location: json["location"] == null
            ? null
            : DatumLocation.fromMap(json["location"]),
        locationName:
            json["locationName"] == null ? null : json["locationName"],
        orderType: json["orderType"] == null ? null : json["orderType"],
        payableAmount:
            json["payableAmount"] == null ? null : json["payableAmount"],
        paymentOption:
            json["paymentOption"] == null ? null : json["paymentOption"],
        position: json["position"] == null
            ? null
            : Position.fromMap(json["position"]),
        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromMap(json["shippingAddress"]),
        restaurantId:
            json["restaurantID"] == null ? null : json["restaurantID"],
        subTotal: json["subTotal"] == null ? null : json["subTotal"],
        pickupDate: json["pickupDate"] == null ? null : json["pickupDate"],
        pickupTime: json["pickupTime"] == null ? null : json["pickupTime"],
        coupon: json["coupon"] == null ? null : Coupon.fromMap(json["coupon"]),
        taxPayer: json["taxPayer"] == null
            ? null
            : TaxPayer.fromMap(json["taxPayer"]),
        createdAtTime:
            json["createdAtTime"] == null ? null : json["createdAtTime"],
        paymentMethodId: json["paymentMethodId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        date: json["date"] == null ? null : json["date"],
        month: json["month"] == null ? null : json["month"],
        year: json["year"] == null ? null : json["year"],
        day: json["day"] == null ? null : json["day"],
        user: json["user"] == null ? null : json["user"],
        pickupStamp: json["pickupStamp"] == null ? null : json["pickupStamp"],
        charges: json["charges"] == null ? null : json["charges"],
        orderId: json["orderID"] == null ? null : json["orderID"],
        v: json["__v"] == null ? null : json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        assignedDate: json["assignedDate"] == null
            ? null
            : DateTime.parse(json["assignedDate"]),
        deliveryBy: json["deliveryBy"] == null ? null : json["deliveryBy"],
        deliveryByName:
            json["deliveryByName"] == null ? null : json["deliveryByName"],
        loyalty: json["loyalty"] == null ? null : json["loyalty"],
        taxInfo:
            json["taxInfo"] == null ? null : TaxInfo.fromMap(json["taxInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "payment": payment == null ? null : payment.toMap(),
        "userInfo": userInfo == null ? null : userInfo.toMap(),
        "productDetails": productDetails == null
            ? null
            : List<dynamic>.from(productDetails.map((x) => x.toMap())),
        "isForDineIn": isForDineIn == null ? null : isForDineIn,
        "note": note,
        "tableNumber": tableNumber,
        "productRating": productRating == null
            ? null
            : List<dynamic>.from(productRating.map((x) => x)),
        "assigned": assigned == null ? null : assigned,
        "userNotification": userNotification == null
            ? null
            : List<dynamic>.from(userNotification.map((x) => x.toMap())),
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
        "status": status == null ? null : status,
        "orderUpdatedCount":
            orderUpdatedCount == null ? null : orderUpdatedCount,
        "updatedTotalAmount": updatedTotalAmount,
        "_id": id == null ? null : id,
        "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
        "grandTotal": grandTotal == null ? null : grandTotal,
        "location": location == null ? null : location.toMap(),
        "locationName": locationName == null ? null : locationName,
        "orderType": orderType == null ? null : orderType,
        "payableAmount": payableAmount == null ? null : payableAmount,
        "paymentOption": paymentOption == null ? null : paymentOption,
        "position": position == null ? null : position.toMap(),
        "shippingAddress":
            shippingAddress == null ? null : shippingAddress.toMap(),
        "restaurantID": restaurantId == null ? null : restaurantId,
        "subTotal": subTotal == null ? null : subTotal,
        "pickupDate": pickupDate == null ? null : pickupDate,
        "pickupTime": pickupTime == null ? null : pickupTime,
        "coupon": coupon == null ? null : coupon.toMap(),
        "taxPayer": taxPayer == null ? null : taxPayer.toMap(),
        "createdAtTime": createdAtTime == null ? null : createdAtTime,
        "paymentMethodId": paymentMethodId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "date": date == null ? null : date,
        "month": month == null ? null : month,
        "year": year == null ? null : year,
        "day": day == null ? null : day,
        "user": user == null ? null : user,
        "pickupStamp": pickupStamp == null ? null : pickupStamp,
        "charges": charges == null ? null : charges,
        "orderID": orderId == null ? null : orderId,
        "__v": v == null ? null : v,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "assignedDate":
            assignedDate == null ? null : assignedDate.toIso8601String(),
        "deliveryBy": deliveryBy == null ? null : deliveryBy,
        "deliveryByName": deliveryByName == null ? null : deliveryByName,
        "loyalty": loyalty == null ? null : loyalty,
        "taxInfo": taxInfo == null ? null : taxInfo.toMap(),
      };
}

class Coupon {
  Coupon({
    this.couponApplied,
  });

  bool couponApplied;

  factory Coupon.fromMap(Map<String, dynamic> json) => Coupon(
        couponApplied:
            json["couponApplied"] == null ? null : json["couponApplied"],
      );

  Map<String, dynamic> toMap() => {
        "couponApplied": couponApplied == null ? null : couponApplied,
      };
}

class DatumLocation {
  DatumLocation({
    this.id,
    this.latitude,
    this.longitude,
  });

  String id;
  double latitude;
  double longitude;

  factory DatumLocation.fromMap(Map<String, dynamic> json) => DatumLocation(
        id: json["_id"] == null ? null : json["_id"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}

class Payment {
  Payment({
    this.paymentStatus,
  });

  bool paymentStatus;

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        paymentStatus:
            json["paymentStatus"] == null ? null : json["paymentStatus"],
      );

  Map<String, dynamic> toMap() => {
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
      };
}

class Position {
  Position({
    this.lat,
    this.long,
    this.name,
  });

  double lat;
  double long;
  String name;

  factory Position.fromMap(Map<String, dynamic> json) => Position(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        long: json["long"] == null ? null : json["long"].toDouble(),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "name": name == null ? null : name,
      };
}

class ProductDetail {
  ProductDetail({
    this.discount,
    this.mrp,
    this.note,
    this.quantity,
    this.price,
    this.extraIngredients,
    this.imageUrl,
    this.productId,
    this.flavour,
    this.size,
    this.title,
    this.restaurant,
    this.restaurantId,
    this.totalPrice,
    this.restaurantAddress,
  });

  int discount;
  int mrp;
  dynamic note;
  int quantity;
  int price;
  List<ExtraIngredient> extraIngredients;
  String imageUrl;
  String productId;
  List<dynamic> flavour;
  String size;
  String title;
  String restaurant;
  String restaurantId;
  int totalPrice;
  String restaurantAddress;

  factory ProductDetail.fromMap(Map<String, dynamic> json) => ProductDetail(
        discount: json["Discount"] == null ? null : json["Discount"],
        mrp: json["MRP"] == null ? null : json["MRP"],
        note: json["note"],
        quantity: json["Quantity"] == null ? null : json["Quantity"],
        price: json["price"] == null ? null : json["price"],
        extraIngredients: json["extraIngredients"] == null
            ? null
            : List<ExtraIngredient>.from(json["extraIngredients"]
                .map((x) => ExtraIngredient.fromMap(x))),
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        productId: json["productId"] == null ? null : json["productId"],
        flavour: json["flavour"] == null
            ? null
            : List<dynamic>.from(json["flavour"].map((x) => x)),
        size: json["size"] == null ? null : json["size"],
        title: json["title"] == null ? null : json["title"],
        restaurant: json["restaurant"] == null ? null : json["restaurant"],
        restaurantId:
            json["restaurantID"] == null ? null : json["restaurantID"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        restaurantAddress: json["restaurantAddress"] == null
            ? null
            : json["restaurantAddress"],
      );

  Map<String, dynamic> toMap() => {
        "Discount": discount == null ? null : discount,
        "MRP": mrp == null ? null : mrp,
        "note": note,
        "Quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "extraIngredients": extraIngredients == null
            ? null
            : List<dynamic>.from(extraIngredients.map((x) => x.toMap())),
        "imageUrl": imageUrl == null ? null : imageUrl,
        "productId": productId == null ? null : productId,
        "flavour":
            flavour == null ? null : List<dynamic>.from(flavour.map((x) => x)),
        "size": size == null ? null : size,
        "title": title == null ? null : title,
        "restaurant": restaurant == null ? null : restaurant,
        "restaurantID": restaurantId == null ? null : restaurantId,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "restaurantAddress":
            restaurantAddress == null ? null : restaurantAddress,
      };
}

class ExtraIngredient {
  ExtraIngredient({
    this.name,
    this.price,
    this.isSelected,
  });

  String name;
  int price;
  bool isSelected;

  factory ExtraIngredient.fromMap(Map<String, dynamic> json) => ExtraIngredient(
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        isSelected: json["isSelected"] == null ? null : json["isSelected"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "isSelected": isSelected == null ? null : isSelected,
      };
}

class ShippingAddress {
  ShippingAddress({
    this.location,
    this.address,
    this.landmark,
    this.contactNumber,
    this.addressType,
    this.isSelected,
  });

  ShippingAddressLocation location;
  String address;
  String landmark;
  String contactNumber;
  String addressType;
  bool isSelected;

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
        location: json["location"] == null
            ? null
            : ShippingAddressLocation.fromMap(json["location"]),
        address: json["address"] == null ? null : json["address"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        addressType: json["addressType"] == null ? null : json["addressType"],
        isSelected: json["isSelected"] == null ? null : json["isSelected"],
      );

  Map<String, dynamic> toMap() => {
        "location": location == null ? null : location.toMap(),
        "address": address == null ? null : address,
        "landmark": landmark == null ? null : landmark,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "addressType": addressType == null ? null : addressType,
        "isSelected": isSelected == null ? null : isSelected,
      };
}

class ShippingAddressLocation {
  ShippingAddressLocation({
    this.lat,
    this.long,
  });

  double lat;
  double long;

  factory ShippingAddressLocation.fromMap(Map<String, dynamic> json) =>
      ShippingAddressLocation(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        long: json["long"] == null ? null : json["long"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}

class TaxInfo {
  TaxInfo({
    this.taxName,
    this.taxRate,
  });

  String taxName;
  int taxRate;

  factory TaxInfo.fromMap(Map<String, dynamic> json) => TaxInfo(
        taxName: json["taxName"] == null ? null : json["taxName"],
        taxRate: json["taxRate"] == null ? null : json["taxRate"],
      );

  Map<String, dynamic> toMap() => {
        "taxName": taxName == null ? null : taxName,
        "taxRate": taxRate == null ? null : taxRate,
      };
}

class TaxPayer {
  TaxPayer({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory TaxPayer.fromMap(Map<String, dynamic> json) => TaxPayer(
        id: json["ID"] == null ? null : json["ID"],
        name: json["Name"] == null ? null : json["Name"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id == null ? null : id,
        "Name": name == null ? null : name,
      };
}

class UserInfo {
  UserInfo({
    this.firstOrder,
    this.name,
    this.contactNumber,
    this.email,
    this.role,
  });

  bool firstOrder;
  String name;
  int contactNumber;
  String email;
  String role;

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        firstOrder: json["firstOrder"] == null ? null : json["firstOrder"],
        name: json["name"] == null ? null : json["name"],
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        email: json["email"] == null ? null : json["email"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toMap() => {
        "firstOrder": firstOrder == null ? null : firstOrder,
        "name": name == null ? null : name,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "email": email == null ? null : email,
        "role": role == null ? null : role,
      };
}

class UserNotification {
  UserNotification({
    this.status,
    this.time,
  });

  String status;
  int time;

  factory UserNotification.fromMap(Map<String, dynamic> json) =>
      UserNotification(
        status: json["status"] == null ? null : json["status"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "time": time == null ? null : time,
      };
}
