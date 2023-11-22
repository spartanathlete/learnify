// part of exercice_screen;

// Widget buildCommentsSection(
//   SizeConfig config,
//   ThemeProvider themeProvider,
//   DashboardController controller,
//   TextEditingController commentController,
//   String lessonID,
// ) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0, top: 10),
//         child: Text(
//           "Comments",
//           style: TextStyle(
//             color: (themeProvider.isDarkTheme)
//                 ? const Color.fromARGB(255, 255, 255, 255)
//                 : const Color(0xFF262628),
//             fontSize: config.blockSizeVertical * 2,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       const Divider(
//         height: 2,
//       ),
//       Padding(
//         padding: EdgeInsets.only(
//           left: config.blockSizeVertical * 5,
//           bottom: config.blockSizeVertical * 5,
//           right: config.blockSizeVertical * 5,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//                 margin: const EdgeInsets.only(top: 10, left: 10),
//                 child: renderComment(
//                   lessonID: lessonID,
//                   comments: controller.getComments(lessonID: lessonID),
//                   controller: controller,
//                 )),
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: TextFormField(
//                 controller: commentController,
//                 // cursorColor: Colors.black,
//                 maxLines: 7,
//                 minLines: 5,
//                 style: TextStyle(
//                   // color: Colors.black,
//                   fontSize: config.blockSizeVertical * 1.3,
//                 ),
//                 decoration: InputDecoration(
//                   hintStyle: const TextStyle(
//                     color: Color.fromRGBO(170, 170, 170, 1),
//                   ),
//                   hintText: "Write a reply...",
//                   suffixIcon: IconButton(
//                     icon:
//                         const Icon(Icons.send), // You can use any icon you want
//                     onPressed: () {},
//                   ),
//                   contentPadding: const EdgeInsets.all(10.0),
//                   focusedBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10.0),
//                     ),
//                     borderSide: BorderSide(
//                       color: Color.fromARGB(255, 44, 105, 141),
//                       width: 1,
//                     ),
//                   ),
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10.0),
//                     ),
//                     borderSide: BorderSide(
//                       color: Color.fromARGB(255, 35, 85, 110),
//                       width: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

// renderInternalComment({
//   required BuildContext context,
//   required List comments,
//   required DashboardController controller,
//   required String lessonID,
// }) {
//   return Column(
//     children: comments
//         .map((comment) => CommentItem(
//               lessonID: lessonID,
//               comment: comment,
//               isInternal: true,
//               controller: controller,
//             ))
//         .toList(),
//   );
// }

// Widget renderComment({
//   required Stream<List<CommentModel>> comments,
//   required DashboardController controller,
//   required String lessonID,
// }) {
//   return ListView.separated(
//     separatorBuilder: (BuildContext context, int index) => const Divider(),
//     shrinkWrap: true,
//     physics: const ClampingScrollPhysics(),
//     itemCount: comments.length,
//     itemBuilder: (context, index) {
//       return Column(
//         children: <Widget>[
//           CommentItem(
//             lessonID: lessonID,
//             comment: comments[index],
//             isInternal: false,
//             controller: controller,
//           ),
//           comments[index].replies!.isNotEmpty
//               ? renderInternalComment(
//                   lessonID: lessonID,
//                   context: context,
//                   comments: comments[index].replies!,
//                   controller: controller,
//                 )
//               : Container(),
//         ],
//       );
//     },
//   );
// }

// Widget buildLessonOverview({
//   required List<LessonModel> data,
//   int crossAxisCount = 6,
//   int crossAxisCellCount = 2,
//   Axis headerAxis = Axis.horizontal,
//   required ThemeProvider themeProvider,
// }) {
//   return StaggeredGridView.countBuilder(
//     crossAxisCount: crossAxisCount,
//     itemCount: data.length + 1,
//     addAutomaticKeepAlives: false,
//     padding: const EdgeInsets.symmetric(horizontal: kSpacing),
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     itemBuilder: (context, index) {
//       return (index == 0)
//           ? Padding(
//               padding: const EdgeInsets.only(bottom: kSpacing),
//               child: OverviewHeader(
//                 themeProvider: themeProvider,
//                 axis: headerAxis,
//                 onSelected: (task) {},
//               ),
//             )
//           : LessonCard(
//               themeProvider: themeProvider,
//               data: data[index - 1],
//               // onPressedMore: () {},
//               onPressedTask: () {},
//               onPressedExercise: () {},
//               onPressedPursue: () {},
//             );
//     },
//     staggeredTileBuilder: (int index) =>
//         StaggeredTile.fit((index == 0) ? crossAxisCount : crossAxisCellCount),
//   );
// }

// Widget _buildQuizCards({
//   required List<QuizCardData> data,
//   required String lessonName,
//   // required SectionProvider sectionProvider,
//   required ThemeProvider themeProvider,
// }) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: kSpacing),
//         child: SideList(
//           title: lessonName,
//           onPressedMore: () {},
//           themeProvider: themeProvider,
//         ),
//       ),
//       const SizedBox(height: kSpacing / 2),
//       ...data
//           .map(
//             (e) => QuizCard(
//               data: e,
//               onPressed: () {},
//               themeProvider: themeProvider,
//             ),
//           )
//           .toList(),
//     ],
//   );
// }

// Widget _buildQuizBody({
//   required SizeConfig sizeConfig,
//   required List<Question> questions,
// }) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         QuizBody(
//           sizeConfig: sizeConfig,
//           questions: questions,
//         ),
//       ],
//     ),
//   );
// }
