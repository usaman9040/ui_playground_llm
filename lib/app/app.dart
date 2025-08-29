import 'package:ui_playground_llm/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:ui_playground_llm/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:ui_playground_llm/ui/views/home/home_view.dart';
import 'package:ui_playground_llm/ui/views/startup/startup_view.dart';
import 'package:ui_playground_llm/ui/views/custom_form/custom_form_view.dart';
import 'package:ui_playground_llm/services/gemini_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CustomFormView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: GeminiService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
