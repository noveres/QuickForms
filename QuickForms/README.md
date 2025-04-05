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
   ng serve --open
   ```
4. 打開瀏覽器訪問 `http://localhost:4200/`

## 4. 構建與部署

### 4.1 構建專案

```bash
ng build --prod
```

構建產物將存放在 `dist/` 目錄中。

### 4.2 部署架構

系統採用以下部署架構：

- 前端靜態資源部署在 Web 服務器
- 通過 API Gateway 連接後端服務
- 使用負載均衡器分發流量
- 主備數據庫確保數據安全

## 5. 系統架構

### 5.1 前後端架構

```
前端 (Angular) <-->  Request API <--> 後端 (Spring Boot) <--> 資料庫 (MySQL)
```

### 5.2 前端架構

- **組件 (Components)**: 用戶界面元素
- **服務 (Services)**: 業務邏輯和數據處理
- **守衛 (Guards)**: 路由保護和權限控制
- **模型 (Models)**: 數據模型定義

### 5.3 目錄結構

```
src/
  app/
    components/       # 共用組件
    guards/           # 路由守衛
    pages/            # 頁面組件
      auth/           # 登入認證相關頁面(僅前端)
        login/        # 登入頁面組件
      profile/        # 用戶資料頁面(僅前端)
      questionnaire/  # 問卷相關頁面
        answer/       # 問卷填寫頁面
        form/         # 問卷編輯頁面
        home/         # 問卷首頁
        list/         # 問卷列表頁
        statistics/   # 統計分析頁面
      support/        # 支援頁面
    shared/           # 共享資源
      @components/    # 共享組件
      @interface/     # 介面定義
      @services/      # 共享服務
  environments/       # 環境配置
```

## 6. 核心功能模塊

### 6.1 問卷管理

- **創建問卷**: 支持從頭創建或使用模板
- **編輯問卷**: 添加、修改、刪除問題和選項
- **預覽問卷**: 實時預覽問卷效果
- **發布問卷**: 將問卷狀態從草稿變更為已發布

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

### 7.2 問題模型

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

## 8. API 接口

### 8.1 問卷管理 API

- **獲取問卷列表**: GET `/api/questionnaires`
- **創建問卷**: POST `/api/questionnaires`
  **測試格式**

```json
{
  "title": "訂單管理",
  "description": "管理客戶的訂單資訊",
  "sections": [
    {
      "title": "客戶資訊",
      "type": "text",
      "questions": [
        { "label": "客戶姓名", "type": "short-text", "required": true },
        { "label": "聯繫電話", "type": "phone", "required": true },
        { "label": "送貨地址", "type": "short-text", "required": true }
      ]
    },
    {
      "title": "訂單詳情",
      "type": "checkbox",
      "questions": [
        {
          "label": "選擇商品",
          "type": "checkbox",
          "required": true,
          "options": {
            "choices": {
              "1": "筆記本電腦",
              "2": "無線耳機",
              "3": "手機支架"
            }
          }
        }
      ]
    },
    {
      "title": "支付方式",
      "type": "radio",
      "questions": [
        {
          "label": "請選擇支付方式",
          "type": "radio",
          "required": true,
          "options": {
            "choices": {
              "credit_card": "信用卡",
              "paypal": "PayPal",
              "bank_transfer": "銀行轉帳"
            }
          }
        }
      ]
    }
  ]
}

```

- **獲取問卷詳情**: GET `/api/questionnaires/{id}`
- **更新問卷**: PUT `/api/questionnaires/{id}`
- **發布問卷**: PATCH `/api/questionnaires/{id}/publish`
- **刪除問卷**: DELETE `/api/questionnaires/{id}`

### 8.2 問卷回答 API

- **提交問卷回答**: POST `api/responses/questionnaires/{id}`
  **測試格式**

```json
{

  "answers": [
    {
      "questionId": 1,
      "answerValue": "回答內容1"
    },
    {
      "questionId": 2,
      "answerValue": "回答內容2"
    },
    {
      "questionId": 3,
      "answerValue": "回答內容3"
    }
  ],
  "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}
}
```

- **獲取回答統計**: GET `/api/statistics/questionnaires/{id}`

## 9. 擴展系統

### 9.1 添加新的路由

在 `app.routes.ts` 中添加新路由：

```typescript
{
  path: 'your-new-path',
  canActivate: [AuthGuard], // 如果需要驗證
  loadComponent: () => import('./your-component')
    .then(m => m.YourComponent)
}
```

### 9.2 創建新的服務

```typescript
@Injectable({
  providedIn: 'root'
})
export class YourNewService {
  // 實現您的服務邏輯
}
```

### 9.3 添加新的問卷類型

### 9.3.1 添加新的問題類型

首先，我們需要在 `\src\app\pages\questionnaire`的問題類型選擇下拉選單中添加新的選項。
假設我們要添加一個「日期」問題類型：

```html
    <mat-form-field>
      <mat-select [formControl]="getControl(question, 'type')">
        <mat-option value="short-text">短文本</mat-option>
        <mat-option value="long-text">長文本</mat-option>
        <mat-option value="email">電子郵件</mat-option>
        <mat-option value="phone">電話</mat-option>
        <mat-option value="rating">評分</mat-option>
        <mat-option value="radio">單選</mat-option>
        <mat-option value="checkbox">多選</mat-option>
         <mat-option value="select">下拉選擇</mat-option>
         <mat-option value="date">日期</mat-option> //新增的類型
	   </mat-select>
     </mat-form-field>
```

### 9.3.2. 實現對應的渲染邏輯

接下來，我們需要在問題內容的 ngSwitch 中添加新的 case 來處理日期類型的渲染：

```html
                  <div class="question-content"
                   [ngSwitch]="getControl(question, 'type').value">
                    <!-- 現有的問題類型... -->
  
                    <!-- 日期類型 -->
                    <div *ngSwitchCase="'date'" class="date-container">
                      <div class="answer-frame" [class.required]="getControl(question,'required').value">
                        <div class="text-input-display date">
                          <mat-icon class="input-icon">calendar_today</mat-icon>
                          <div class="frame-hint">請選擇日期</div>
                          <div class="required-hint" 
                          *ngIf="getControl(question,'required').value">必填
                          </div>
                        </div>
                      </div>
                    </div>
  
```

### 9.3.3. 在 TypeScript 文件中更新問題類型定義

您還需要在相關的 TypeScript 文件中更新問題類型的定義。通常在 `question.models.ts` 文件中：

```typescript:e:\VS_Code\NG_SB_QF\QuickForms\src\app\shared@interface\question.models.ts
export interface Question {
  label: string;
  type: 'short-text' | 'long-text' | 'email' | 'phone' | 'rating' | 'radio' | 'checkbox' | 'select' | 'date';
  required: boolean;
  options?: {
    max?: number;
    choices?: Record<string, string>;
    placeholder?: string;
    allowOther?: boolean;
    multiple?: boolean;
    dateFormat?: string; // 新增日期格式選項
  };
  value?: any;
}
```

### 9.3.4. 在組件 TypeScript 文件中處理新問題類型的邏輯

在 `questionnaire-form.component.ts` 中，您需要更新 `initializeFormWithTemplate` 和其他相關方法來處理新的問題類型：

```typescript:e:\VS_Code\NG_SB_QF\QuickForms\src\app\pages\questionnaire\form\questionnaire-form.component.ts
private initializeFormWithTemplate(template: Template) {
  // 現有代碼...
  
  section.questions.forEach(question => {
    // 根據問題類型設置默認值
    let defaultValue: any = '';
    switch (question.type) {
      case 'rating':
        defaultValue = 0;
        break;
      case 'checkbox':
        defaultValue = [];
        break;
      case 'radio':
      case 'select':
        defaultValue = null;
        break;
      case 'date':
        defaultValue = null; // 日期類型的默認值
        break;
      default:
        defaultValue = '';
    }
  
    // 現有代碼...
  });
}
```

### 9.3.5. 添加相應的 CSS 樣式

最後，您可能需要在 `questionnaire-form.component.scss` 中添加新問題類型的樣式：

```scss:e:\VS_Code\NG_SB_QF\QuickForms\src\app\pages\questionnaire\form\questionnaire-form.component.scss
.date-container {
  margin-top: 10px;
  
  .text-input-display.date {
    display: flex;
    align-items: center;
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 4px;
  
    .input-icon {
      margin-right: 10px;
      color: #666;
    }
  }
}
```

以上步驟完成後，您就成功地在問卷模型中添加了新的問題類型（日期）並實現了對應的渲染邏輯。您可以按照類似的方式添加其他問題類型，如數字、時間、文件上傳等。

需要注意的是，如果新問題類型需要特殊的交互邏輯（如日期選擇器），還需要引入相應的 Angular Material 組件並實現相關的處理函數。

## 9.4. 在問卷組件中實現對應的渲染邏輯

### 9.4.1. 獲取問卷數據

首先，系統需要從後端獲取問卷數據：

```typescript
loadQuestionnaire(id: number): void {
  this.questionnaireService.getQuestionnaire(id).subscribe({
    next: (questionnaire) => {
      if (questionnaire) {
        this.questionnaire = questionnaire;
        this.initializeForm();
      }
    },
    error: (error) => {
      console.error('載入問卷失敗:', error);
    }
  });
}
```

### 9.4.2. 初始化回答表單

`src\app\pages\questionnaire\answer`
根據問卷結構動態創建表單：

```typescript
initializeForm(): void {
  // 創建主表單
  this.answerForm = this.fb.group({});
  
  // 為每個問題創建表單控件
  this.questionnaire.sections.forEach(section => {
    section.questions.forEach(question => {
      // 根據問題類型設置默認值
      let defaultValue: any = '';
      switch (question.type) {
        case 'rating':
          defaultValue = 0;
          break;
        case 'checkbox':
          defaultValue = [];
          break;
        case 'radio':
        case 'select':
          defaultValue = null;
          break;
        default:
          defaultValue = '';
      }
  
      // 添加表單控件
      this.answerForm.addControl(
        `question_${question.id}`,
        this.fb.control(defaultValue, question.required ? Validators.required : null)
      );
    });
  });
}
```

### 9.4.3. 渲染問卷界面

在模板中根據問題類型渲染不同的輸入控件：

```html
<div *ngFor="let section of questionnaire.sections">
  <h2>{{ section.title }}</h2>
  
  <div *ngFor="let question of section.questions">
    <div class="question-container" [ngSwitch]="question.type">
      <!-- 短文本 -->
      <mat-form-field *ngSwitchCase="'short-text'" class="full-width">
        <mat-label>{{ question.label }}</mat-label>
        <input matInput [formControlName]="'question_' + question.id">
        <mat-error *ngIf="isRequired(question.id)">此欄位為必填</mat-error>
      </mat-form-field>
  
      <!-- 長文本 -->
      <mat-form-field *ngSwitchCase="'long-text'" class="full-width">
        <mat-label>{{ question.label }}</mat-label>
        <textarea matInput [formControlName]="'question_' + question.id" rows="4"></textarea>
        <mat-error *ngIf="isRequired(question.id)">此欄位為必填</mat-error>
      </mat-form-field>
  
      <!-- 評分 -->
      <div *ngSwitchCase="'rating'" class="rating-container">
        <div class="question-label">{{ question.label }}</div>
        <mat-slider [max]="question.options?.max || 5" [step]="1" [thumbLabel]="true"
                   [formControlName]="'question_' + question.id"></mat-slider>
      </div>
  
      <!-- 單選 -->
      <div *ngSwitchCase="'radio'" class="radio-container">
        <div class="question-label">{{ question.label }}</div>
        <mat-radio-group [formControlName]="'question_' + question.id">
          <mat-radio-button *ngFor="let choice of question.options?.choices | keyvalue" 
                           [value]="choice.key">
            {{ choice.value }}
          </mat-radio-button>
        </mat-radio-group>
      </div>
  
      <!-- 其他問題類型... -->
    </div>
  </div>
</div>
```

### 9.4.4. 提交回答

當用戶完成問卷後，將回答數據提交到後端：

```typescript

   // 提交回答
      this.responseService.submitResponse(this.questionnaire.id, response).subscribe({
      next: () => {
        this.snackBar.open('問卷提交成功！', '關閉', { duration: 3000 });
        this.router.navigate(['/home']);
      },
      error: (error) => {
        console.error('提交問卷失敗:', error);
        this.snackBar.open('提交問卷失敗', '關閉', { duration: 3000 });
        this.isSubmitting = false;
      }
    });
  }
```

### 9.4.5. 表單驗證

實現表單驗證以確保必填欄位已填寫：

```typescript
 onSubmit() {
    if (this.isSubmitting || !this.questionnaire) return;

    this.markFormGroupTouched(this.answerForm);
  
    if (this.answerForm.invalid) {
      this.snackBar.open('請填寫所有必填項目', '關閉', { duration: 3000 });
      return;
    }

    this.isSubmitting = true;

    // 收集所有答案
    const answers: QuestionAnswerDTO[] = [];
    this.questionnaire.sections.forEach((section, sectionIndex) => {
      section.questions.forEach((question, questionIndex) => {
        const questionControl = this.getQuestionControls(sectionIndex)[questionIndex];
        const answer = questionControl.get('answer')?.value;
      
        // 如果是複選框，需要將選中的選項組合成字符串
        if (question.type === 'checkbox' && Array.isArray(answer)) {
          answers.push({
            questionId: question.id,
            answerValue: answer.join(',')
          });
        } else {
          answers.push({
            questionId: question.id,
            answerValue: answer?.toString() || ''
          });
        }
      });
    });
```

## 技術亮點

1. **動態表單生成**：根據問卷結構動態創建表單控件
2. **類型適配**：為不同問題類型提供適合的輸入控件
3. **響應式設計**：使用 Angular 的響應式表單進行狀態管理
4. **數據轉換**：將表單數據轉換為後端需要的格式
5. **用戶體驗優化**：提供表單驗證和錯誤提示

這種實現方式使得問卷回答功能既靈活又易於維護，能夠適應各種類型的問卷需求。

## 11. 最佳實踐

### 11.1 代碼組織

- 相關功能放在同一目錄下
- 使用適當的命名約定
- 保持組件的單一職責

### 11.2 安全性考慮

- 驗證所有用戶輸入
- 透過**User-Agent** 字串分析使用者設備驗證用戶端來源

### 11.3 性能優化

- 使用懶加載
- 實現適當的緩存策略
- 優化數據結構

```

```

### 7.2 問題模型

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

## 8. API 接口

### 8.1 問卷管理 API

- **獲取問卷列表**: GET `/api/questionnaires`
- **創建問卷**: POST `/api/questionnaires`
  **測試格式**

```json
{
  "title": "訂單管理",
  "description": "管理客戶的訂單資訊",
  "sections": [
    {
      "title": "客戶資訊",
      "type": "text",
      "questions": [
        { "label": "客戶姓名", "type": "short-text", "required": true },
        { "label": "聯繫電話", "type": "phone", "required": true },
        { "label": "送貨地址", "type": "short-text", "required": true }
      ]
    },
    {
      "title": "訂單詳情",
      "type": "checkbox",
      "questions": [
        {
          "label": "選擇商品",
          "type": "checkbox",
          "required": true,
          "options": {
            "choices": {
              "1": "筆記本電腦",
              "2": "無線耳機",
              "3": "手機支架"
            }
          }
        }
      ]
    },
    {
      "title": "支付方式",
      "type": "radio",
      "questions": [
        {
          "label": "請選擇支付方式",
          "type": "radio",
          "required": true,
          "options": {
            "choices": {
              "credit_card": "信用卡",
              "paypal": "PayPal",
              "bank_transfer": "銀行轉帳"
            }
          }
        }
      ]
    }
  ]
}

```

- **獲取問卷詳情**: GET `/api/questionnaires/{id}`
- **更新問卷**: PUT `/api/questionnaires/{id}`
- **發布問卷**: PATCH `/api/questionnaires/{id}/publish`
- **刪除問卷**: DELETE `/api/questionnaires/{id}`

### 8.2 問卷回答 API

- **提交問卷回答**: POST `api/responses/questionnaires/{id}`
  **測試格式**

```json
{

  "answers": [
    {
      "questionId": 1,
      "answerValue": "回答內容1"
    },
    {
      "questionId": 2,
      "answerValue": "回答內容2"
    },
    {
      "questionId": 3,
      "answerValue": "回答內容3"
    }
  ],
  "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}
}
```

- **獲取回答統計**: GET `/api/statistics/questionnaires/{id}`

## 9. 擴展系統

### 9.1 添加新的路由

在 `app.routes.ts` 中添加新路由：

```typescript
{
  path: 'your-new-path',
  canActivate: [AuthGuard], // 如果需要驗證
  loadComponent: () => import('./your-component')
    .then(m => m.YourComponent)
}
```

### 9.2 創建新的服務

```typescript
@Injectable({
  providedIn: 'root'
})
export class YourNewService {
  // 實現您的服務邏輯
}
```

### 9.3 添加新的問卷類型

### 9.3.1 添加新的問題類型

首先，我們需要在 `\src\app\pages\questionnaire`的問題類型選擇下拉選單中添加新的選項。
假設我們要添加一個「日期」問題類型：

```html
    <mat-form-field>
      <mat-select [formControl]="getControl(question, 'type')">
        <mat-option value="short-text">短文本</mat-option>
        <mat-option value="long-text">長文本</mat-option>
        <mat-option value="email">電子郵件</mat-option>
        <mat-option value="phone">電話</mat-option>
        <mat-option value="rating">評分</mat-option>
        <mat-option value="radio">單選</mat-option>
        <mat-option value="checkbox">多選</mat-option>
         <mat-option value="select">下拉選擇</mat-option>
         <mat-option value="date">日期</mat-option> //新增的類型
	   </mat-select>
     </mat-form-field>
```

### 9.3.2. 實現對應的渲染邏輯

接下來，我們需要在問題內容的 ngSwitch 中添加新的 case 來處理日期類型的渲染：

```html
                  <div class="question-content"
                   [ngSwitch]="getControl(question, 'type').value">
                    <!-- 現有的問題類型... -->
            
                    <!-- 日期類型 -->
                    <div *ngSwitchCase="'date'" class="date-container">
                      <div class="answer-frame" [class.required]="getControl(question, 'required').value">
                        <div class="text-input-display date">
                          <mat-icon class="input-icon">calendar_today</mat-icon>
                          <div class="frame-hint">請選擇日期</div>
                          <div class="required-hint" 
                          *ngIf="getControl(question,'required').value">必填
                          </div>
                        </div>
                      </div>
                    </div>
            
                    <!-- 其他現有的問題類型... -->
                    <!-- 其他現有的問題類型... -->
```

### 9.3.3. 在 TypeScript 文件中更新問題類型定義

您還需要在相關的 TypeScript 文件中更新問題類型的定義。通常在 `question.models.ts` 文件中：

```typescript:e:\VS_Code\NG_SB_QF\QuickForms\src\app\shared@interface\question.models.ts
export interface Question {
  label: string;
  type: 'short-text' | 'long-text' | 'email' | 'phone' | 'rating' | 'radio' | 'checkbox' | 'select' | 'date';
  required: boolean;
  options?: {
    max?: number;
    choices?: Record<string, string>;
    placeholder?: string;
    allowOther?: boolean;
    multiple?: boolean;
    dateFormat?: string; // 新增日期格式選項
  };
  value?: any;
}
```

### 9.3.4. 在組件 TypeScript 文件中處理新問題類型的邏輯

在 `questionnaire-form.component.ts` 中，您需要更新 `initializeFormWithTemplate` 和其他相關方法來處理新的問題類型：

```typescript:e:\VS_Code\NG_SB_QF\QuickForms\src\app\pages\questionnaire\form\questionnaire-form.component.ts
private initializeFormWithTemplate(template: Template) {
  // 現有代碼...
  
  section.questions.forEach(question => {
    // 根據問題類型設置默認值
    let defaultValue: any = '';
    switch (question.type) {
      case 'rating':
        defaultValue = 0;
        break;
      case 'checkbox':
        defaultValue = [];
        break;
      case 'radio':
      case 'select':
        defaultValue = null;
        break;
      case 'date':
        defaultValue = null; // 日期類型的默認值
        break;
      default:
        defaultValue = '';
    }
  
    // 現有代碼...
  });
}
```

### 9.3.5. 添加相應的 CSS 樣式

最後，您可能需要在 `questionnaire-form.component.scss` 中添加新問題類型的樣式：

```scss:e:\VS_Code\NG_SB_QF\QuickForms\src\app\pages\questionnaire\form\questionnaire-form.component.scss
.date-container {
  margin-top: 10px;
  
  .text-input-display.date {
    display: flex;
    align-items: center;
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 4px;
  
    .input-icon {
      margin-right: 10px;
      color: #666;
    }
  }
}
```

以上步驟完成後，您就成功地在問卷模型中添加了新的問題類型（日期）並實現了對應的渲染邏輯。您可以按照類似的方式添加其他問題類型，如數字、時間、文件上傳等。

需要注意的是，如果新問題類型需要特殊的交互邏輯（如日期選擇器），還需要引入相應的 Angular Material 組件並實現相關的處理函數。

## 9.4. 在問卷組件中實現對應的渲染邏輯

### 9.4.1. 獲取問卷數據

首先，系統需要從後端獲取問卷數據：

```typescript
loadQuestionnaire(id: number): void {
  this.questionnaireService.getQuestionnaire(id).subscribe({
    next: (questionnaire) => {
      if (questionnaire) {
        this.questionnaire = questionnaire;
        this.initializeForm();
      }
    },
    error: (error) => {
      console.error('載入問卷失敗:', error);
    }
  });
}
```

### 9.4.2. 初始化回答表單

`src\app\pages\questionnaire\answer`
根據問卷結構動態創建表單：

```typescript
initializeForm(): void {
  // 創建主表單
  this.answerForm = this.fb.group({});
  
  // 為每個問題創建表單控件
  this.questionnaire.sections.forEach(section => {
    section.questions.forEach(question => {
      // 根據問題類型設置默認值
      let defaultValue: any = '';
      switch (question.type) {
        case 'rating':
          defaultValue = 0;
          break;
        case 'checkbox':
          defaultValue = [];
          break;
        case 'radio':
        case 'select':
          defaultValue = null;
          break;
        default:
          defaultValue = '';
      }
  
      // 添加表單控件
      this.answerForm.addControl(
        `question_${question.id}`,
        this.fb.control(defaultValue, question.required ? Validators.required : null)
      );
    });
  });
}
```

### 9.4.3. 渲染問卷界面

在模板中根據問題類型渲染不同的輸入控件：

```html
<div *ngFor="let section of questionnaire.sections">
  <h2>{{ section.title }}</h2>
  
  <div *ngFor="let question of section.questions">
    <div class="question-container" [ngSwitch]="question.type">
      <!-- 短文本 -->
      <mat-form-field *ngSwitchCase="'short-text'" class="full-width">
        <mat-label>{{ question.label }}</mat-label>
        <input matInput [formControlName]="'question_' + question.id">
        <mat-error *ngIf="isRequired(question.id)">此欄位為必填</mat-error>
      </mat-form-field>
  
      <!-- 長文本 -->
      <mat-form-field *ngSwitchCase="'long-text'" class="full-width">
        <mat-label>{{ question.label }}</mat-label>
        <textarea matInput [formControlName]="'question_' + question.id" rows="4"></textarea>
        <mat-error *ngIf="isRequired(question.id)">此欄位為必填</mat-error>
      </mat-form-field>
  
      <!-- 評分 -->
      <div *ngSwitchCase="'rating'" class="rating-container">
        <div class="question-label">{{ question.label }}</div>
        <mat-slider [max]="question.options?.max || 5" [step]="1" [thumbLabel]="true"
                   [formControlName]="'question_' + question.id"></mat-slider>
      </div>
  
      <!-- 單選 -->
      <div *ngSwitchCase="'radio'" class="radio-container">
        <div class="question-label">{{ question.label }}</div>
        <mat-radio-group [formControlName]="'question_' + question.id">
          <mat-radio-button *ngFor="let choice of question.options?.choices | keyvalue" 
                           [value]="choice.key">
            {{ choice.value }}
          </mat-radio-button>
        </mat-radio-group>
      </div>
  
      <!-- 其他問題類型... -->
    </div>
  </div>
</div>
```

### 9.4.4. 提交回答

當用戶完成問卷後，將回答數據提交到後端：

```typescript
submitAnswers(): void {
  if (this.answerForm.valid) {
    const formValue = this.answerForm.value;
  
    // 轉換為後端需要的格式
    const answers: QuestionAnswerDTO[] = Object.keys(formValue).map(key => {
      const questionId = parseInt(key.replace('question_', ''));
      return {
        questionId: questionId,
        answerValue: formValue[key]
      };
    });
  
    // 提交回答
    this.questionnaireService.submitAnswers(this.questionnaire.id, answers)
      .subscribe({
        next: () => {
          this.snackBar.open('回答已提交，謝謝您的參與！', '關閉', { duration: 3000 });
          this.router.navigate(['/thank-you']);
        },
        error: (error) => {
          console.error('提交回答失敗:', error);
          this.snackBar.open('提交失敗，請稍後再試', '關閉', { duration: 3000 });
        }
      });
  } else {
    this.snackBar.open('請填寫所有必填欄位', '關閉', { duration: 3000 });
    this.markAllAsTouched();
  }
}
```

### 9.4.5. 表單驗證

實現表單驗證以確保必填欄位已填寫：

```typescript
markAllAsTouched(): void {
  Object.keys(this.answerForm.controls).forEach(key => {
    this.answerForm.get(key)?.markAsTouched();
  });
}

isRequired(questionId: number): boolean {
  const control = this.answerForm.get(`question_${questionId}`);
  return control?.hasError('required') && control.touched;
}
```

## 技術亮點

1. **動態表單生成**：根據問卷結構動態創建表單控件
2. **類型適配**：為不同問題類型提供適合的輸入控件
3. **響應式設計**：使用 Angular 的響應式表單進行狀態管理
4. **數據轉換**：將表單數據轉換為後端需要的格式
5. **用戶體驗優化**：提供表單驗證和錯誤提示

這種實現方式使得問卷回答功能既靈活又易於維護，能夠適應各種類型的問卷需求。

## 11. 最佳實踐

### 11.1 代碼組織

- 相關功能放在同一目錄下
- 使用適當的命名約定
- 保持組件的單一職責

### 11.2 安全性考慮

- 驗證所有用戶輸入
- 透過**User-Agent** 字串分析使用者設備驗證用戶端來源

### 11.3 性能優化

- 使用懶加載
- 實現適當的緩存策略
- 優化數據結構
