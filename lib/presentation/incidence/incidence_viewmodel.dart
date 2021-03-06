import 'package:appwrite_incidence_employe/app/app_preferences.dart';
import 'package:appwrite_incidence_employe/data/data_source/local_data_source.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_model.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence_employe/domain/model/name_model.dart';
import 'package:appwrite_incidence_employe/domain/model/user_model.dart';
import 'package:appwrite_incidence_employe/domain/usecase/incidence_usecase.dart';
import 'package:appwrite_incidence_employe/intl/generated/l10n.dart';
import 'package:appwrite_incidence_employe/presentation/base/base_viewmodel.dart';
import 'package:appwrite_incidence_employe/presentation/common/dialog_render/dialog_render.dart';
import 'package:appwrite_incidence_employe/presentation/common/state_render/state_render.dart';
import 'package:appwrite_incidence_employe/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence_employe/presentation/resources/routes_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class IncidenceViewModel extends BaseViewModel
    with IncidenceViewModelInputs, IncidenceViewModelOutputs {
  final IncidenceUseCase _incidenceUseCase;
  final DialogRender _dialogRender;
  final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  IncidenceViewModel(this._incidenceUseCase, this._dialogRender,
      this._appPreferences, this._localDataSource);

  final _prioritysStrCtrl = BehaviorSubject<List<Name>>();
  final _incidenceSelStrCtrl = BehaviorSubject<IncidenceSel>();
  final _userStrCtrl = BehaviorSubject<UsersModel>();
  final ImagePicker _picker = ImagePicker();

  @override
  void start() {
    prioritys();
    super.start();
  }

  @override
  void dispose() async {
    inputIncidenceSel.add(IncidenceSel());
    await _prioritysStrCtrl.drain();
    _prioritysStrCtrl.close();
    await _incidenceSelStrCtrl.drain();
    _incidenceSelStrCtrl.close();
    await _userStrCtrl.drain();
    _userStrCtrl.close();
    super.dispose();
  }

  @override
  Sink get inputPrioritys => _prioritysStrCtrl.sink;

  @override
  Sink get inputIncidenceSel => _incidenceSelStrCtrl.sink;

  @override
  Sink get inputUser => _userStrCtrl.sink;

  @override
  Stream<List<Name>> get outputPrioritys =>
      _prioritysStrCtrl.stream.map((prioritys) => prioritys);

  @override
  Stream<IncidenceSel> get outputIncidenceSel =>
      _incidenceSelStrCtrl.stream.map((incidenceSel) => incidenceSel);

  @override
  Stream<UsersModel> get outputUser => _userStrCtrl.stream.map((user) => user);

  @override
  Future<Incidence?> incidence(BuildContext context, String incidenceId) async {
    final s = S.of(context);
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: s.loading));
    return (await _incidenceUseCase.incidence(incidenceId)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
      return null;
    }, (r) {
      inputState.add(ContentState());
      return r;
    });
  }

  @override
  changeIncidenceSel(IncidenceSel incidenceSel) {
    inputIncidenceSel.add(incidenceSel);
  }

  @override
  pickImage(IncidenceSel incidenceSel) async {
    XFile? xFile;
    if (kIsWeb) {
      xFile = await _picker.pickImage(source: ImageSource.gallery);
    } else {
      xFile = await _picker.pickImage(source: ImageSource.camera);
    }
    if (xFile != null) {
      final uint8list = await xFile.readAsBytes();
      final name = xFile.name;
      (await _incidenceUseCase
              .createFile(IncidenceUseCaseFile(uint8list, name)))
          .fold((l) => null, (file) {
        inputIncidenceSel.add(IncidenceSel(
            area: incidenceSel.area,
            priority: incidenceSel.priority,
            active: incidenceSel.active,
            image: file.$id));
      });
    }
  }

  @override
  prioritys() async {
    (await _incidenceUseCase.prioritys(null)).fold((l) {}, (prioritys) {
      inputPrioritys.add(prioritys);
    });
  }

  @override
  createIncidence(Incidence incidence, BuildContext context) async {
    final s = S.of(context);
    (await _incidenceUseCase.incidenceCreate(incidence)).fold(
        (l) => _dialogRender.showPopUp(context, DialogRendererType.errorDialog,
            (s.error).toUpperCase(), l.message, null, null, null), (r) {
      inputIncidenceSel.add(IncidenceSel());
      GoRouter.of(context).go(Routes.mainRoute);
    });
  }

  @override
  deleteSession(BuildContext context) async {
    final s = S.of(context);
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: s.loading));
    final sessionId = _appPreferences.getSessionId();
    (await _incidenceUseCase.deleteSession(sessionId)).fold((f) {
      inputState
          .add(ErrorState(StateRendererType.fullScreenErrorState, f.message));
    }, (r) async {
      inputState.add(ContentState());
      await _appPreferences.logout();
      _localDataSource.clearCache();
      GoRouter.of(context).go(Routes.splashRoute);
    });
  }

  @override
  account() async {
    (await _incidenceUseCase.user(_appPreferences.getUserId()))
        .fold((f) => null, (user) async {
      inputUser.add(user);
    });
  }
}

abstract class IncidenceViewModelInputs {
  Sink get inputPrioritys;

  Sink get inputIncidenceSel;

  Sink get inputUser;

  Future<Incidence?> incidence(BuildContext context, String incidenceId);

  changeIncidenceSel(IncidenceSel incidenceSel);

  pickImage(IncidenceSel incidenceSel);

  prioritys();

  createIncidence(Incidence incidence, BuildContext context);

  deleteSession(BuildContext context);

  account();
}

abstract class IncidenceViewModelOutputs {
  Stream<List<Name>> get outputPrioritys;

  Stream<IncidenceSel> get outputIncidenceSel;

  Stream<UsersModel> get outputUser;
}
