import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { IStockType } from 'app/shared/model/stock-type.model';
import { StockTypeService } from './stock-type.service';

@Component({
    selector: 'jhi-stock-type-update',
    templateUrl: './stock-type-update.component.html'
})
export class StockTypeUpdateComponent implements OnInit {
    private _stockType: IStockType;
    isSaving: boolean;

    constructor(private stockTypeService: StockTypeService, private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ stockType }) => {
            this.stockType = stockType;
        });
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.stockType.id !== undefined) {
            this.subscribeToSaveResponse(this.stockTypeService.update(this.stockType));
        } else {
            this.subscribeToSaveResponse(this.stockTypeService.create(this.stockType));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IStockType>>) {
        result.subscribe((res: HttpResponse<IStockType>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }
    get stockType() {
        return this._stockType;
    }

    set stockType(stockType: IStockType) {
        this._stockType = stockType;
    }
}
