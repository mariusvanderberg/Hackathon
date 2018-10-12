import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IStock } from 'app/shared/model/stock.model';
import { StockService } from './stock.service';
import { IStockType } from 'app/shared/model/stock-type.model';
import { StockTypeService } from 'app/entities/stock-type';
import { IAdverts } from 'app/shared/model/adverts.model';
import { AdvertsService } from 'app/entities/adverts';
import { ISupplier } from 'app/shared/model/supplier.model';
import { SupplierService } from 'app/entities/supplier';

@Component({
    selector: 'jhi-stock-update',
    templateUrl: './stock-update.component.html'
})
export class StockUpdateComponent implements OnInit {
    private _stock: IStock;
    isSaving: boolean;

    stocktypes: IStockType[];

    adverts: IAdverts[];

    suppliers: ISupplier[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private stockService: StockService,
        private stockTypeService: StockTypeService,
        private advertsService: AdvertsService,
        private supplierService: SupplierService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ stock }) => {
            this.stock = stock;
        });
        this.stockTypeService.query({ filter: 'stock-is-null' }).subscribe(
            (res: HttpResponse<IStockType[]>) => {
                if (!this.stock.stocktype || !this.stock.stocktype.id) {
                    this.stocktypes = res.body;
                } else {
                    this.stockTypeService.find(this.stock.stocktype.id).subscribe(
                        (subRes: HttpResponse<IStockType>) => {
                            this.stocktypes = [subRes.body].concat(res.body);
                        },
                        (subRes: HttpErrorResponse) => this.onError(subRes.message)
                    );
                }
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.advertsService.query().subscribe(
            (res: HttpResponse<IAdverts[]>) => {
                this.adverts = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.supplierService.query().subscribe(
            (res: HttpResponse<ISupplier[]>) => {
                this.suppliers = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.stock.id !== undefined) {
            this.subscribeToSaveResponse(this.stockService.update(this.stock));
        } else {
            this.subscribeToSaveResponse(this.stockService.create(this.stock));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IStock>>) {
        result.subscribe((res: HttpResponse<IStock>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackStockTypeById(index: number, item: IStockType) {
        return item.id;
    }

    trackAdvertsById(index: number, item: IAdverts) {
        return item.id;
    }

    trackSupplierById(index: number, item: ISupplier) {
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
    get stock() {
        return this._stock;
    }

    set stock(stock: IStock) {
        this._stock = stock;
    }
}
