import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IPricesPerStock } from 'app/shared/model/prices-per-stock.model';

@Component({
    selector: 'jhi-prices-per-stock-detail',
    templateUrl: './prices-per-stock-detail.component.html'
})
export class PricesPerStockDetailComponent implements OnInit {
    pricesPerStock: IPricesPerStock;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ pricesPerStock }) => {
            this.pricesPerStock = pricesPerStock;
        });
    }

    previousState() {
        window.history.back();
    }
}
