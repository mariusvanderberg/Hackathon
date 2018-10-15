/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { FoodsourceTestModule } from '../../../test.module';
import { AdvertsDetailComponent } from 'app/entities/adverts/adverts-detail.component';
import { Adverts } from 'app/shared/model/adverts.model';

describe('Component Tests', () => {
    describe('Adverts Management Detail Component', () => {
        let comp: AdvertsDetailComponent;
        let fixture: ComponentFixture<AdvertsDetailComponent>;
        const route = ({ data: of({ adverts: new Adverts(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [AdvertsDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(AdvertsDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(AdvertsDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.adverts).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
