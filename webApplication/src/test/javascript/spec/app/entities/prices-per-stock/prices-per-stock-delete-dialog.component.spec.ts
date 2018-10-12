/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { FoodsourceTestModule } from '../../../test.module';
import { PricesPerStockDeleteDialogComponent } from 'app/entities/prices-per-stock/prices-per-stock-delete-dialog.component';
import { PricesPerStockService } from 'app/entities/prices-per-stock/prices-per-stock.service';

describe('Component Tests', () => {
    describe('PricesPerStock Management Delete Component', () => {
        let comp: PricesPerStockDeleteDialogComponent;
        let fixture: ComponentFixture<PricesPerStockDeleteDialogComponent>;
        let service: PricesPerStockService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [PricesPerStockDeleteDialogComponent]
            })
                .overrideTemplate(PricesPerStockDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(PricesPerStockDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(PricesPerStockService);
            mockEventManager = fixture.debugElement.injector.get(JhiEventManager);
            mockActiveModal = fixture.debugElement.injector.get(NgbActiveModal);
        });

        describe('confirmDelete', () => {
            it('Should call delete service on confirmDelete', inject(
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
            ));
        });
    });
});
