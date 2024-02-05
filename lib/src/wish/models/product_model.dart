import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final String userId;
  final String id;
  final String name;
  final String url;
  final List<String> photos;
  final String company;
  final double startPrice;
  final double desiredPrice;
  final bool tracker;
  final String description;
  final List prices;
  final String createdAt;
  final String updatedAt;
  Product({
    required this.userId,
    required this.id,
    required this.name,
    required this.url,
    required this.photos,
    required this.company,
    required this.startPrice,
    required this.desiredPrice,
    required this.tracker,
    required this.description,
    required this.prices,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    String? userId,
    String? id,
    String? name,
    String? url,
    List<String>? photos,
    String? company,
    double? startPrice,
    double? desiredPrice,
    bool? tracker,
    String? description,
    List? prices,
    String? createdAt,
    String? updatedAt,
  }) {
    return Product(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      photos: photos ?? this.photos,
      company: company ?? this.company,
      startPrice: startPrice ?? this.startPrice,
      desiredPrice: desiredPrice ?? this.desiredPrice,
      tracker: tracker ?? this.tracker,
      description: description ?? this.description,
      prices: prices ?? this.prices,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      userId: map['user_id'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
      photos: List<String>.from(map['photos'] as List<String>),
      company: map['company'] as String,
      startPrice: map['start_price'] as double,
      desiredPrice: map['desiredPrice'] as double,
      tracker: map['tracker'] as bool,
      description: map['description'] as String,
      prices: List.from(map['prices'] as List),
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'id': id,
      'name': name,
      'url': url,
      'photos': photos,
      'company': company,
      'start_price': startPrice,
      'desiredPrice': desiredPrice,
      'tracker': tracker,
      'description': description,
      'prices': prices,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(userId: $userId, id: $id, name: $name, url: $url, photos: $photos, company: $company, startPrice: $startPrice, desiredPrice: $desiredPrice, tracker: $tracker, description: $description, prices: $prices, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.id == id &&
        other.name == name &&
        other.url == url &&
        listEquals(other.photos, photos) &&
        other.company == company &&
        other.startPrice == startPrice &&
        other.desiredPrice == desiredPrice &&
        other.tracker == tracker &&
        other.description == description &&
        listEquals(other.prices, prices) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        url.hashCode ^
        photos.hashCode ^
        company.hashCode ^
        startPrice.hashCode ^
        desiredPrice.hashCode ^
        tracker.hashCode ^
        description.hashCode ^
        prices.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
