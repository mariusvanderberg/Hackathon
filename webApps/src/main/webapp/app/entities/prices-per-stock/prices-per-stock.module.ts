import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { FoodsourceSharedModule } from 'app/shared';
import {
    PricesPerStockComponent,
    PricesPerStockDetailComponent,
    PricesPerStockUpdateComponent,
    PricesPerStockDeletePopupComponent,
    PricesPerStockDeleteDialogComponent,
    pricesPerStockRoute,
    pricesPerStockPopupRoute
} from './';

const ENTITY_STATES = [...pricesPerStockRoute, ...pricesPerStockPopupRoute];

@NgModule({
    imports: [FoodsourceSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        PricesPerStockComponent,
        PricesPerStockDetailComponent,
        PricesPerStockUpdateComponent,
        PricesPerStockDeleteDialogComponent,
        PricesPerStockDeletePopupComponent
    ],
    entryComponents: [
        PricesPerStockComponent,
        PricesPerStockUpdateComponent,
        PricesPerStockDeleteDialogComponent,
        PricesPerStockDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FoodsourcePricesPerStockModule {}
