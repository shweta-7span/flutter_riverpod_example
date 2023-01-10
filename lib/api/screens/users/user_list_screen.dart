import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/api/screens/users/user_detail_screen.dart';

import '../../model/user_model.dart';
import '../../services/api_service.dart';
import '../moreApiScreen.dart';

final userDataProvider =
    FutureProvider<List<UserModel>>((ref) => ref.read(apiProvider).getUsers());

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final userData = ref.watch(userDataProvider);

          return userData.when(
            /*data: (userData) => ListView.builder(
                itemCount: userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(userData.elementAt(index).firstName),
                    subtitle: Text(userData.elementAt(index).lastName),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(userData.elementAt(index).avatar),
                    ),
                  );
                },
              ),*/
            data: (userData) {
              return ListView(
                children: [
                  ...userData.map(
                    (e) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailScreen(id: e.id))),
                      child: ListTile(
                        title: Text('${e.firstName} ${e.lastName}'),
                        subtitle: Text(e.email),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(e.avatar),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (err, stack) => Text(err.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.widgets),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MoreApiScreen(),
            ),
          );
        },
      ),
    );
  }
}
