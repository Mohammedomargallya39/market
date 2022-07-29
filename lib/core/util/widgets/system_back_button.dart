import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/main/pages/main_page.dart';
import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class SystemBackButton extends StatelessWidget {
  const SystemBackButton({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context, state) {
        return WillPopScope(
            child: child,
            onWillPop: () async
            {
              AppCubit.get(context).currentIndex = 0;
              navigateAndFinish(context, const MainPageScreen());
              return false;
            }
        );
      },
    );
  }
}
