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
      username: '超可愛管理者',
      email: 'abc123',
      password: 'abc123',
      displayName: '測試管理員',
      role: 'admin'
    },
    'test': {
      id: '2',
      username: 'test',
      email: 'test',
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
    // 清除用戶信息
    this.currentUser = null;
    // 清除本地存儲的令牌和用戶信息
    localStorage.removeItem('currentUser');
    localStorage.removeItem('token');
    localStorage.removeItem('userId');
    localStorage.removeItem('userName');
    localStorage.removeItem('userRole');
    // 清除路由歷史
    window.history.pushState(null, '', '/login');
window.history.replaceState(null, '', '/login');
window.history.go(1);
    // 返回空的 Observable
    return of(void 0);
  }

  getCurrentUser(): User | null {
    return this.currentUser;
  }

  isLoggedIn(): boolean {
    const savedUser = localStorage.getItem('currentUser');
    if (!savedUser) {
      this.currentUser = null;
      return false;
    }
    
    // 驗證本地存儲的用戶資訊是否與當前用戶一致
    const localUser = JSON.parse(savedUser);
    if (!this.currentUser || this.currentUser.id !== localUser.id) {
      this.currentUser = null;
      localStorage.removeItem('currentUser');
      localStorage.removeItem('token');
      localStorage.removeItem('userId');
      localStorage.removeItem('userName');
      localStorage.removeItem('userRole');
      return false;
    }
    
    return true;
  }
}
