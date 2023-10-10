import 'package:floor/floor.dart';
import 'package:subspace/features/blog/data/data_sources/local/DAO/blog_dao.dart';
import 'package:subspace/features/blog/data/models/blog.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [BlogModel])
abstract class AppDatabase extends FloorDatabase {
  BlogDao get blogDao;
}
