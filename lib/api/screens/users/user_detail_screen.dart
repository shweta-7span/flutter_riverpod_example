import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';
import '../../services/api_service.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    final userDetailProvider = FutureProvider<UserModel>(
        (ref) => ref.read(apiProvider).getUserDetail(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Center(
        child: Consumer(
          builder: (_, WidgetRef ref, __) {
            final userData = ref.watch(userDetailProvider);
            return userData.when(
              data: (userData) => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        maxRadius: 60,
                        backgroundImage: NetworkImage(userData.avatar),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${userData.firstName} ${userData.lastName}",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(userData.email),
                  ],
                ),
              ),
              error: (err, stack) => Text(err.toString()),
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
