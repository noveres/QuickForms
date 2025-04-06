import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { MatTableModule } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatMenuModule } from '@angular/material/menu';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatChipsModule } from '@angular/material/chips';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatDialog } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule } from '@angular/forms';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { ConfirmDialogComponent } from '../../../shared/components/confirm-dialog/confirm-dialog.component';
import { QuestionnaireService } from '../../../shared/@services/questionnaire.service';
import { Questionnaire } from '../../../shared/@interface/question.models';
import { PreviewDialogComponent } from '../form/preview-dialog/preview-dialog.component';

@Component({
  selector: 'app-questionnaire-list',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatMenuModule,
    MatChipsModule,
    MatTooltipModule,
    MatProgressSpinnerModule,
    MatFormFieldModule,
    MatInputModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatSelectModule,
    FormsModule,
    MatPaginatorModule,
    PreviewDialogComponent
  ],
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss']
})
export class QuestionnaireListComponent implements OnInit {
  questionnaires: Questionnaire[] = [];
  filteredQuestionnaires: Questionnaire[] = [];
  displayedColumns: string[] = ['index', 'title', 'status', 'responseCount', 'createdAt', 'actions'];
  sortColumn: string = '';
  sortDirection: 'asc' | 'desc' = 'asc';
  isLoading = false;
  showBackToTop = false;

  // 分頁配置
  pageSize = 10;
  pageSizeOptions = [5, 10, 25, 50];
  currentPage = 0;
  pagedQuestionnaires: Questionnaire[] = [];

  // 篩選條件
  filterTitle = '';
  filterStartDate: Date | null = null;
  filterEndDate: Date | null = null;
  filterStatus = '';

  // 清空篩選條件
  clearFilters() {
    this.filterTitle = '';
    this.filterStartDate = null;
    this.filterEndDate = null;
    this.filterStatus = '';
    this.applyFilters();
  }

  statusOptions = [
    { value: '', label: '全部' },
    { value: 'DRAFT', label: '草稿' },
    { value: 'PUBLISHED', label: '已發布' },
    { value: 'CLOSED', label: '已結束' }
  ];

  constructor(
    private questionnaireService: QuestionnaireService,
    private snackBar: MatSnackBar,
    private router: Router,
    private dialog: MatDialog
  ) {}

  ngOnInit() {
    this.loadQuestionnaires();
    window.addEventListener('scroll', this.onWindowScroll.bind(this));
  }

  loadQuestionnaires() {
    this.isLoading = true;
    this.questionnaireService.getQuestionnaires().subscribe({
      next: (data) => {
        this.questionnaires = data;
        this.applyFilters();
        this.isLoading = false;
      },
      error: (error: Error) => {
        console.error('Error loading questionnaires:', error);
        this.snackBar.open('載入問卷失敗', '關閉', { duration: 3000 });
        this.isLoading = false;
      }
    });
  }

  applyFilters() {
    // 先為每個問卷添加原始序號
    this.questionnaires = this.questionnaires.map((questionnaire, index) => ({
      ...questionnaire,
      displayIndex: index + 1
    }));

    let filtered = this.questionnaires.filter((questionnaire) => {
      const displayIndex = (questionnaire.displayIndex || '').toString();
      const searchText = this.filterTitle.toLowerCase();
      const titleMatch = !this.filterTitle || 
        questionnaire.title.toLowerCase().includes(searchText) ||
        displayIndex.toLowerCase().includes(searchText);
      const statusMatch = !this.filterStatus || questionnaire.status === this.filterStatus;
      
      let dateMatch = true;
      if (this.filterStartDate || this.filterEndDate) {
        if (questionnaire.createdAt) {
          const createdDate = new Date(questionnaire.createdAt);
          if (this.filterStartDate && this.filterStartDate instanceof Date) {
            dateMatch = dateMatch && createdDate >= this.filterStartDate;
          }
          if (this.filterEndDate && this.filterEndDate instanceof Date) {
            dateMatch = dateMatch && createdDate <= this.filterEndDate;
          }
        } else {
          dateMatch = false;
        }
      }

      return titleMatch && statusMatch && dateMatch;
    });



    // 應用排序
    if (this.sortColumn) {
      filtered.sort((a, b) => {
        let comparison = 0;
        switch (this.sortColumn) {
          case 'index':
            const aIndex = filtered.findIndex(q => q.id === a.id) + 1;
            const bIndex = filtered.findIndex(q => q.id === b.id) + 1;
            comparison = aIndex - bIndex;
            break;
          case 'title':
            comparison = a.title.localeCompare(b.title);
            break;
          case 'responseCount':
            comparison = (a.responseCount || 0) - (b.responseCount || 0);
            break;
          case 'createdAt':
            const aDate = a.createdAt ? new Date(a.createdAt).getTime() : 0;
            const bDate = b.createdAt ? new Date(b.createdAt).getTime() : 0;
            comparison = aDate - bDate;
            break;
        }
        return this.sortDirection === 'asc' ? comparison : -comparison;
      });
    }

    this.filteredQuestionnaires = filtered;
    this.updatePagedData();
  }

  getStatusColor(status: string): string {
    switch (status) {
      case 'DRAFT':
        return 'accent';
      case 'PUBLISHED':
        return 'primary';
      default:
        return 'default';
    }
  }

  getStatusText(status: string): string {
    switch (status) {
      case 'DRAFT':
        return '草稿';
      case 'PUBLISHED':
        return '已發布';
        case 'CLOSED':
          return '已結束';
      default:
        return status;
    }
  }

  // 分頁事件處理
  onPageChange(event: PageEvent) {
    this.currentPage = event.pageIndex;
    this.pageSize = event.pageSize;
    this.updatePagedData();
  }

  // 更新分頁數據
  updatePagedData() {
    const startIndex = this.currentPage * this.pageSize;
    this.pagedQuestionnaires = this.filteredQuestionnaires.slice(startIndex, startIndex + this.pageSize);
  }

  formatDate(date: string): string {
    return new Date(date).toLocaleDateString('zh-TW', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }

  deleteQuestionnaire(id: number): void {
    // 先查找問卷，檢查狀態是否為已發布
    const questionnaire = this.filteredQuestionnaires.find(q => q.id === id);
    if (questionnaire && questionnaire.status === 'PUBLISHED') {
      this.snackBar.open('禁止刪除已發布的問卷', '關閉', { duration: 3000 });
      return;
    }
    
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: '警告',
        message: '確定要刪除這份問卷嗎？此操作不可恢復。'
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.questionnaireService.delete(id).subscribe({
          next: () => {
            this.loadQuestionnaires();
            this.snackBar.open('問卷已刪除', '關閉', { duration: 3000 });
          },
          error: (error) => {
            console.error('刪除問卷失敗:', error);
            this.snackBar.open('刪除問卷失敗', '關閉', { duration: 3000 });
          }
        });
      }
    });
  }

  publishQuestionnaire(id: number): void {
    // 先獲取問卷內容進行驗證
    this.questionnaireService.getQuestionnaire(id).subscribe({
      next: (questionnaire) => {
        // 驗證問卷內容
        const validationResult = this.validateQuestionnaire(questionnaire);
        if (!validationResult.isValid) {
          this.snackBar.open(`問卷驗證失敗: ${validationResult.message}`, '關閉', { duration: 3000 });
          return;
        }

        // 顯示確認對話框
        const dialogRef = this.dialog.open(ConfirmDialogComponent, {
          data: {
            title: '確認發布',
            message: '發布後的問卷將可以被填寫。確定要發布這份問卷嗎？',
            confirmText: '發布',
            cancelText: '取消'
          }
        });

        dialogRef.afterClosed().subscribe(result => {
         
          if (result) {
            this.isLoading = true;
            this.questionnaireService.publish(id).subscribe({
              next: () => {
                this.loadQuestionnaires();
                this.snackBar.open('問卷已發布', '關閉', { duration: 3000 });
              },
              error: (error) => {
                console.error('發布問卷失敗:', error);
                this.snackBar.open('發布問卷失敗', '關閉', { duration: 3000 });
              },
              complete: () => {
                this.isLoading = false;
              }
            });
          }
         
        });
      },
      error: (error) => {
        console.error('載入問卷失敗:', error);
        this.snackBar.open('載入問卷失敗', '關閉', { duration: 3000 });
      }
    });
  }

  unpublishQuestionnaire(id: number): void {
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: '確認取消發布',
        message: '取消發布後，問卷將無法被填寫。確定要取消發布嗎？',
        confirmText: '確定',
        cancelText: '取消'
      }
    });
  
    // 確認取消發布
    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.isLoading = true;
        this.questionnaireService.unpublish(id).subscribe({
          next: () => {
            this.loadQuestionnaires();
            this.snackBar.open('問卷已取消發布', '關閉', { duration: 3000 });
          },
          error: (error) => {
            console.error('取消發布問卷失敗:', error);
            this.snackBar.open('取消發布問卷失敗', '關閉', { duration: 3000 });
          },
          complete: () => {
            this.isLoading = false;
          }
        });
      }
    });
  }


  outQuestionnaire(id: number): void {
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: '確認結束問卷',
        message: '下架後，問卷將無法被填寫。確定要下架嗎？',
        confirmText: '確定',
        cancelText: '取消'
      }
    });
  

    
    // 確認結束問卷
    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.isLoading = true;
        this.questionnaireService.outQuestlise(id).subscribe({
          next: () => {
            this.loadQuestionnaires();
            this.snackBar.open('問卷已結束', '關閉', { duration: 3000 });
          },
          error: (error) => {
            console.error('結束問卷失敗:', error);
            this.snackBar.open('結束問卷失敗', '關閉', { duration: 3000 });
          },
          complete: () => {
            this.isLoading = false;
          }
        });
      }
    });
  }


  copyQuestionnaire(id: number): void {
    this.isLoading = true;
    this.questionnaireService.copy(id).subscribe({
      next: (copiedQuestionnaire) => {
        this.loadQuestionnaires();
        this.snackBar.open('問卷已複製', '關閉', { duration: 3000 });
        // 導航到編輯新複製的問卷
        // this.router.navigate(['/questionnaires/edit', copiedQuestionnaire.id]);
      },
      error: (error) => {
        console.error('複製問卷失敗:', error);
        let errorMessage = '複製問卷失敗';
        if (error.error?.message) {
          errorMessage += `: ${error.error.message}`;
        }
        this.snackBar.open(errorMessage, '關閉', { duration: 3000 });
      },
      complete: () => {
        this.isLoading = false;
      }
    });
  }

  private validateQuestionnaire(questionnaire: Questionnaire): { isValid: boolean; message: string } {
    // 檢查問卷標題
    if (!questionnaire.title?.trim()) {
      return { isValid: false, message: '問卷標題不能為空' };
    }

    // 檢查是否有區段
    if (!questionnaire.sections || questionnaire.sections.length === 0) {
      return { isValid: false, message: '問卷必須至少包含一個區段' };
    }

    // 檢查每個區段
    for (let i = 0; i < questionnaire.sections.length; i++) {
      const section = questionnaire.sections[i];
      
      // 檢查區段標題
      if (!section.title?.trim()) {
        return { isValid: false, message: `第 ${i + 1} 個區段的標題不能為空` };
      }

      // 檢查是否有問題
      if (!section.questions || section.questions.length === 0) {
        return { isValid: false, message: `第 ${i + 1} 個區段必須至少包含一個問題` };
      }

      // 檢查每個問題
      for (let j = 0; j < section.questions.length; j++) {
        const question = section.questions[j];

        // 檢查問題標題
        if (!question.label?.trim()) {
          return { isValid: false, message: `第 ${i + 1} 個區段的第 ${j + 1} 個問題的標題不能為空` };
        }

        // 檢查選擇題的選項
        if ((question.type === 'radio' || question.type === 'checkbox') && 
            (!question.options?.choices || Object.keys(question.options.choices).length === 0)) {
          return { isValid: false, message: `第 ${i + 1} 個區段的第 ${j + 1} 個問題必須包含至少一個選項` };
        }
      }
    }

    return { isValid: true, message: '' };
  }

  onRowClick(questionnaire: Questionnaire, event: Event): void {
    const target = event?.target as HTMLElement;

    // 如果點擊的是按鈕、連結，或者其父級元素包含按鈕/連結，則不進行導航
    if (target.closest('button, a')) {
      return;
    }
    
    if (questionnaire.status === 'DRAFT') {
      this.router.navigate(['/questionnaires/edit', questionnaire.id]);
    } else if (questionnaire.status === 'PUBLISHED' || questionnaire.status === 'CLOSED') {
      // 只顯示提示訊息，不再打開預覽對話框
      if (questionnaire.status === 'PUBLISHED') {
        this.snackBar.open('問卷已發布，不可修改', '關閉', { duration: 3000 });
      } else {
        this.router.navigate(['/questionnaires/statistics', questionnaire.id]);
      }
    }
  }

  // 排序處理
  sort(column: string) {
    if (this.sortColumn === column) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortColumn = column;
      this.sortDirection = 'asc';
    }
    this.applyFilters();
  }

  onWindowScroll(): void {
    this.showBackToTop = window.scrollY > 300;
  }

  scrollToTop(): void {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  async share(id: number) {
    try {
      const url = `${window.location.origin}/questionnaires/answer/${id}`;
      await navigator.clipboard.writeText(url);
      this.snackBar.open('已複製問卷連結！', '關閉', { duration: 2000 });
    } catch (error) {
      this.snackBar.open('複製失敗，請重試', '關閉', { duration: 2000 });
    }
  }
}
