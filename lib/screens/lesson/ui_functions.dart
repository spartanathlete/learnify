part of lesson_screen;

Widget buildCommentsSection({
  required SizeConfig config,
  required ThemeProvider themeProvider,
  required DashboardController controller,
  required TextEditingController commentController,
  required String lessonID,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10),
        child: Text(
          "Comments",
          style: TextStyle(
            color: (themeProvider.isDarkTheme)
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color(0xFF262628),
            fontSize: config.blockSizeVertical * 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Divider(
        height: 2,
      ),
      Padding(
        padding: EdgeInsets.only(
          left: config.blockSizeVertical * 5,
          bottom: config.blockSizeVertical * 5,
          right: config.blockSizeVertical * 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: renderComment(
                comments: controller.getComments(lessonID: lessonID),
                controller: controller,
                lessonID: lessonID,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: commentController,
                // cursorColor: Colors.black,
                maxLines: 7,
                minLines: 5,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: config.blockSizeVertical * 1.3,
                ),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(170, 170, 170, 1),
                  ),
                  hintText: "Write a reply...",
                  suffixIcon: IconButton(
                    icon:
                        const Icon(Icons.send), // You can use any icon you want
                    onPressed: () {
                      controller.addComment(
                        lessonID: lessonID,
                        comment: CommentModel(
                          comment: commentController.text,
                          pubDate: DateTime.now().toString(),
                        ),
                      );
                      commentController.clear();
                    },
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 44, 105, 141),
                      width: 1,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 35, 85, 110),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

renderInternalComment({
  required BuildContext context,
  required List comments,
  required DashboardController controller,
  required String lessonID,
}) {
  return Column(
    children: comments
        .map((comment) => CommentItem(
              lessonID: lessonID,
              comment: comment,
              isInternal: true,
              controller: controller,
            ))
        .toList(),
  );
}

Widget renderComment({
  required Stream<List<CommentModel>> comments,
  required DashboardController controller,
  required String lessonID,
}) {
  return StreamBuilder<List<CommentModel>>(
    stream: comments,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!.isNotEmpty) {
          return ListView.separated(
            separatorBuilder: (
              BuildContext context,
              int index,
            ) =>
                const Divider(),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  CommentItem(
                    lessonID: lessonID,
                    comment: snapshot.data![index],
                    isInternal: false,
                    controller: controller,
                  ),
                  // snapshot.data![index].replies!.isNotEmpty
                  //     ? renderInternalComment(
                  //         lessonID: lessonID,
                  //         context: context,
                  //         comments: snapshot.data![index].replies!,
                  //         controller: controller,
                  //       )
                  //     : Container(),
                ],
              );
            },
          );
        } else {
          return const Center(
            child: Text('Be the first to comment ;)'),
          );
        }
      } else if (snapshot.hasError) {
        const Center(
          child: Text('Error has been occured! Refresh the page please.'),
        );
      } else {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
      return const Center(
        child: Text('Unhandled error!'),
      );
    },
  );
}

Widget buildLessonOverview({
  required List<LessonModel> data,
  int crossAxisCount = 6,
  int crossAxisCellCount = 2,
  Axis headerAxis = Axis.horizontal,
  required ThemeProvider themeProvider,
}) {
  return StaggeredGridView.countBuilder(
    crossAxisCount: crossAxisCount,
    itemCount: data.length + 1,
    addAutomaticKeepAlives: false,
    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return (index == 0)
          ? Padding(
              padding: const EdgeInsets.only(bottom: kSpacing),
              child: OverviewHeader(
                themeProvider: themeProvider,
                axis: headerAxis,
                onSelected: (task) {},
              ),
            )
          : LessonCard(
              themeProvider: themeProvider,
              data: data[index - 1],
              // onPressedMore: () {},
              onPressedTask: () {},
              onPressedExercise: () {},
              onPressedPursue: () {},
            );
    },
    staggeredTileBuilder: (int index) =>
        StaggeredTile.fit((index == 0) ? crossAxisCount : crossAxisCellCount),
  );
}

Widget _buildLessonChapters({
  required Stream<List<LessonChapModel>> data,
  required SectionProvider sectionProvider,
  required ThemeProvider themeProvider,
  int crossAxisCount = 2,
  int crossAxisCellCount = 2,
  required SizeConfig sizeConfig,
  required BuildContext context,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: SideList(
          title: 'CHANGEME BALEASE',
          onPressedMore: () {},
          themeProvider: themeProvider,
        ),
      ),
      const SizedBox(height: kSpacing / 2),
      StreamBuilder<List<LessonChapModel>>(
        stream: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: crossAxisCount,
              itemCount: snapshot.data!.length,
              addAutomaticKeepAlives: false,
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return LessonChapterCard(
                  data: snapshot.data![index],
                  onPressed: () {},
                  isDone: true,
                  themeProvider: themeProvider,
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(
                  (index == 0) ? crossAxisCount : crossAxisCellCount),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // ...data
      //     .map(
      //       (e) => LessonChapterCard(
      //         data: e,
      //         onPressed: () {},
      //         isDone: true,
      //         themeProvider: themeProvider,
      //       ),
      //     )
      //     .where((e) => e.data.beginAt <= sectionProvider.sliderValue)
      //     .toList(),
    ],
  );
}
