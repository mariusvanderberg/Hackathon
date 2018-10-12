import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IPricesPerStock } from 'app/shared/model/prices-per-stock.model';
import { PricesPerStockService } from './prices-per-stock.service';
import { IStock } from 'app/shared/model/stock.model';
import { StockService } from 'app/entities/stock';

@Component({
    selector: 'jhi-prices-per-stock-update',
    templateUrl: './prices-per-stock-update.component.html'
})
export class PricesPerStockUpdateComponent implements OnInit {
    private _pricesPerStock: IPricesPerStock;
    isSaving: boolean;

    stocks: IStock[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private pricesPerStockService: PricesPerStockService,
        private stockService: StockService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ pricesPerStock }) => {
            this.pricesPerStock = pricesPerStock;
        });
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
        if (this.pricesPerStock.id !== undefined) {
            this.subscribeToSaveResponse(this.pricesPerStockService.update(this.pricesPerStock));
        } else {
            this.subscribeToSaveResponse(this.pricesPerStockService.create(this.pricesPerStock));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IPricesPerStock>>) {
        result.subscribe((res: HttpResponse<IPricesPerStock>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackStockById(index: number, item: IStock) {
        return item.id;
    }
    get pricesPerStock() {
        return this._pricesPerStock;
    }

    set pricesPerStock(pricesPerStock: IPricesPerStock) {
        this._pricesPerStock = pricesPerStock;
    }
}
