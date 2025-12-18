import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/core/widgets/language_toggle.dart';
import 'package:template_flutter/core/widgets/theme_toggle.dart';
import 'package:template_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:template_flutter/generated/locale_keys.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_title.tr()),
        actions: const [
          LanguageToggle(),
          ThemeToggle(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                LocaleKeys.home_welcome.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.home_description.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Модуль аутентификации
              _ModuleCard(
                title: LocaleKeys.home_auth_module.tr(),
                description: LocaleKeys.home_auth_module_desc.tr(),
                icon: Icons.login,
                color: Colors.blue,
                onTap: () => context.go('/auth'),
              ),
              const SizedBox(height: 16),
              // Модуль счетчика
              _ModuleCard(
                title: LocaleKeys.home_counter_module.tr(),
                description: LocaleKeys.home_counter_module_desc.tr(),
                icon: Icons.add_circle_outline,
                color: Colors.green,
                onTap: () => context.go('/counter'),
              ),
              const SizedBox(height: 16),
              // Пример модуль
              _ModuleCard(
                title: LocaleKeys.home_example_module.tr(),
                description: LocaleKeys.home_example_module_desc.tr(),
                icon: Icons.list,
                color: Colors.orange,
                onTap: () => context.go('/example'),
              ),
              const SizedBox(height: 32),
              // Статус авторизации
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Card(
                    color: state.maybeWhen(
                      authenticated: (_) => Colors.green.shade50,
                      orElse: () => Colors.grey.shade100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            LocaleKeys.home_auth_status.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          state.maybeWhen(
                            authenticated: (user) => Column(
                              children: [
                                Text(
                                  LocaleKeys.home_logged_in.tr(),
                                  style:
                                      TextStyle(color: Colors.green.shade700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            orElse: () => Text(
                              LocaleKeys.home_not_authorized.tr(),
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
    );
  }
}
