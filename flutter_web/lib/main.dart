import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redux/redux.dart';

import 'app.dart';
import 'middleware/middleware.dart';
import 'models/app_state.dart';
import 'models/models.dart';
import 'reducers/app_state_reducer.dart';

void main() async {
  await dotenv.load();
  
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ReduxApp(
    key: Keys.app,
    store: Store<AppState>(
      appStateReducer,
      initialState: AppState.loading(),
      middleware: createStoreMiddleware()
    ))
  );
}