/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { FoodsourceTestModule } from '../../../test.module';
import { StockTypeDetailComponent } from 'app/entities/stock-type/stock-type-detail.component';
import { StockType } from 'app/shared/model/stock-type.model';

describe('Component Tests', () => {
    describe('StockType Management Detail Component', () => {
        let comp: StockTypeDetailComponent;
        let fixture: ComponentFixture<StockTypeDetailComponent>;
        const route = ({ data: of({ stockType: new StockType(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [StockTypeDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(StockTypeDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(StockTypeDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.stockType).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
