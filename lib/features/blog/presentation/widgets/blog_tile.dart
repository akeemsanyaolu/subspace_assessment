import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';

class BlogWidget extends StatelessWidget {
  final BlogEntity? blog;
  final bool? isRemovable;
  final void Function(BlogEntity blog)? onRemove;
  final void Function(BlogEntity blog)? onBlogPressed;
  const BlogWidget({
    Key? key,
    this.blog,
    this.isRemovable = false,
    this.onRemove,
    this.onBlogPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 14, end: 14, bottom: 7, top: 7),
        width: MediaQuery.of(context).size.width - 10,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: blog!.imageUrl!,
        imageBuilder: (context, imageProvider) => ClipRRect(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 200,
                  child: CupertinoActivityIndicator(),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: Icon(Icons.error),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            ));
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        //margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: double.infinity,
        //color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              blog!.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (onBlogPressed != null) {
      onBlogPressed!(blog!);
    }
  }
}
