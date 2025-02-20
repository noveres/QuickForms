import { Injectable } from '@angular/core';
import { Observable, of, throwError } from 'rxjs';
import { delay } from 'rxjs/operators';

export interface User {
  id: string;
  username: string;
  email: string;
  displayName: string;
  role: string;
  avatar?: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private currentUser: User | null = null;
  
  // 測試帳戶列表
  // key 是 email 或 username,value 是一個包含 email 和 password 的 object
  //後期接入API後可刪除，但格式必須保留
  private readonly TEST_USERS: { [key: string]: User & { password: string } } = {
    'admin': {
      id: '1',
      username: 'admin',
      email: 'andrew901117@gmail.com',
      password: 'andrew123',
      displayName: '管理員',
      role: 'admin'
    },
    'test': {
      id: '2',
      username: 'test',
      email: 'test@example.com',
      password: 'test123',
      displayName: '測試用戶',
      role: 'user'
    }
  };

  

  constructor() {
       // 從 localStorage 恢復用戶狀態
       const savedUser = localStorage.getItem('currentUser');
       if (savedUser) {
         this.currentUser = JSON.parse(savedUser);
       }
  }



  login(email: string, password: string): Observable<User> {
    // 尋找匹配的用戶
    const user = Object.values(this.TEST_USERS).find(u => 
      (u.email === email || u.username === email) && u.password === password
    );

    if (user) {
      // 創建一個不包含密碼的用戶對象
      const { password: _, ...userWithoutPassword } = user;
      this.currentUser = userWithoutPassword;
      // 保存到 localStorage
      localStorage.setItem('currentUser', JSON.stringify(userWithoutPassword));
      return of(userWithoutPassword).pipe(delay(1000));
    }
    return throwError(() => new Error('帳號或密碼錯誤'));
  }

  logout(): Observable<void> {
    this.currentUser = null;
    localStorage.removeItem('currentUser');
    return of(void 0);
  }

  getCurrentUser(): User | null {
    return this.currentUser;
  }

  isLoggedIn(): boolean {
    return this.currentUser !== null;
  }
}
