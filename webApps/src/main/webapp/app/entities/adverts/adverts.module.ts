import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { FoodsourceSharedModule } from 'app/shared';
import {
    AdvertsComponent,
    AdvertsDetailComponent,
    AdvertsUpdateComponent,
    AdvertsDeletePopupComponent,
    AdvertsDeleteDialogComponent,
    advertsRoute,
    advertsPopupRoute
} from './';

const ENTITY_STATES = [...advertsRoute, ...advertsPopupRoute];

@NgModule({
    imports: [FoodsourceSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        AdvertsComponent,
        AdvertsDetailComponent,
        AdvertsUpdateComponent,
        AdvertsDeleteDialogComponent,
        AdvertsDeletePopupComponent
    ],
    entryComponents: [AdvertsComponent, AdvertsUpdateComponent, AdvertsDeleteDialogComponent, AdvertsDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FoodsourceAdvertsModule {}
