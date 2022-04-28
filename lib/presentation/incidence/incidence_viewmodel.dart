import 'package:appwrite_incidence_employe/domain/usecase/main_usecase.dart';
import 'package:appwrite_incidence_employe/presentation/base/base_viewmodel.dart';

class IncidenceViewModel extends BaseViewModel
    with IncidenceViewModelInputs, IncidenceViewModelOutputs {
  final MainUseCase _mainUseCase;

  IncidenceViewModel(this._mainUseCase);



  @override
  void start() {
    super.start();
  }

  @override
  void dispose() async {
    super.dispose();
  }

}

abstract class IncidenceViewModelInputs {

}

abstract class IncidenceViewModelOutputs {

}
