import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

import { FoodsourceSupplierModule } from './supplier/supplier.module';
import { FoodsourceContactInfoModule } from './contact-info/contact-info.module';
import { FoodsourceStockTypeModule } from './stock-type/stock-type.module';
import { FoodsourceStockModule } from './stock/stock.module';
import { FoodsourcePricesPerStockModule } from './prices-per-stock/prices-per-stock.module';
import { FoodsourceAdvertsModule } from './adverts/adverts.module';
/* jhipster-needle-add-entity-module-import - JHipster will add entity modules imports here */

@NgModule({
    // prettier-ignore
    imports: [
        FoodsourceSupplierModule,
        FoodsourceContactInfoModule,
        FoodsourceStockTypeModule,
        FoodsourceStockModule,
        FoodsourcePricesPerStockModule,
        FoodsourceAdvertsModule,
        /* jhipster-needle-add-entity-module - JHipster will add entity modules here */
    ],
    declarations: [],
    entryComponents: [],
    providers: [],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FoodsourceEntityModule {}
