import 'package:flutter/material.dart';
import 'package:learnify/models/comment_model.dart';
import 'package:learnify/utils/size_config.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;
  final bool isInternal;

  const CommentItem({
    super.key,
    required this.comment,
    required this.isInternal,
  });

  @override
  CommentItemState createState() => CommentItemState();
}

class CommentItemState extends State<CommentItem>
    with SingleTickerProviderStateMixin {
  SizeConfig sizeConfig = SizeConfig();
  bool showReplyInput = false;
  final Duration _animationDuration = const Duration(milliseconds: 500);
  TextEditingController replyController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);

    return Container(
      margin: widget.isInternal
          ? const EdgeInsets.only(left: 40, top: 10, bottom: 10)
          : const EdgeInsets.only(left: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: widget.comment.user!.photo,
            radius: 20,
            backgroundColor: Colors.white,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "${widget.comment.user!.lastname} ${widget.comment.user!.firstname}.",
                    style: TextStyle(
                      fontSize: sizeConfig.blockSizeVertical * 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: Text(
                    widget.comment.comment!,
                    style: TextStyle(
                      fontSize: sizeConfig.blockSizeVertical,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.comment.pubDate.toString(),
                      style: TextStyle(
                        color: const Color.fromRGBO(170, 170, 170, 1),
                        fontSize: sizeConfig.blockSizeVertical,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        "Reply",
                        style: TextStyle(
                          fontSize: sizeConfig.blockSizeVertical,
                          color: const Color.fromARGB(255, 44, 105, 141),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showReplyInput = !showReplyInput;
                          if (showReplyInput) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        });
                      },
                    ),
                  ],
                ),
                if (showReplyInput)
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, -1.0), // Slide from the top
                      end: const Offset(0.0, 0.0), // To the natural position
                    ).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeOut,
                      reverseCurve: Curves.easeIn,
                    )),
                    child: TextField(
                      style: TextStyle(
                        fontSize: sizeConfig.blockSizeVertical * 1.1,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.send)),
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1),
                        ),
                        hintText: 'Write a reply...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
