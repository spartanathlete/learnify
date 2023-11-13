part of lesson_screen;

Widget buildCommentsSection(
  SizeConfig config,
  ThemeProvider themeProvider,
  DashboardController controller,
  TextEditingController commentController,
) {
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
                child: renderComment(controller.getComments())),
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
                    onPressed: () {},
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

renderInternalComment(BuildContext context, List comments) {
  return Column(
    children: comments
        .map((comment) => CommentItem(comment: comment, isInternal: true))
        .toList(),
  );
}

Widget renderComment(List<CommentModel> comments) {
  return ListView.separated(
    separatorBuilder: (BuildContext context, int index) => const Divider(),
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: comments.length,
    itemBuilder: (context, index) {
      return Column(
        children: <Widget>[
          CommentItem(comment: comments[index], isInternal: false),
          comments[index].replies.isNotEmpty
              ? renderInternalComment(
                  context,
                  comments[index].replies,
                )
              : Container(),
        ],
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
  required List<LessonChapterData> data,
  required SectionProvider sectionProvider,
  required ThemeProvider themeProvider,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: SideList(
          title: data[0].name,
          onPressedMore: () {},
          themeProvider: themeProvider,
        ),
      ),
      const SizedBox(height: kSpacing / 2),
      ...data
          .map(
            (e) => LessonChapterCard(
              data: e,
              onPressed: () {},
              isDone: true,
              themeProvider: themeProvider,
            ),
          )
          .where((e) => e.data.beginAt <= sectionProvider.sliderValue)
          .toList(),
    ],
  );
}
