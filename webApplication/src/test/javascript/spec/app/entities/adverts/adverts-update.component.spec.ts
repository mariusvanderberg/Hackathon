/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { FoodsourceTestModule } from '../../../test.module';
import { AdvertsUpdateComponent } from 'app/entities/adverts/adverts-update.component';
import { AdvertsService } from 'app/entities/adverts/adverts.service';
import { Adverts } from 'app/shared/model/adverts.model';

describe('Component Tests', () => {
    describe('Adverts Management Update Component', () => {
        let comp: AdvertsUpdateComponent;
        let fixture: ComponentFixture<AdvertsUpdateComponent>;
        let service: AdvertsService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [AdvertsUpdateComponent]
            })
                .overrideTemplate(AdvertsUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(AdvertsUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(AdvertsService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new Adverts(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.adverts = entity;
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
                    const entity = new Adverts();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.adverts = entity;
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
