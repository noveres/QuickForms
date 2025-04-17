# QuickForms 前端專案技術文檔

## 1. 專案介紹

QuickForms 是一個基於 Angular 框架開發的現代化問卷系統前端應用。本應用提供了直觀的用戶界面，支持問卷的創建、編輯、發布和數據統計等功能，旨在幫助用戶快速創建和管理各類問卷調查。

## 2. 技術架構

- **前端框架**: Angular 19.0.0
- **UI庫**: Angular Material 19.1.2
- **狀態管理**: RxJS 7.8.0
- **圖表庫**: Chart.js 4.4.7 與 ng2-charts 8.0.0
- **開發工具**: Angular CLI 19.0.2
- **版本控制**: Git
- **構建工具**: Webpack (通過 Angular CLI)

## 3. 開發環境設置

### 3.1 環境需求

- Node.js 21.x 或以上
- npm 9.x 或以上
- Angular CLI 19.0.2

### 3.2 安裝步驟

1. 克隆代碼庫

   ```bash
   git clone https://github.com/noveres/QuickForms.git
   cd QuickForms
   ```
2. 安裝依賴

   ```bash
   npm install
   ```
3. 啟動開發服務器

   ```bash
   npm start
   ```
4. 打開瀏覽器訪問 `http://localhost:4200/`

## 4. 構建與部署

### 4.1 構建專案

```bash
ng build
```

構建產物將存放在 `dist/` 目錄中。

### 4.2 部署架構

系統採用以下部署架構：

- 前端靜態資源部署在 Web 服務器
- 通過 API Gateway 連接後端服務
- 主備數據庫確保數據安全

## 5. 系統架構

### 5.1 前後端架構

```
前端 (Angular) <-->  API (http://localhost:8585/api) <--> 後端 (Spring Boot) <--> 資料庫 (MySQL)
```

### 5.2 前端架構

- **組件 (Components)**: 用戶界面元素
- **服務 (Services)**: 業務邏輯和數據處理
- **守衛 (Guards)**: 路由保護和權限控制
- **模型 (Models)**: 數據模型定義

### 5.3 目錄結構

```
src/
├── app/
│   ├── components/           # 共用組件
│   ├── guards/               # 路由守衛
│   ├── pages/                # 頁面組件
│   │   ├── auth/             # 登入認證相關頁面
│   │   │   └── login/        # 登入頁面組件
│   │   ├── profile/          # 用戶資料頁面
│   │   └── questionnaire/    # 問卷相關頁面
│   │       ├── answer/       # 問卷填寫頁面
│   │       ├── form/         # 問卷編輯頁面
│   │       ├── home/         # 問卷首頁
│   │       ├── list/         # 問卷列表頁
│   │       ├── services/     # 問卷相關服務
│   │       └── statistics/   # 統計分析頁面
│   └── support/              # 支援頁面
├── shared/                   # 共享資源
│   ├── @interface/           # 介面定義
│   ├── @services/            # 共享服務
│   └── components/           # 共享組件
└── environments/             # 環境配置

```

## 6. 核心功能模塊

### 6.1 問卷管理

- **創建問卷**: 支持從頭創建或使用模板
- **編輯問卷**: 添加、修改、刪除問題和選項
- **預覽問卷**: 實時預覽問卷效果
- **發布問卷**: 將問卷狀態從草稿變更為已發布
- **複製問卷**: 複製現有問卷作為新問卷
- **自動保存**: 自動保存問卷編輯進度

### 6.2 問卷填寫

- **填寫界面**: 響應式設計，支持多種設備
- **數據驗證**: 客戶端表單驗證
- **提交答案**: 將用戶回答提交到後端

### 6.3 數據統計

- **回答統計**: 統計問卷回答數據
- **數據可視化**: 使用圖表展示統計結果

## 7. 數據模型

### 7.1 問卷模型

```typescript
interface Questionnaire {
  id: number;
  title: string;
  description?: string;
  status?: 'DRAFT' | 'PUBLISHED'| 'CLOSED';
  sections: Section[];
  settings?: QuestionnaireSettings;
  content?: string | QuestionnaireContent; // 可以是 JSON 字符串或解析後的對象
  responseCount?: number;
  createdAt?: string;
  updatedAt?: string;
  createdBy?: string;
  updatedBy?: string;
  displayIndex?: number;
}
```

### 7.2 問題模型

```typescript
interface Question {
  id: number;
  label: string;
  type: string; // 'short-text', 'long-text', 'email', 'phone', 'rating', 'radio', 'checkbox', 'select', 'date' 等
  required: boolean;
  options?: QuestionOption;
  value?: any;
}

interface QuestionOption {
  min?: number;
  max?: number;
  choices?: Record<string, string>;
  placeholder?: string;
  allowOther?: boolean;
  multiple?: boolean;
}
```

### 7.3 回答模型

```typescript
interface QuestionAnswerDTO {
  questionId: number;
  answerValue: string;
}

interface QuestionnaireResponseDTO {
  answers: QuestionAnswerDTO[];
  respondentId?: string;
  ipAddress?: string;
  userAgent?: string;
}
```

## 8. API 接口

請參閱：[API文檔](https://github.com/noveres/QuickForms/blob/main/docs/api/API%E6%96%87%E6%AA%94.md)

## 9. 路由配置

系統使用 Angular 的懶加載路由機制，主要路由如下：

```typescript
// 公開路由
{
  path: 'login',
  component: LoginComponent
},
{
  path: 'questionnaires/answer/:id',
  loadComponent: () => import('./pages/questionnaire/answer/questionnaire-answer.component')
    .then(m => m.QuestionnaireAnswerComponent)
},

// 需要驗證的路由
{
  path: '',
  canActivate: [AuthGuard],
  children: [
    {
      path: 'home',
      loadComponent: () => import('./pages/questionnaire/home/home.component')
        .then(m => m.HomeComponent)
    },
    {
      path: 'questionnaires',
      loadChildren: () => [
        {
          path: 'list',
          loadComponent: () => import('./pages/questionnaire/list/list.component')
            .then(m => m.QuestionnaireListComponent)
        },
        {
          path: 'new',
          loadComponent: () => import('./pages/questionnaire/form/questionnaire-form.component')
            .then(m => m.QuestionnaireFormComponent)
        },
        {
          path: 'edit/:id',
          loadComponent: () => import('./pages/questionnaire/form/questionnaire-form.component')
            .then(m => m.QuestionnaireFormComponent)
        },
        {
          path: 'statistics/:id',
          loadComponent: () => import('./pages/questionnaire/statistics/statistics.component')
            .then(m => m.StatisticsComponent)
        }
      ]
    },
    {
      path: 'profile',
      loadComponent: () => import('./pages/profile/profile.component')
        .then(m => m.ProfileComponent)
    },
    {
      path: 'support',
      loadComponent: () => import('./pages/support/support.component')
        .then(m => m.SupportComponent)
    }
  ]
}
```

## 10. 擴展系統

### 10.1 添加新的問題類型

要添加新的問題類型，需要進行以下步驟：

1. 在 `question.models.ts` 中更新問題類型定義
2. 在問卷編輯頁面的問題類型選擇下拉選單中添加新選項
3. 在問卷編輯頁面的 ngSwitch 中添加新的 case 來處理新類型的渲染
4. 在問卷填寫頁面添加對應的輸入控件和數據處理邏輯
5. 更新相關的表單處理和數據轉換邏輯

### 10.2 添加新的路由

在 `app.routes.ts` 中添加新路由：

```typescript
{
  path: 'your-new-path',
  canActivate: [AuthGuard], // 如果需要驗證
  loadComponent: () => import('./your-component')
    .then(m => m.YourComponent)
}
```

### 10.3 創建新的服務

```typescript
@Injectable({
  providedIn: 'root'
})
export class YourNewService {
  private readonly API_URL = 'http://localhost:8585/api';
  
  constructor(private http: HttpClient) {}
  
  // 實現您的服務邏輯
}
```

## 11. 最佳實踐

### 11.1 代碼組織

- 相關功能放在同一目錄下
- 使用適當的命名約定
- 保持組件的單一職責
- 使用懶加載提高性能

### 11.2 安全性考慮

- 使用 AuthGuard 保護需要驗證的路由
- 驗證所有用戶輸入
- 透過 User-Agent 字串分析使用者設備驗證用戶端來源

### 11.3 性能優化

- 使用懶加載減少初始加載時間
- 實現適當的緩存策略
- 優化數據結構和渲染邏輯
- 使用 OnPush 變更檢測策略減少不必要的渲染
