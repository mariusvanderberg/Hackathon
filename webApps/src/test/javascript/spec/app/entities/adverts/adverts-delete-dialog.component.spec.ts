/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { FoodsourceTestModule } from '../../../test.module';
import { AdvertsDeleteDialogComponent } from 'app/entities/adverts/adverts-delete-dialog.component';
import { AdvertsService } from 'app/entities/adverts/adverts.service';

describe('Component Tests', () => {
    describe('Adverts Management Delete Component', () => {
        let comp: AdvertsDeleteDialogComponent;
        let fixture: ComponentFixture<AdvertsDeleteDialogComponent>;
        let service: AdvertsService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [AdvertsDeleteDialogComponent]
            })
                .overrideTemplate(AdvertsDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(AdvertsDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(AdvertsService);
            mockEventManager = fixture.debugElement.injector.get(JhiEventManager);
            mockActiveModal = fixture.debugElement.injector.get(NgbActiveModal);
        });

        describe('confirmDelete', () => {
            it(
                'Should call delete service on confirmDelete',
                inject(
                    [],
                    fakeAsync(() => {
                        // GIVEN
                        spyOn(service, 'delete').and.returnValue(of({}));

                        // WHEN
                        comp.confirmDelete(123);
                        tick();

                        // THEN
                        expect(service.delete).toHaveBeenCalledWith(123);
                        expect(mockActiveModal.dismissSpy).toHaveBeenCalled();
                        expect(mockEventManager.broadcastSpy).toHaveBeenCalled();
                    })
                )
            );
        });
    });
});
