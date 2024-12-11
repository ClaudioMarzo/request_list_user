import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:user_list/model/user_model.dart';
import 'package:user_list/view/widget/button_custom.dart';
import 'package:user_list/view_models/view_model.dart';
import 'package:user_list/view_state/state_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final ViewModel viewModel = GetIt.instance<ViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Usuários',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'Carregar Usuário',
                onPressed: viewModel.getUserModel,
              ),
              CustomButton(
                text: 'Limpar lista',
                onPressed: viewModel.clearUserList,
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ValueListenableBuilder<StateViewModel>(
              valueListenable: viewModel.getUser,
              builder: (context, state, _) {
                if (state is StateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is StateSucess) {
                  final List<UserModel> users = state.userList;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      );
                    },
                  );
                } else if (state is StateErro) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: viewModel.getUserModel,
                          child: const Text('Sair'),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: Text('Dados não carregados'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
