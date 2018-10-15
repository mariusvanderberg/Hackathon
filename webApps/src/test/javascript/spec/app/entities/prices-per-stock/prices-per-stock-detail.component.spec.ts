/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { FoodsourceTestModule } from '../../../test.module';
import { PricesPerStockDetailComponent } from 'app/entities/prices-per-stock/prices-per-stock-detail.component';
import { PricesPerStock } from 'app/shared/model/prices-per-stock.model';

describe('Component Tests', () => {
    describe('PricesPerStock Management Detail Component', () => {
        let comp: PricesPerStockDetailComponent;
        let fixture: ComponentFixture<PricesPerStockDetailComponent>;
        const route = ({ data: of({ pricesPerStock: new PricesPerStock(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [PricesPerStockDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(PricesPerStockDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(PricesPerStockDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.pricesPerStock).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
