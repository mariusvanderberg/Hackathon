import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { ISupplier } from 'app/shared/model/supplier.model';
import { SupplierService } from './supplier.service';
import { IContactInfo } from 'app/shared/model/contact-info.model';
import { ContactInfoService } from 'app/entities/contact-info';
import { IAdverts } from 'app/shared/model/adverts.model';
import { AdvertsService } from 'app/entities/adverts';
import { IStock } from 'app/shared/model/stock.model';
import { StockService } from 'app/entities/stock';

@Component({
    selector: 'jhi-supplier-update',
    templateUrl: './supplier-update.component.html'
})
export class SupplierUpdateComponent implements OnInit {
    private _supplier: ISupplier;
    isSaving: boolean;

    contactinfos: IContactInfo[];

    adverts: IAdverts[];

    stocks: IStock[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private supplierService: SupplierService,
        private contactInfoService: ContactInfoService,
        private advertsService: AdvertsService,
        private stockService: StockService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ supplier }) => {
            this.supplier = supplier;
        });
        this.contactInfoService.query({ filter: 'supplier-is-null' }).subscribe(
            (res: HttpResponse<IContactInfo[]>) => {
                if (!this.supplier.contactInfo || !this.supplier.contactInfo.id) {
                    this.contactinfos = res.body;
                } else {
                    this.contactInfoService.find(this.supplier.contactInfo.id).subscribe(
                        (subRes: HttpResponse<IContactInfo>) => {
                            this.contactinfos = [subRes.body].concat(res.body);
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
        if (this.supplier.id !== undefined) {
            this.subscribeToSaveResponse(this.supplierService.update(this.supplier));
        } else {
            this.subscribeToSaveResponse(this.supplierService.create(this.supplier));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<ISupplier>>) {
        result.subscribe((res: HttpResponse<ISupplier>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackContactInfoById(index: number, item: IContactInfo) {
        return item.id;
    }

    trackAdvertsById(index: number, item: IAdverts) {
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
    get supplier() {
        return this._supplier;
    }

    set supplier(supplier: ISupplier) {
        this._supplier = supplier;
    }
}
