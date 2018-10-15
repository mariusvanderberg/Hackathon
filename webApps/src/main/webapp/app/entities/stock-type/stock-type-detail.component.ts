import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IStockType } from 'app/shared/model/stock-type.model';

@Component({
    selector: 'jhi-stock-type-detail',
    templateUrl: './stock-type-detail.component.html'
})
export class StockTypeDetailComponent implements OnInit {
    stockType: IStockType;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ stockType }) => {
            this.stockType = stockType;
        });
    }

    previousState() {
        window.history.back();
    }
}
