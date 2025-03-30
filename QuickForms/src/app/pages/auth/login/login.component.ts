import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../services/auth.service';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatIcon } from '@angular/material/icon';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatIcon
  ],
  template: `
    <div class="login-container">
  <div class="login-card">
    <div class="card-header">
      <h2>登入</h2>
      <p class="subtitle">歡迎回到 QuickForms</p>
    </div>

    <form [formGroup]="loginForm" (ngSubmit)="onSubmit()">
      <div class="form-group">
        <mat-form-field appearance="outline">
          <mat-label>帳號</mat-label>
          <!-- <mat-icon>person</mat-icon> -->
          <input matInput formControlName="username" type="text" required>
          <mat-error *ngIf="loginForm.get('username')?.hasError('required')">
            請輸入帳號
          </mat-error>
        </mat-form-field>
      </div>

      <div class="form-group">
        <mat-form-field appearance="outline">
          <mat-label>密碼</mat-label>
         
          <input matInput formControlName="password" type="password" required>
          <mat-error *ngIf="loginForm.get('password')?.hasError('required')">
            請輸入密碼
          </mat-error>
        </mat-form-field>
      </div>

      <div class="test-account">
        <p>測試帳號: <strong>abc123</strong></p>
        <p>測試密碼: <strong>abc123</strong></p>
      </div>

      <button type="submit" [disabled]="loginForm.invalid || isLoading" class="login-button">
        @if (isLoading) {
          <i class="fas fa-spinner fa-spin"></i>
          登入中...
        } @else {
          登入
        }
      </button>
    </form>
  </div>
</div>
  `,
  styles: [`
    .login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: #f5f5f5;
  padding: 24px;
}

.login-card {
  background: #e0e0e0;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  width: 100%;
  max-width: 480px;
  animation: fadeIn 0.5s ease;
}

.card-header {
  text-align: center;
  margin-bottom: 32px;

  h2 {
    margin: 0;
    color: #424242;
    font-size: 28px;
    font-weight: 600;
  }

  .subtitle {
    color: #616161;
    margin-top: 8px;
    font-size: 14px;
  }
}

.form-group {
  margin-bottom: 24px;
}

mat-form-field {
  width: 100%;
  display: flex;
  align-items: center;

  mat-icon {
    color: #a0aec0;
    margin-right: 12px;
  }

  .mat-mdc-form-field-flex {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .mat-mdc-form-field-infix {
    padding: 0;
  }

  input {
    padding-left: 0;
  }
}

.login-button {
      width: 100%;
      padding: 12px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin-top: 16px;

      &:hover:not(:disabled) {
        background-color: #2980b9;
      }

      &:disabled {
        background-color: #95a5a6;
        cursor: not-allowed;
      }
    }

.test-account {
  display: flex;
  justify-content: center;
  gap: 18px;
  text-align: center;
  margin: 16px 0;
  color: #616161;
  font-size: 14px;

  strong {
    color: #424242;
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
  `]
})
export class LoginComponent {
  rememberMe = false;
  loginForm: FormGroup;
  isLoading = false;

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.loginForm = this.fb.group({
      username: ['', [Validators.required]],
      password: ['', [Validators.required]]
    });
  }

  onSubmit(): void {
    if (this.loginForm.valid) {
      this.isLoading = true;
      const { username, password } = this.loginForm.value;

      this.authService.login(username, password).subscribe({
        next: () => {
          this.router.navigate(['/home']);
        },
        error: (error: Error) => {
          this.isLoading = false;
          this.snackBar.open(error.message, '關閉', {
            duration: 3000,
            horizontalPosition: 'center',
            verticalPosition: 'top'
          });
        }
      });
    }
  }
}
