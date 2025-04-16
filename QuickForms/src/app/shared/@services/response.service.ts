import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { QuestionnaireResponseDTO } from '../@interface/response.models';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ResponseService {
  private readonly API_URL = environment.apiUrl;

  constructor(private http: HttpClient) {}

  submitResponse(questionnaireId: number, response: QuestionnaireResponseDTO): Observable<void> {
    return this.http.post<void>(
      `${this.API_URL}/responses/questionnaires/${questionnaireId}`, 
      response
    );
  }
}
