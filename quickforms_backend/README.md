# QuickForms Backend

## 專案介紹

QuickForms Backend 是一個基於 Spring Boot 框架開發的問卷系統後端服務。本服務提供了完整的問卷管理功能，包括問卷的創建、編輯、發布、回收和統計分析等功能。

## 技術架構

- **框架**: Spring Boot
- **資料庫**: MySQL
- **專案管理**: Gradle
- **API文檔**: Swagger/OpenAPI

## 開發環境需求

- JDK 17 或以上
- MySQL 8.0 或以上
- Gradle 8.x

## 快速開始

### 1. 資料庫設置

1. 創建 MySQL 資料庫

```sql
CREATE DATABASE quickforms;
```

2. 執行資料庫初始化腳本

```bash
mysql -u your_username -p quickforms < DB/qf_db.sql
```

### 2. 配置應用

在 `src/main/resources/application.properties` 中配置資料庫連接：

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/quickforms
spring.datasource.username=your_username
spring.datasource.password=your_password
```

### 3. 編譯和運行

```bash
# 編譯專案
./gradlew build

# 運行應用
./gradlew bootRun
```

應用將在 http://localhost:8080 啟動

## API 文檔

### 主要 API 端點

#### 問卷管理

- `GET /api/questionnaires`: 獲取問卷列表
- `POST /api/questionnaires`: 創建新問卷
- `GET /api/questionnaires/{id}`: 獲取問卷詳情
- `PUT /api/questionnaires/{id}`: 更新問卷
- `POST /api/questionnaires/{id}/publish`: 發布問卷

#### 問卷回答

- `POST /api/responses/questionnaires/${id}`: 提交問卷答案
- `GET /api/statistics/questionnaire/{id}`: 獲取問卷統計數據

完整 API 文檔可在應用運行後訪問：http://localhost:8080/swagger-ui.html

## 專案結構

```
src/
  ├── main/
  │   ├── java/
  │   │   └── com/quickforms/
  │   │       ├── controllers/    # API 控制器
  │   │       ├── models/         # 資料模型
  │   │       ├── repositories/   # 資料庫操作
  │   │       ├── services/       # 業務邏輯
  │   │       └── config/         # 配置類
  │   └── resources/
  │       └── application.properties  # 應用配置
  └── test/                           # 測試代碼
```

## 貢獻指南

1. Fork 本專案
2. 創建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟 Pull Request

## 授權協議

MIT License
