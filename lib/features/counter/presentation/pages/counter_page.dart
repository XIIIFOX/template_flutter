import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/core/di/injection_container.dart';
import 'package:template_flutter/core/widgets/language_toggle.dart';
import 'package:template_flutter/core/widgets/theme_toggle.dart';
import 'package:template_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:template_flutter/features/counter/presentation/bloc/counter_bloc.dart';

import 'package:template_flutter/generated/locale_keys.g.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CounterBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.canPop() ? context.pop() : context.go('/'),
          ),
          title: Text(LocaleKeys.counter_title.tr()),
          actions: const [
            LanguageToggle(),
            ThemeToggle(),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return authState.maybeWhen(
              authenticated: (user) => _CounterContent(user: user),
              orElse: () => Center(
                child: Text(LocaleKeys.counter_login_required.tr()),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CounterContent extends StatelessWidget {
  final dynamic user;

  const _CounterContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Информация о пользователе из модуля auth
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.counter_user.tr(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Значение счетчика
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.displayLarge,
                );
              },
            ),
            const SizedBox(height: 48),
            // Кнопки управления
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tooltip(
                  message: LocaleKeys.counter_decrement_tooltip.tr(),
                  child: FloatingActionButton(
                    onPressed: () {
                      context
                          .read<CounterBloc>()
                          .add(const CounterEvent.decrement());
                    },
                    heroTag: 'decrement',
                    child: const Icon(Icons.remove),
                  ),
                ),
                const SizedBox(width: 16),
                Tooltip(
                  message: LocaleKeys.counter_reset_tooltip.tr(),
                  child: FloatingActionButton(
                    onPressed: () {
                      context
                          .read<CounterBloc>()
                          .add(const CounterEvent.reset());
                    },
                    heroTag: 'reset',
                    child: const Icon(Icons.refresh),
                  ),
                ),
                const SizedBox(width: 16),
                Tooltip(
                  message: LocaleKeys.counter_increment_tooltip.tr(),
                  child: FloatingActionButton(
                    onPressed: () {
                      context
                          .read<CounterBloc>()
                          .add(const CounterEvent.increment());
                    },
                    heroTag: 'increment',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
