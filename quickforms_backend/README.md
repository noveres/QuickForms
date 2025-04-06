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
- IDE 建議：IntelliJ IDEA 或 Eclipse
- Git 版本控制
- Postman 或其他 API 測試工具

### 環境配置步驟

1. **JDK 安裝與配置**
   - 下載並安裝 JDK 17
   - 設置 JAVA_HOME 環境變數
   - 將 Java 執行檔路徑添加到 PATH

2. **MySQL 安裝與配置**
   - 安裝 MySQL 8.0
   - 創建專用數據庫用戶
   - 設置適當的訪問權限

3. **IDE 配置**
   - 安裝 Lombok 插件
   - 配置 Gradle 整合
   - 設置項目編碼為 UTF-8

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

完整 API 文檔可在應用運行後訪問：http://localhost:8585/swagger-ui.html

## 錯誤處理和故障排除

### 常見問題解決方案

1. **應用啟動失敗**
   - 檢查 MySQL 服務是否正常運行
   - 驗證數據庫連接配置是否正確
   - 確認端口 8585 未被佔用

2. **API 調用失敗**
   - 檢查請求格式和參數
   - 確認 Token 是否有效
   - 查看服務器日誌獲取詳細錯誤信息

3. **性能問題**
   - 檢查數據庫索引使用情況
   - 監控 JVM 內存使用
   - 優化大量數據查詢

## 測試指南

### 單元測試
- 使用 JUnit 5 編寫測試用例
- 運行測試：`./gradlew test`
- 查看測試報告：`build/reports/tests`

## 專案結構

```
src/
  ├── main/
  │   ├── java/
  │   │   └── com/quickforms/
  │   │       ├── controllers/    # API 控制器
  │   │       ├── entity/         # 資料模型
  │   │       ├── repositories/   # 資料庫操作
  │   │       ├── services/       # 業務邏輯
  │   │       ├── dto/            # 數據傳輸對象
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
