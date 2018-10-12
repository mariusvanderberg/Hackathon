import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import * as moment from 'moment';
import { DATE_TIME_FORMAT } from 'app/shared/constants/input.constants';
import { JhiAlertService } from 'ng-jhipster';

import { IAdverts } from 'app/shared/model/adverts.model';
import { AdvertsService } from './adverts.service';
import { ISupplier } from 'app/shared/model/supplier.model';
import { SupplierService } from 'app/entities/supplier';
import { IStock } from 'app/shared/model/stock.model';
import { StockService } from 'app/entities/stock';

@Component({
    selector: 'jhi-adverts-update',
    templateUrl: './adverts-update.component.html'
})
export class AdvertsUpdateComponent implements OnInit {
    private _adverts: IAdverts;
    isSaving: boolean;

    suppliers: ISupplier[];

    stocks: IStock[];
    startdate: string;
    endDate: string;

    constructor(
        private jhiAlertService: JhiAlertService,
        private advertsService: AdvertsService,
        private supplierService: SupplierService,
        private stockService: StockService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ adverts }) => {
            this.adverts = adverts;
        });
        this.supplierService.query().subscribe(
            (res: HttpResponse<ISupplier[]>) => {
                this.suppliers = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.stockService.query().subscribe(
            (res: HttpResponse<IStock[]>) => {
                this.stocks = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        this.adverts.startdate = moment(this.startdate, DATE_TIME_FORMAT);
        this.adverts.endDate = moment(this.endDate, DATE_TIME_FORMAT);
        if (this.adverts.id !== undefined) {
            this.subscribeToSaveResponse(this.advertsService.update(this.adverts));
        } else {
            this.subscribeToSaveResponse(this.advertsService.create(this.adverts));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IAdverts>>) {
        result.subscribe((res: HttpResponse<IAdverts>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }

    private onError(errorMessage: string) {
        this.jhiAlertService.error(errorMessage, null, null);
    }

    trackSupplierById(index: number, item: ISupplier) {
        return item.id;
    }

    trackStockById(index: number, item: IStock) {
        return item.id;
    }

    getSelected(selectedVals: Array<any>, option: any) {
        if (selectedVals) {
            for (let i = 0; i < selectedVals.length; i++) {
                if (option.id === selectedVals[i].id) {
                    return selectedVals[i];
                }
            }
        }
        return option;
    }
    get adverts() {
        return this._adverts;
    }

    set adverts(adverts: IAdverts) {
        this._adverts = adverts;
        this.startdate = moment(adverts.startdate).format(DATE_TIME_FORMAT);
        this.endDate = moment(adverts.endDate).format(DATE_TIME_FORMAT);
    }
}
