import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/pages/patient_details/patient_resource_bloc/patient_resource_bloc.dart';
import 'package:registration_desk/widgets/content_card/content_card.dart';
import 'package:registration_desk/widgets/scaffold/patient_summary_panel.dart';
import 'package:registration_desk/widgets/scaffold/scaffold2.dart';
import 'package:registration_desk/widgets/tab_selection_bloc/tab_selection_bloc.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';
import '../../routing.dart';
import '../../widgets/scaffold/scaffold.dart';
import '../dashboard/index.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientId;

  const PatientDetailsPage(this.patientId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebScaffold2(
      title: 'Patient details',
      onNavigateBack: () {
        Navigator.push(
          context,
          WebPageRoute(builder: (context) => RegistrationDashboard()),
        );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PatientResourceBloc(patientId: patientId),
          ),
          BlocProvider(
            create: (context) => TabSelectionBloc(1),
          ),
        ],
        child: BlocBuilder<PatientResourceBloc, PatientState>(
          builder: (context, state) {
            if (state is LoadingPatient) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DisplayingPatient) {
              return DetailsPage(
                patient: state.patient,
                tabSelectionBloc: context.read<TabSelectionBloc>(),
                tabs: [
                  SummaryPanelTab(
                    title: 'General',
                    child: Container(
                      child: Text('Placeholder for general content.'),
                    ),
                  ),
                  SummaryPanelTab(
                    title: 'Visits',
                    child: _VisistsTabContent(),
                  ),
                ],
              );
            }
            return const Text('An error occurred');
          },
        ),
      ),
    );
  }
}

class _VisistsTabContent extends StatelessWidget {
  const _VisistsTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentCard(
          title: ContentCardTitle(
            text: 'Current visit',
            icon: Icons.date_range,
          ),
          info: [
            ContentCardInfo(key: 'Status', value: 'Admitted'),
            ContentCardInfo(key: 'Type', value: 'OPD'),
            ContentCardInfo(key: 'Start', value: 'Friday, 19-11-2021, 07:23a.m.'),
          ],
          buttons: [
            ContentCardButton(title: 'Print registration card', onPressed: () {}),
            ContentCardButton(title: 'Discharge', onPressed: () {}),
          ],
          icons: [
            ContentCardIcon(icon: Icons.edit, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
