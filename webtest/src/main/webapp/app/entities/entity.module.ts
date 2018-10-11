import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

import { FoodsourceSupplierModule } from './supplier/supplier.module';
import { FoodsourceSupplierTypeModule } from './supplier-type/supplier-type.module';
/* jhipster-needle-add-entity-module-import - JHipster will add entity modules imports here */

@NgModule({
    // prettier-ignore
    imports: [
        FoodsourceSupplierModule,
        FoodsourceSupplierTypeModule,
        /* jhipster-needle-add-entity-module - JHipster will add entity modules here */
    ],
    declarations: [],
    entryComponents: [],
    providers: [],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FoodsourceEntityModule {}
