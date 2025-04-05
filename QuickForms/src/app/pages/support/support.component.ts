import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatDividerModule } from '@angular/material/divider';

@Component({
  selector: 'app-support',
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatDividerModule
  ],
  templateUrl: './support.component.html',
  styleUrls: ['./support.component.scss']
})
export class SupportComponent {
  faqs = [
    {
      question: '如何創建新的問卷？',
      answer: '點擊首頁的「新增問卷」按鈕，選擇適合的模板或從頭開始創建。'
    },
    {
      question: '如何分享問卷給受訪者？',
      answer: '在問卷編輯頁面點擊「分享」按鈕，系統會自動生成分享連結。'
    },
    {
      question: '如何查看問卷結果？',
      answer: '在問卷列表中點擊對應問卷的「查看結果」按鈕，即可查看詳細的統計數據。'
    },
    {
      question: '忘記密碼怎麼辦？',
      answer: '點擊登入頁面的「忘記密碼」連結，按照指示進行密碼重置。'
    }
  ];
}
