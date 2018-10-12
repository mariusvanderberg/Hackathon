import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { FoodsourceSharedModule } from 'app/shared';
import {
    StockTypeComponent,
    StockTypeDetailComponent,
    StockTypeUpdateComponent,
    StockTypeDeletePopupComponent,
    StockTypeDeleteDialogComponent,
    stockTypeRoute,
    stockTypePopupRoute
} from './';

const ENTITY_STATES = [...stockTypeRoute, ...stockTypePopupRoute];

@NgModule({
    imports: [FoodsourceSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        StockTypeComponent,
        StockTypeDetailComponent,
        StockTypeUpdateComponent,
        StockTypeDeleteDialogComponent,
        StockTypeDeletePopupComponent
    ],
    entryComponents: [StockTypeComponent, StockTypeUpdateComponent, StockTypeDeleteDialogComponent, StockTypeDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FoodsourceStockTypeModule {}
