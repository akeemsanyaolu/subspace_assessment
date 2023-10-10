// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BlogDao? _blogDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `blog` (`id` TEXT, `imageUrl` TEXT, `title` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BlogDao get blogDao {
    return _blogDaoInstance ??= _$BlogDao(database, changeListener);
  }
}

class _$BlogDao extends BlogDao {
  _$BlogDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _blogModelInsertionAdapter = InsertionAdapter(
            database,
            'blog',
            (BlogModel item) => <String, Object?>{
                  'id': item.id,
                  'imageUrl': item.imageUrl,
                  'title': item.title
                }),
        _blogModelDeletionAdapter = DeletionAdapter(
            database,
            'blog',
            ['id'],
            (BlogModel item) => <String, Object?>{
                  'id': item.id,
                  'imageUrl': item.imageUrl,
                  'title': item.title
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BlogModel> _blogModelInsertionAdapter;

  final DeletionAdapter<BlogModel> _blogModelDeletionAdapter;

  @override
  Future<List<BlogModel>> getBlogs() async {
    return _queryAdapter.queryList('SELECT * FROM blog',
        mapper: (Map<String, Object?> row) => BlogModel(
            id: row['id'] as String?,
            imageUrl: row['imageUrl'] as String?,
            title: row['title'] as String?));
  }

  @override
  Future<void> insertBlog(BlogModel blog) async {
    await _blogModelInsertionAdapter.insert(blog, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBlog(BlogModel blogModel) async {
    await _blogModelDeletionAdapter.delete(blogModel);
  }
}
