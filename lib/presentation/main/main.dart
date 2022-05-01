import 'package:appwrite_incidence_employe/app/dependency_injection.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_model.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence_employe/intl/generated/l10n.dart';
import 'package:appwrite_incidence_employe/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence_employe/presentation/global_widgets/incidence.dart';
import 'package:appwrite_incidence_employe/presentation/global_widgets/responsive.dart';
import 'package:appwrite_incidence_employe/presentation/resources/routes_manager.dart';
import 'package:appwrite_incidence_employe/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_viewmodel.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _viewModel = instance<MainViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final s = S.of(context);
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(size, s), () {
                _viewModel.inputState.add(ContentState());
              }, () {}) ??
              _getContentWidget(size, s)),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),
          onPressed: () =>
              GoRouter.of(context).push(Routes.incidenceRoute + '/new')),
    );
  }

  Widget _getContentWidget(Size size, S s) {
    return ResponsiveWid(
        smallScreen: _data(size.width * 0.8, s),
        largeScreen: _data(size.width * 0.5, s));
  }

  Widget _data(double width, S s) {
    return Center(
      child: SizedBox(
        width: width,
        child: StreamBuilder<IncidenceSel>(
            stream: _viewModel.outputIncidenceSel,
            builder: (_, snapshot) {
              final incidenceSel = snapshot.data;
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.maxScrollExtent ==
                      scrollInfo.metrics.pixels) {
                    if (incidenceSel?.active != null) {
                      _viewModel.incidencesActive(incidenceSel?.active ?? false);
                    } else {
                      _viewModel.incidences(false);
                    }
                  }
                  return true;
                },
                child: Column(
                  children: [
                    _filter(s),
                    const Divider(),
                    StreamBuilder<List<Incidence>>(
                        stream: _viewModel.outputIncidences,
                        builder: (_, snapshot) {
                          final incidences = snapshot.data;
                          return incidences != null && incidences.isNotEmpty
                              ? Expanded(child:
                                  LayoutBuilder(builder: (context, constaints) {
                                  final count =
                                      constaints.maxWidth ~/ AppSize.s200;
                                  return GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: AppMargin.m6,
                                        horizontal: AppMargin.m12),
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: count,
                                            childAspectRatio:
                                                AppSize.s200 / AppSize.s200,
                                            crossAxisSpacing: AppSize.s10,
                                            mainAxisSpacing: AppSize.s10),
                                    itemBuilder: (_, index) {
                                      final incidence = incidences[index];
                                      return IncidenceItem(incidence, () {
                                        GoRouter.of(context).push(
                                            Routes.incidenceRoute +
                                                '/${incidence.id}',
                                            extra: incidence);
                                      });
                                    },
                                    itemCount: incidences.length,
                                  );
                                }))
                              : Center(
                                  child: Text(s.noData),
                                );
                        }),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsLoading,
                        builder: (_, snapshot) {
                          final loading = snapshot.data;
                          return loading != null && loading
                              ? const CircularProgressIndicator()
                              : const SizedBox();
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _filter(S s) {
    return StreamBuilder<IncidenceSel>(
        stream: _viewModel.outputIncidenceSel,
        builder: (_, snapshot) {
          final incidenceSel = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSize.s10),
              SizedBox(
                height: AppSize.s40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: AppSize.s20),
                    SizedBox(
                      width: AppSize.s140,
                      child: StreamBuilder<List<bool>?>(
                          stream: _viewModel.outputActives,
                          builder: (_, snapshot) {
                            final actives = snapshot.data;
                            return actives != null && actives.isNotEmpty
                                ? DropdownButtonFormField<bool?>(
                                    isExpanded: true,
                                    decoration:
                                        InputDecoration(label: Text(s.active)),
                                    hint: Text(s.active),
                                    items: actives
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                        .toList(),
                                    value: incidenceSel?.active,
                                    onChanged: (value) {
                                      _viewModel.changeIncidenceSel(
                                          IncidenceSel(active: value));
                                    })
                                : const SizedBox();
                          }),
                    ),
                    const SizedBox(width: AppSize.s20),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s10),
            ],
          );
        });
  }
}
