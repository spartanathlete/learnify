part of home_screen;

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

Widget _buildActiveProject({
  required List<ProjectCardData> data,
  required ThemeProvider themeProvider,
  int crossAxisCount = 6,
  int crossAxisCellCount = 2,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
    child: ActiveLessonCard(
      themeProvider: themeProvider,
      onPressedSeeAll: () {},
      child: StaggeredGridView.countBuilder(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        itemCount: data.length,
        addAutomaticKeepAlives: false,
        mainAxisSpacing: kSpacing,
        crossAxisSpacing: kSpacing,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProjectCard(data: data[index]);
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.fit(crossAxisCellCount),
      ),
    ),
  );
}
