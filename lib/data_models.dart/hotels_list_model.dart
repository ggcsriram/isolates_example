// To parse this JSON data, do
//
//     final hotelListModel = hotelListModelFromJson(jsonString);

import 'dart:convert';

HotelListModel hotelListModelFromJson(String str) => HotelListModel.fromJson(json.decode(str));

String hotelListModelToJson(HotelListModel data) => json.encode(data.toJson());

class HotelListModel {
    List<HotelsList> hotelsList;
    String message;
    String status;

    HotelListModel({
        this.hotelsList,
        this.message,
        this.status,
    });

    factory HotelListModel.fromJson(Map<String, dynamic> json) => HotelListModel(
        hotelsList: List<HotelsList>.from(json["hotels_list"].map((x) => HotelsList.fromJson(x))),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "hotels_list": List<dynamic>.from(hotelsList.map((x) => x.toJson())),
        "message": message,
        "status": status,
    };
}

class HotelsList {
    String hotelId;
    String restaurantName;
    String locationId;
    String imagePath;
    DateTime createdDate;
    String modifiedBy;
    DateTime modifiedDate;
    String startTime;
    String endTime;

    HotelsList({
        this.hotelId,
        this.restaurantName,
        this.locationId,
        this.imagePath,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.startTime,
        this.endTime,
    });

    factory HotelsList.fromJson(Map<String, dynamic> json) => HotelsList(
        hotelId: json["hotelId"],
        restaurantName: json["restaurantName"],
        locationId: json["locationId"],
        imagePath: json["imagePath"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedBy: json["modifiedBy"],
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "hotelId": hotelId,
        "restaurantName": restaurantName,
        "locationId": locationId,
        "imagePath": imagePath,
        "createdDate": createdDate.toIso8601String(),
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate.toIso8601String(),
        "startTime": startTime,
        "endTime": endTime,
    };
}
