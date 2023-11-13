part of lessons_overview_screen;

Widget _buildRecentMessages({
  required List<ChattingCardData> data,
  required ThemeProvider themeProvider,
}) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: RecentMessages(
        onPressedMore: () {},
        themeProvider: themeProvider,
      ),
    ),
    const SizedBox(height: kSpacing / 2),
    ...data
        .map(
          (e) => ChattingCard(
            data: e,
            onPressed: () {},
            themeProvider: themeProvider,
          ),
        )
        .toList(),
  ]);
}

Widget _buildTeamMember({
  required List<ImageProvider> data,
  required ThemeProvider themeProvider,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TeamMember(
          themeProvider: themeProvider,
          totalMember: data.length,
          onPressedAdd: () {},
        ),
        const SizedBox(height: kSpacing / 2),
        ListProfilImage(maxImages: 6, images: data),
      ],
    ),
  );
}

Widget buildLessonOverview({
  required List<LessonModel> data,
  int crossAxisCount = 6,
  int crossAxisCellCount = 2,
  Axis headerAxis = Axis.horizontal,
  required ThemeProvider themeProvider,
  required SizeConfig sizeConfig,
  required BuildContext context,
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
              onPressedExercise: () {
                // context.(QuizBody(sizeConfig: sizeConfig));
                context.goNamed(
                  extra: data[index - 1].title,
                  'exercise',
                );
              },
              onPressedPursue: () {},
            );
    },
    staggeredTileBuilder: (int index) =>
        StaggeredTile.fit((index == 0) ? crossAxisCount : crossAxisCellCount),
  );
}
