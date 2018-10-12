/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { FoodsourceTestModule } from '../../../test.module';
import { StockTypeUpdateComponent } from 'app/entities/stock-type/stock-type-update.component';
import { StockTypeService } from 'app/entities/stock-type/stock-type.service';
import { StockType } from 'app/shared/model/stock-type.model';

describe('Component Tests', () => {
    describe('StockType Management Update Component', () => {
        let comp: StockTypeUpdateComponent;
        let fixture: ComponentFixture<StockTypeUpdateComponent>;
        let service: StockTypeService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [StockTypeUpdateComponent]
            })
                .overrideTemplate(StockTypeUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(StockTypeUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(StockTypeService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new StockType(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.stockType = entity;
                    // WHEN
                    comp.save();
                    tick(); // simulate async

                    // THEN
                    expect(service.update).toHaveBeenCalledWith(entity);
                    expect(comp.isSaving).toEqual(false);
                })
            );

            it(
                'Should call create service on save for new entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new StockType();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.stockType = entity;
                    // WHEN
                    comp.save();
                    tick(); // simulate async

                    // THEN
                    expect(service.create).toHaveBeenCalledWith(entity);
                    expect(comp.isSaving).toEqual(false);
                })
            );
        });
    });
});
