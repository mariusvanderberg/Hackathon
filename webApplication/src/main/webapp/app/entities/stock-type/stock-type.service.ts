import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IStockType } from 'app/shared/model/stock-type.model';

type EntityResponseType = HttpResponse<IStockType>;
type EntityArrayResponseType = HttpResponse<IStockType[]>;

@Injectable({ providedIn: 'root' })
export class StockTypeService {
    private resourceUrl = SERVER_API_URL + 'api/stock-types';

    constructor(private http: HttpClient) {}

    create(stockType: IStockType): Observable<EntityResponseType> {
        return this.http.post<IStockType>(this.resourceUrl, stockType, { observe: 'response' });
    }

    update(stockType: IStockType): Observable<EntityResponseType> {
        return this.http.put<IStockType>(this.resourceUrl, stockType, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IStockType>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IStockType[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }
}
