import 'package:appwrite_incidence_employe/app/app_preferences.dart';
import 'package:appwrite_incidence_employe/data/data_source/local_data_source.dart';
import 'package:appwrite_incidence_employe/domain/usecase/main_usecase.dart';
import 'package:appwrite_incidence_employe/presentation/base/base_viewmodel.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final MainUseCase _mainUseCase;
  final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  MainViewModel(this._mainUseCase, this._appPreferences, this._localDataSource);



  @override
  void start() {
    super.start();
  }

  @override
  void dispose() async {
    super.dispose();
  }

}

abstract class MainViewModelInputs {

}

abstract class MainViewModelOutputs {

}
