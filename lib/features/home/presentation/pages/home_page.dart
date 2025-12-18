import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              Text(
                LocaleKeys.home_welcome.tr(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24.sp,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                LocaleKeys.home_description.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              // Модуль аутентификации
              _ModuleCard(
                title: LocaleKeys.home_auth_module.tr(),
                description: LocaleKeys.home_auth_module_desc.tr(),
                icon: Icons.login,
                color: Colors.blue,
                onTap: () => context.go('/auth'),
              ),
              SizedBox(height: 16.h),
              // Модуль счетчика
              _ModuleCard(
                title: LocaleKeys.home_counter_module.tr(),
                description: LocaleKeys.home_counter_module_desc.tr(),
                icon: Icons.add_circle_outline,
                color: Colors.green,
                onTap: () => context.go('/counter'),
              ),
              SizedBox(height: 16.h),
              // Пример модуль
              _ModuleCard(
                title: LocaleKeys.home_example_module.tr(),
                description: LocaleKeys.home_example_module_desc.tr(),
                icon: Icons.list,
                color: Colors.orange,
                onTap: () => context.go('/example'),
              ),
              SizedBox(height: 32.h),
              // Статус авторизации
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Card(
                    color: state.maybeWhen(
                      authenticated: (_) => Colors.green.shade50,
                      orElse: () => Colors.grey.shade100,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Text(
                            LocaleKeys.home_auth_status.tr(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 18.sp,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          state.maybeWhen(
                            authenticated: (user) => Column(
                              children: [
                                Text(
                                  LocaleKeys.home_logged_in.tr(),
                                  style:
                                      TextStyle(color: Colors.green.shade700),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 14.sp,
                                      ),
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
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: color, size: 32.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: 14.sp,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16.sp, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
    );
  }
}
