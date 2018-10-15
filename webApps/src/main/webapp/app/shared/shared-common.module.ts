import { NgModule } from '@angular/core';

import { FoodsourceSharedLibsModule, JhiAlertComponent, JhiAlertErrorComponent } from './';

@NgModule({
    imports: [FoodsourceSharedLibsModule],
    declarations: [JhiAlertComponent, JhiAlertErrorComponent],
    exports: [FoodsourceSharedLibsModule, JhiAlertComponent, JhiAlertErrorComponent]
})
export class FoodsourceSharedCommonModule {}
