# QuickForms 問卷系統

## 專案介紹

QuickForms 是一個類似Google表單的現代化問卷調查系統，採用前後端分離架構設計。系統提供直觀的用戶界面，支持問卷的創建、編輯、發布、回收和統計分析等完整功能。

## 系統架構

### 前端 (QuickForms)

- **框架**: Angular 19.0.2
- **UI庫**: Angular Material
- **狀態管理**: RxJS

### 後端 (quickforms_backend)

- **框架**: Spring Boot
- **資料庫**: MySQL 8.0
- **專案管理**: Gradle
- **API文檔**: Swagger/OpenAPI

## 快速開始

### 1. 資料庫設置

1. 創建 MySQL 資料庫

```sql
CREATE DATABASE quickforms;
```

2. 執行資料庫初始化腳本

```bash
mysql -u your_username -p quickforms < DB/quickforms_db.sql
```

### 2. 啟動後端服務

1. 配置資料庫連接
2. 編譯並運行

```bash
cd quickforms_backend
./gradlew bootRun
```

後端服務將在 http://localhost:8585 啟動

### 3. 啟動前端應用

1. 安裝依賴

```bash
cd QuickForms
npm install
```

2. 運行開發服務器

```bash
ng serve
```

前端應用將在 http://localhost:4200 啟動

## 子專案文檔

- [前端文檔](QuickForms/README.md)
- [後端文檔](quickforms_backend/README.md)

## 系統功能

### 問卷管理

- 問卷創建與編輯
- 多種題型支持
- 問卷發布與關閉
- 問卷模板管理

### 數據收集與分析

- 問卷回答收集
- 實時數據統計
- 可視化圖表展示

### 後期可拓展
- 數據導出功能
- 自然語言生成問卷
- 串接Google API更方便結合現有服務

## 授權協議

MIT License
