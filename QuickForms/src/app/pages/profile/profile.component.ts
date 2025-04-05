import { Component, ViewChild, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTabsModule } from '@angular/material/tabs';
import { MatDividerModule } from '@angular/material/divider';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule,
    MatTabsModule,
    MatDividerModule
  ],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent {
  avatarUrl: string | null = null;
  displayName = '';
  email = 'user@example.com';
  phone = '';
  
  currentPassword = '';
  newPassword = '';
  confirmPassword = '';

  @ViewChild('fileInput') fileInput!: ElementRef<HTMLInputElement>;

  constructor(private snackBar: MatSnackBar) {}

  triggerFileInput() {
    this.fileInput.nativeElement.click();
  }

  onFileSelected(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.avatarUrl = e.target?.result as string;
      };
      reader.readAsDataURL(file);
    }
  }

  saveProfile() {
    // 實現儲存個人資料的邏輯
    this.snackBar.open('個人資料已更新', '關閉', { duration: 3000 });
  }

  changePassword() {
    if (this.newPassword !== this.confirmPassword) {
      this.snackBar.open('新密碼與確認密碼不符', '關閉', { duration: 3000 });
      return;
    }

    // 實現更改密碼的邏輯
    this.snackBar.open('密碼已更新', '關閉', { duration: 3000 });
    this.currentPassword = '';
    this.newPassword = '';
    this.confirmPassword = '';
  }
}
