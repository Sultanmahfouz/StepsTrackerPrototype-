import 'package:steps_tracker_prototype/models/user.dart';

class CompetitionServices {
  final List<UserData> allUsers;

  CompetitionServices(this.allUsers);

  List<UserData> sortUsersFootsteps() {
    List<UserData> currentUsers = [];
    try {
      if (allUsers != null && allUsers?.length != 0) {
        currentUsers.addAll(allUsers);

        currentUsers.sort(
            (a, b) => int.parse(a.footSteps).compareTo(int.parse(b.footSteps)));
        return currentUsers;
      }
    } on Exception catch (error) {
      print(error.toString());
    }
    return currentUsers;
  }
}
