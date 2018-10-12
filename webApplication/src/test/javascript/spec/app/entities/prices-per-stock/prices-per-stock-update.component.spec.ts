/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { FoodsourceTestModule } from '../../../test.module';
import { PricesPerStockUpdateComponent } from 'app/entities/prices-per-stock/prices-per-stock-update.component';
import { PricesPerStockService } from 'app/entities/prices-per-stock/prices-per-stock.service';
import { PricesPerStock } from 'app/shared/model/prices-per-stock.model';

describe('Component Tests', () => {
    describe('PricesPerStock Management Update Component', () => {
        let comp: PricesPerStockUpdateComponent;
        let fixture: ComponentFixture<PricesPerStockUpdateComponent>;
        let service: PricesPerStockService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [PricesPerStockUpdateComponent]
            })
                .overrideTemplate(PricesPerStockUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(PricesPerStockUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(PricesPerStockService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new PricesPerStock(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.pricesPerStock = entity;
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
                    const entity = new PricesPerStock();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.pricesPerStock = entity;
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
