import 'package:flutter/material.dart';

import '../../api/patient/patient.dart';
import '../info_table/index.dart';

final summaryPanelBackgroundColor = Colors.grey[350];

class TabbedDetailsPanel extends StatefulWidget {
  final Patient patient;
  final List<SummaryPanelTab> tabs;
  final int initialTabIndex;

  const TabbedDetailsPanel({
    required this.patient,
    required this.tabs,
    this.initialTabIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<TabbedDetailsPanel> createState() => _TabbedDetailsPanelState();
}

class _TabbedDetailsPanelState extends State<TabbedDetailsPanel>
    with SingleTickerProviderStateMixin {
  late int selectedTab;
  late TabController tabController;
  late ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDetailsHeader(),
        _buildDetailsContent(),
      ],
    );
  }

  Container _buildDetailsHeader() {
    return Container(
      color: summaryPanelBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PatientSummary(widget.patient),
          _buildTabBarPanel(),
        ],
      ),
    );
  }

  Padding _buildTabBarPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(1200, 500)),
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorWeight: 4,
            tabs: widget.tabs
                .map((t) => Tab(
                      child: Text(
                        t.title,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Expanded _buildDetailsContent() {
    return Expanded(
      child: Scrollbar(
        isAlwaysShown: false,
        controller: scrollController,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: widget.tabs[tabController.index].child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    tabController.addListener(() {
      setState(() {
        scrollController.jumpTo(0);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

class SummaryPanelTab {
  final String title;
  final Widget child;

  const SummaryPanelTab({
    required this.title,
    required this.child,
  });
}

class PatientSummary extends StatelessWidget {
  final Patient patient;

  const PatientSummary(this.patient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name ?? 'unknown',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InfoTable([
                        Info(
                          key: 'Father\'s name',
                          value: patient.fatherName ?? 'unknown',
                        ),
                        Info(
                          key: 'Location',
                          value: patient.location ?? 'unknown',
                        ),
                      ]),
                      const SizedBox(width: 50),
                      InfoTable([
                        Info(key: 'Age', value: 'unknown'),
                        Info(
                          key: 'Gender',
                          value: patient.gender ?? 'unknown',
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
