// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wishlist _$WishlistFromJson(Map<String, dynamic> json) => Wishlist(
      id: json['id'] as int?,
      propertyType: json['propertyType'] as String?,
      cover: json['cover'] as String?,
      price: json['price'] as int?,
      space: json['space'] as String?,
      roomCount: json['roomCount'] as int?,
      address: json['address'] as String?,
      isRieltorAnnounce: json['isRieltorAnnounce'] as bool?,
      isInAnyFolders: json['isInAnyFolders'] as bool?,
      announceDate: json['announceDate'] as String?,
    );

Map<String, dynamic> _$WishlistToJson(Wishlist instance) => <String, dynamic>{
      'id': instance.id,
      'propertyType': instance.propertyType,
      'cover': instance.cover,
      'price': instance.price,
      'space': instance.space,
      'roomCount': instance.roomCount,
      'address': instance.address,
      'isRieltorAnnounce': instance.isRieltorAnnounce,
      'isInAnyFolders': instance.isInAnyFolders,
      'announceDate': instance.announceDate,
    };
