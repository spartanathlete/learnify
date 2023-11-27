library home_screen;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/components/active_project_card.dart';
import 'package:learnify/components/recent_messages.dart';
import 'package:learnify/components/team_member.dart';
import 'package:learnify/models/user_model.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/chatting_card.dart';
import 'package:learnify/components/get_premium_card.dart';
import 'package:learnify/components/list_profil_image.dart';
import 'package:learnify/components/project_card.dart';
import 'package:learnify/components/responsive_builder.dart';
import 'package:learnify/screens/shared_ui_functions.dart';
import 'package:learnify/utils/size_config.dart';

part 'ui_functions.dart';

class HomeScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final SizeConfig sizeConfig;
  final Future<UserModel?> user;

  const HomeScreen({
    super.key,
    required this.themeProvider,
    required this.sizeConfig,
    required this.user,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardController controller = DashboardController();
  TextEditingController commentController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedUiFunctions sharedUiFunctions = SharedUiFunctions();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobileBuilder: (context, onstraints) =>
          mob(context, onstraints, widget.sizeConfig, widget.themeProvider),
      tabletBuilder: (context, onstraints) =>
          mob(context, onstraints, widget.sizeConfig, widget.themeProvider),
      desktopBuilder: (context, constraints) => SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 9,
              child: Column(
                children: [
                  const SizedBox(height: kSpacing),
                  sharedUiFunctions.buildHeader(
                      themeProvider: widget.themeProvider),
                  const SizedBox(height: kSpacing * 2),
                  _buildActiveProject(
                    themeProvider: widget.themeProvider,
                    data: controller.getActiveProject(),
                    crossAxisCount: 6,
                    crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
                  ),
                  const SizedBox(height: kSpacing * 2),
                  // Body(sizeConfig: widget.sizeConfig),
                  // const SizedBox(height: kSpacing * 2),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: kSpacing / 2),
                  sharedUiFunctions.buildProfile(
                    data: widget.user,
                    themeProvider: widget.themeProvider,
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: kSpacing),
                  _buildTeamMember(
                    data: controller.getMember(),
                    themeProvider: widget.themeProvider,
                  ),
                  const SizedBox(height: kSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                    child: GetPremiumCard(
                      onPressed: () {},
                      themeProvider: widget.themeProvider,
                    ),
                  ),
                  const SizedBox(height: kSpacing),
                  const Divider(thickness: 1),
                  const SizedBox(height: kSpacing),
                  _buildRecentMessages(
                    data: controller.getChatting(),
                    themeProvider: widget.themeProvider,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mob(context, constraints, config, themeProvider) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
        sharedUiFunctions.buildHeader(themeProvider: themeProvider),
        const SizedBox(height: kSpacing / 2),
        const Divider(),
        sharedUiFunctions.buildProfile(
          data: widget.user,
          themeProvider: themeProvider,
        ),
        const SizedBox(height: kSpacing),
        _buildTeamMember(
          data: controller.getMember(),
          themeProvider: themeProvider,
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: GetPremiumCard(
            onPressed: () {},
            themeProvider: widget.themeProvider,
          ),
        ),
        const SizedBox(height: kSpacing * 2),
        _buildRecentMessages(
          data: controller.getChatting(),
          themeProvider: themeProvider,
        ),
      ]),
    );
  }

  Widget tab(context, constraints, themeProvider) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Flexible(
            flex: 9,
            child: Column(
              children: [
                sharedUiFunctions.buildHeader(themeProvider: themeProvider),
                const SizedBox(height: kSpacing * 2),
                _buildActiveProject(
                  themeProvider: themeProvider,
                  data: controller.getActiveProject(),
                  crossAxisCount: 6,
                  crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
                ),
                const SizedBox(height: kSpacing),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                const SizedBox(height: kSpacing / 2),
                sharedUiFunctions.buildProfile(
                  data: widget.user,
                  themeProvider: themeProvider,
                ),
                const Divider(thickness: 1),
                const SizedBox(height: kSpacing),
                _buildTeamMember(
                    data: controller.getMember(), themeProvider: themeProvider),
                const SizedBox(height: kSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                  child: GetPremiumCard(
                    onPressed: () {},
                    themeProvider: widget.themeProvider,
                  ),
                ),
                const SizedBox(height: kSpacing),
                const Divider(thickness: 1),
                const SizedBox(height: kSpacing),
                _buildRecentMessages(
                  data: controller.getChatting(),
                  themeProvider: themeProvider,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
