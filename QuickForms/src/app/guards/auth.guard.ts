import { Injectable } from '@angular/core';
import { Router, UrlTree } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard {
  constructor(private authService: AuthService, private router: Router) {}

  canActivate(): boolean | UrlTree {
    if (this.authService.isLoggedIn()) {
      return true;
    }
    
    // 清除瀏覽器歷史記錄
    window.history.pushState(null, '', '/login');
    window.history.replaceState(null, '', '/login');
    window.history.go(1);
    
    // 儲存當前URL，登入後可以重定向回來
    return this.router.createUrlTree(['/login'], {
      queryParams: { returnUrl: this.router.url }
    });
  }
}
