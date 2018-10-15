import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import * as moment from 'moment';
import { DATE_FORMAT } from 'app/shared/constants/input.constants';
import { map } from 'rxjs/operators';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IAdverts } from 'app/shared/model/adverts.model';

type EntityResponseType = HttpResponse<IAdverts>;
type EntityArrayResponseType = HttpResponse<IAdverts[]>;

@Injectable({ providedIn: 'root' })
export class AdvertsService {
    private resourceUrl = SERVER_API_URL + 'api/adverts';

    constructor(private http: HttpClient) {}

    create(adverts: IAdverts): Observable<EntityResponseType> {
        const copy = this.convertDateFromClient(adverts);
        return this.http
            .post<IAdverts>(this.resourceUrl, copy, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    update(adverts: IAdverts): Observable<EntityResponseType> {
        const copy = this.convertDateFromClient(adverts);
        return this.http
            .put<IAdverts>(this.resourceUrl, copy, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http
            .get<IAdverts>(`${this.resourceUrl}/${id}`, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http
            .get<IAdverts[]>(this.resourceUrl, { params: options, observe: 'response' })
            .pipe(map((res: EntityArrayResponseType) => this.convertDateArrayFromServer(res)));
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    private convertDateFromClient(adverts: IAdverts): IAdverts {
        const copy: IAdverts = Object.assign({}, adverts, {
            startdate: adverts.startdate != null && adverts.startdate.isValid() ? adverts.startdate.toJSON() : null,
            endDate: adverts.endDate != null && adverts.endDate.isValid() ? adverts.endDate.toJSON() : null
        });
        return copy;
    }

    private convertDateFromServer(res: EntityResponseType): EntityResponseType {
        res.body.startdate = res.body.startdate != null ? moment(res.body.startdate) : null;
        res.body.endDate = res.body.endDate != null ? moment(res.body.endDate) : null;
        return res;
    }

    private convertDateArrayFromServer(res: EntityArrayResponseType): EntityArrayResponseType {
        res.body.forEach((adverts: IAdverts) => {
            adverts.startdate = adverts.startdate != null ? moment(adverts.startdate) : null;
            adverts.endDate = adverts.endDate != null ? moment(adverts.endDate) : null;
        });
        return res;
    }
}
