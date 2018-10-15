import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IPricesPerStock } from 'app/shared/model/prices-per-stock.model';

type EntityResponseType = HttpResponse<IPricesPerStock>;
type EntityArrayResponseType = HttpResponse<IPricesPerStock[]>;

@Injectable({ providedIn: 'root' })
export class PricesPerStockService {
    private resourceUrl = SERVER_API_URL + 'api/prices-per-stocks';

    constructor(private http: HttpClient) {}

    create(pricesPerStock: IPricesPerStock): Observable<EntityResponseType> {
        return this.http.post<IPricesPerStock>(this.resourceUrl, pricesPerStock, { observe: 'response' });
    }

    update(pricesPerStock: IPricesPerStock): Observable<EntityResponseType> {
        return this.http.put<IPricesPerStock>(this.resourceUrl, pricesPerStock, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IPricesPerStock>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IPricesPerStock[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }
}
