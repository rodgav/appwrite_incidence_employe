import 'package:appwrite/appwrite.dart';
import 'package:appwrite_incidence_employe/app/app_preferences.dart';
import 'package:appwrite_incidence_employe/data/data_source/local_data_source.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_model.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence_employe/domain/usecase/main_usecase.dart';
import 'package:appwrite_incidence_employe/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final MainUseCase _mainUseCase;
  final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  MainViewModel(this._mainUseCase, this._appPreferences, this._localDataSource);

  final _incidencesStrCtrl = BehaviorSubject<List<Incidence>>();
  final _activesStrCtrl = BehaviorSubject<List<bool>?>();
  final _incidenceSelStrCtrl = BehaviorSubject<IncidenceSel>();
  final _isLoading = BehaviorSubject<bool>();
  final List<Incidence> _incidences = [];

  @override
  void start() {
    inputActives.add([true, false]);
    incidences(true);
    super.start();
  }

  @override
  void dispose() async {
    await _incidencesStrCtrl.drain();
    _incidencesStrCtrl.close();
    await _activesStrCtrl.drain();
    _activesStrCtrl.close();
    await _incidenceSelStrCtrl.drain();
    _incidenceSelStrCtrl.close();
    await _isLoading.drain();
    _isLoading.close();
    super.dispose();
  }

  @override
  Sink get inputIncidences => _incidencesStrCtrl.sink;

  @override
  Sink get inputActives => _activesStrCtrl.sink;

  @override
  Sink get inputIncidenceSel => _incidenceSelStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Stream<List<Incidence>> get outputIncidences =>
      _incidencesStrCtrl.stream.map((incidences) => incidences);

  @override
  Stream<List<bool>?> get outputActives =>
      _activesStrCtrl.stream.map((boleans) => boleans);

  @override
  Stream<IncidenceSel> get outputIncidenceSel =>
      _incidenceSelStrCtrl.stream.map((incidenceSel) => incidenceSel);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  incidences(bool firstQuery) async {
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _mainUseCase.execute(MainUseCaseInput(
              [Query.equal('employe', _appPreferences.getName())], 25, 0)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _mainUseCase.execute(MainUseCaseInput(
              [Query.equal('employe', _appPreferences.getName())],
              25,
              _incidences.length > 1
                  ? _incidences.length - 1
                  : _incidences.length)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  incidencesActive(bool active) async {
    _incidences.clear();
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _mainUseCase.execute(MainUseCaseInput([
        Query.equal('employe', _appPreferences.getName()),
        Query.equal('active', active)
      ], 25, 0)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _mainUseCase.execute(MainUseCaseInput(
              [
            Query.equal('employe', _appPreferences.getName()),
            Query.equal('active', active)
          ],
              25,
              _incidences.length > 1
                  ? _incidences.length - 1
                  : _incidences.length)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }

  @override
  changeIncidenceSel(IncidenceSel incidenceSel) async {
    inputIncidenceSel.add(incidenceSel);
    _incidences.clear();
    if (incidenceSel.active == null) {
      await incidences(true);
    } else {
      await incidencesActive(incidenceSel.active ?? false);
    }
  }
}

abstract class MainViewModelInputs {
  Sink get inputIncidences;

  Sink get inputActives;

  Sink get inputIncidenceSel;

  Sink get inputIsLoading;

  incidences(bool firstQuery);

  incidencesActive(bool active);

  changeIsLoading(bool isLoading);

  changeIncidenceSel(IncidenceSel incidenceSel);
}

abstract class MainViewModelOutputs {
  Stream<List<Incidence>> get outputIncidences;

  Stream<List<bool>?> get outputActives;

  Stream<IncidenceSel> get outputIncidenceSel;

  Stream<bool> get outputIsLoading;
}
