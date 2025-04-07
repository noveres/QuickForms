
## 問卷管理 API

- **獲取問卷列表**: GET `http://localhost:8585/api/questionnaires`
- **獲取問卷詳情**: GET `http://localhost:8585/api/questionnaires/{id}`
- **創建問卷**: POST `http://localhost:8585/api/questionnaires`
- **更新問卷**: PUT `http://localhost:8585/api/questionnaires/{id}`
- **刪除問卷**: DELETE `http://localhost:8585/api/questionnaires/{id}`
- **發布問卷**: POST `http://localhost:8585/api/questionnaires/{id}/publish`
- **取消發布**: POST `http://localhost:8585/api/questionnaires/{id}/unpublish`
- **下架問卷**: POST `http://localhost:8585/api/questionnaires/{id}/out`
- **複製問卷**: POST `http://localhost:8585/api/questionnaires/{id}/copy`
- **獲取統計數據**: GET `http://localhost:8585/api/questionnaires/{id}/stats`

**問卷創建/更新格式示例**

```json
{
  "title": "訂單管理",
  "description": "管理客戶的訂單資訊",
  "status": "DRAFT",
  "sections": [
    {
      "title": "客戶資訊",
      "type": "text",
      "questions": [
        { "id": 1, "label": "客戶姓名", "type": "short-text", "required": true },
        { "id": 2, "label": "聯繫電話", "type": "phone", "required": true },
        { "id": 3, "label": "送貨地址", "type": "short-text", "required": true }
      ]
    },
    {
      "title": "訂單詳情",
      "type": "checkbox",
      "questions": [
        {
          "id": 4,
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
    }
  ],
  "settings": {
    "allowAnonymous": true,
    "requireLogin": false
  }
}
```

## 問卷回答 API

- **提交問卷回答**: POST `http://localhost:8585/api/responses/questionnaires/{id}`

**回答提交格式示例**

```json
{
  "answers": [
    {
      "questionId": 1,
      "answerValue": "張三"
    },
    {
      "questionId": 2,
      "answerValue": "0912345678"
    },
    {
      "questionId": 3,
      "answerValue": "台北市信義區信義路五段7號"
    },
    {
      "questionId": 4,
      "answerValue": "1,3"
    }
  ],
  "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}
```
