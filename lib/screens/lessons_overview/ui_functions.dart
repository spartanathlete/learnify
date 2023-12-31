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
  required Stream<List<LessonModel>> data,
  int crossAxisCount = 6,
  int crossAxisCellCount = 2,
  Axis headerAxis = Axis.horizontal,
  required ThemeProvider themeProvider,
  required SizeConfig sizeConfig,
  required BuildContext context,
  required Future<UserModel?> user,
}) {
  return StreamBuilder<List<LessonModel>>(
    stream: data,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: crossAxisCount,
          itemCount: snapshot.data!.length + 1,
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
                    data: snapshot.data![index - 1],
                    user: user,
                    // onPressedMore: () {},
                    onPressedTask: () {},
                    onPressedExercise: () {
                      // context.(QuizBody(sizeConfig: sizeConfig));
                      // context.goNamed(
                      //   extra: snapshot.data![index - 1].title,
                      //   'exercise',
                      // );
                    },
                    onPressedPursue: () {},
                  );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(
              (index == 0) ? crossAxisCount : crossAxisCellCount),
        );
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
