
# QuickForms 前端專案技術文檔

## 1. 專案介紹

QuickForms 是一個基於 Angular 框架開發的現代化問卷系統前端應用。本應用提供了直觀的用戶界面，支持問卷的創建、編輯、發布和數據統計等功能，旨在幫助用戶快速創建和管理各類問卷調查。

## 2. 技術架構

- **前端框架**: Angular 19.0.2
- **UI庫**: Angular Material
- **狀態管理**: RxJS
- **開發工具**: Angular CLI
- **版本控制**: Git
- **構建工具**: Webpack (通過 Angular CLI)

## 3. 系統架構

### 3.1 前後端架構

```
前端 (Angular) <--> API Layer <--> 後端 (Spring Boot) <--> 數據庫 (MySQL)
```

### 3.2 前端架構

- **組件 (Components)**: 用戶界面元素
- **服務 (Services)**: 業務邏輯和數據處理
- **守衛 (Guards)**: 路由保護和權限控制
- **模型 (Models)**: 數據模型定義

### 3.3 目錄結構

```
src/
  app/
    components/       # 共用組件
    guards/           # 路由守衛
    pages/            # 頁面組件
      auth/           # 認證相關頁面
      profile/        # 用戶資料頁面
      questionnaire/  # 問卷相關頁面
      support/        # 支援頁面
    services/         # 服務
    shared/           # 共享資源
      @components/    # 共享組件
      @interface/     # 介面定義
      @services/      # 共享服務
  environments/       # 環境配置
```

## 4. 核心功能模塊

### 4.1 問卷管理

- **創建問卷**: 支持從頭創建或使用模板
- **編輯問卷**: 添加、修改、刪除問題和選項
- **預覽問卷**: 實時預覽問卷效果
- **發布問卷**: 將問卷狀態從草稿變更為已發布

### 4.2 問卷填寫

- **填寫界面**: 響應式設計，支持多種設備
- **數據驗證**: 客戶端表單驗證
- **提交答案**: 將用戶回答提交到後端

### 4.3 數據統計

- **回答統計**: 統計問卷回答數據
- **數據可視化**: 使用圖表展示統計結果
- **報告導出**: 支持導出統計報告

## 5. 路由結構

### 5.1 公開路由

- `/login`: 登入頁面
- `/questionnaires/answer/:id`: 問卷填寫頁面（無需登入）

### 5.2 需要驗證的路由

- `/home`: 首頁
- `/questionnaires/list`: 問卷列表
- `/questionnaires/new`: 新建問卷
- `/questionnaires/edit/:id`: 編輯問卷
- `/questionnaires/statistics/:id`: 問卷統計
- `/profile`: 個人資料

## 6. 數據模型

### 6.1 問卷模型

```typescript
interface Questionnaire {
  id: string;
  title: string;
  description?: string;
  status: 'DRAFT' | 'PUBLISHED' | 'CLOSED';
  sections: Section[];
  createdAt: Date;
  updatedAt: Date;
  publishedAt?: Date;
}
```

### 6.2 問題模型

```typescript
interface Question {
  id: string;
  type: 'TEXT' | 'TEXTAREA' | 'RADIO' | 'CHECKBOX' | 'SELECT' | 'DATE' | 'TIME' | 'RATING';
  label: string;
  required: boolean;
  options?: Option[];
  validationRules?: any;
}
```

## 7. API 接口

### 7.1 問卷管理 API

- **獲取問卷列表**: GET `/api/questionnaires`
- **創建問卷**: POST `/api/questionnaires`
- **獲取問卷詳情**: GET `/api/questionnaires/{id}`
- **更新問卷**: PUT `/api/questionnaires/{id}`
- **發布問卷**: PATCH `/api/questionnaires/{id}/publish`
- **刪除問卷**: DELETE `/api/questionnaires/{id}`

### 7.2 問卷回答 API

- **提交問卷回答**: POST `/api/questionnaires/{id}/responses`
- **獲取回答統計**: GET `/api/statistics/questionnaires/{id}`

## 8. 開發環境設置

### 8.1 環境需求

- Node.js 18.x 或以上
- npm 9.x 或以上
- Angular CLI 19.0.2

### 8.2 安裝步驟

1. 克隆代碼庫

   ```bash
   git clone [repository-url]
   cd QuickForms
   ```
2. 安裝依賴

   ```bash
   npm install
   ```
3. 啟動開發服務器

   ```bash
   ng serve
   ```
4. 打開瀏覽器訪問 `http://localhost:4200/`

## 9. 構建與部署

### 9.1 構建專案

```bash
ng build --prod
```

構建產物將存放在 `dist/` 目錄中。

### 9.2 部署架構

系統採用以下部署架構：

- 前端靜態資源部署在 Web 服務器
- 通過 API Gateway 連接後端服務
- 使用負載均衡器分發流量
- 主備數據庫確保數據安全

## 10. 擴展系統

### 10.1 添加新的路由

在 `app.routes.ts` 中添加新路由：

```typescript
{
  path: 'your-new-path',
  canActivate: [AuthGuard], // 如果需要驗證
  loadComponent: () => import('./your-component')
    .then(m => m.YourComponent)
}
```

### 10.2 創建新的服務

```typescript
@Injectable({
  providedIn: 'root'
})
export class YourNewService {
  // 實現您的服務邏輯
}
```

### 10.3 添加新的問卷類型

1. 在問卷模型中添加新的問題類型
2. 在表單組件中實現對應的渲染邏輯

## 11. 最佳實踐

### 11.1 代碼組織

- 相關功能放在同一目錄下
- 使用適當的命名約定
- 保持組件的單一職責

### 11.2 安全性考慮

- 敏感數據不要存儲在前端
- 使用適當的權限控制
- 驗證所有用戶輸入

### 11.3 性能優化

- 使用懶加載
- 實現適當的緩存策略
- 優化數據結構

## 12. 常見問題解決

### 12.1 頁面刷新後登出

- 確保 localStorage 中保存了用戶信息
- 檢查 AuthService 是否正確初始化

### 12.2 表單數據丟失

- 實現自動保存功能
- 使用 localStorage 存儲草稿

### 12.3 權限問題

- 檢查路由守衛配置
- 確認用戶角色權限設置
