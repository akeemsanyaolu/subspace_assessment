import 'package:floor/floor.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';

@Entity(tableName: 'blog', primaryKeys: ['id'])
class BlogModel extends BlogEntity {
  const BlogModel({
    String? id,
    String? imageUrl,
    String? title,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          title: title,
        );
  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'] ?? "",
        imageUrl: map['image_url'],
        title: map['title'] ?? '');
  }

  factory BlogModel.fromEntity(BlogEntity entity) {
    return BlogModel(
      id: entity.id,
      imageUrl: entity.imageUrl,
      title: entity.title,
    );
  }
}
