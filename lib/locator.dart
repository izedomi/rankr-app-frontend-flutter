import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rankr_app/app/vm/ranking_vm.dart';

import 'app/vm/poll_vm.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => PollVM()),
  ChangeNotifierProvider(create: (_) => RankingVM()),
];
