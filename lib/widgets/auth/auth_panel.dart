import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/theme.dart';
import 'neon_input.dart';
import 'gaming_button.dart';

class AuthPanel extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const AuthPanel({super.key, required this.onLoginSuccess});

  @override
  State<AuthPanel> createState() => _AuthPanelState();
}

class _AuthPanelState extends State<AuthPanel> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppTheme.idePanel.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.syntaxBlue.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 40,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: AppTheme.syntaxBlue.withValues(alpha: 0.1),
              blurRadius: 60,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              _isLogin ? 'Welcome Back' : 'Join CodeQuest',
              style: AppTheme.headingStyle.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ).animate().fadeIn().slideY(begin: -0.2, end: 0),
            
            const SizedBox(height: 12),
            Text(
              _isLogin 
                ? 'Sign in to continue your coding journey'
                : 'Start your learning adventure today',
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.syntaxComment,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 40),

            // Form Fields
            if (!_isLogin)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: NeonInput(
                  hintText: 'Username',
                  prefixIcon: Icons.person_outline,
                ).animate().fadeIn().slideX(begin: -0.1, end: 0),
              ),

            NeonInput(
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
            ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),

            const SizedBox(height: 20),

            NeonInput(
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),

            const SizedBox(height: 32),

            // Login Button
            GamingButton(
              text: _isLogin ? 'Start Learning' : 'Create Account',
              onPressed: widget.onLoginSuccess,
            ).animate().fadeIn(delay: 600.ms).scale(),

            const SizedBox(height: 20),

            // Toggle Button
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: RichText(
                text: TextSpan(
                  style: AppTheme.bodyStyle.copyWith(fontSize: 14),
                  children: [
                    TextSpan(
                      text: _isLogin 
                        ? "Don't have an account? "
                        : 'Already have an account? ',
                      style: TextStyle(color: AppTheme.syntaxComment),
                    ),
                    TextSpan(
                      text: _isLogin ? 'Sign Up' : 'Sign In',
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 700.ms),
          ],
        ),
      ),
    );
  }
}
