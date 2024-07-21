// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_folders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFolders _$GetFoldersFromJson(Map<String, dynamic> json) => GetFolders(
      json['listId'] as int?,
      json['listName'] as String?,
      json['announceCount'] as int?,
    );

Map<String, dynamic> _$GetFoldersToJson(GetFolders instance) =>
    <String, dynamic>{
      'listId': instance.listId,
      'listName': instance.listName,
      'announceCount': instance.announceCount,
    };
