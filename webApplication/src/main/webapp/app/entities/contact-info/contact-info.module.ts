import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { FoodsourceSharedModule } from 'app/shared';
import {
    ContactInfoComponent,
    ContactInfoDetailComponent,
    ContactInfoUpdateComponent,
    ContactInfoDeletePopupComponent,
    ContactInfoDeleteDialogComponent,
    contactInfoRoute,
    contactInfoPopupRoute
} from './';

const ENTITY_STATES = [...contactInfoRoute, ...contactInfoPopupRoute];

@NgModule({
    imports: [FoodsourceSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        ContactInfoComponent,
        ContactInfoDetailComponent,
        ContactInfoUpdateComponent,
        ContactInfoDeleteDialogComponent,
        ContactInfoDeletePopupComponent
    ],
    entryComponents: [ContactInfoComponent, ContactInfoUpdateComponent, ContactInfoDeleteDialogComponent, ContactInfoDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FoodsourceContactInfoModule {}
