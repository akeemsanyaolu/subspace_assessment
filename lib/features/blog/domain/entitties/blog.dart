import 'package:equatable/equatable.dart';

class BlogEntity extends Equatable {
  final String? id;
  final String? imageUrl;
  final String? title;

  const BlogEntity({
    this.id,
    this.imageUrl,
    this.title,
  });

  @override
  List<Object?> get props {
    return [
      id,
      imageUrl,
      title,
    ];
  }
}
