/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { FoodsourceTestModule } from '../../../test.module';
import { StockTypeDeleteDialogComponent } from 'app/entities/stock-type/stock-type-delete-dialog.component';
import { StockTypeService } from 'app/entities/stock-type/stock-type.service';

describe('Component Tests', () => {
    describe('StockType Management Delete Component', () => {
        let comp: StockTypeDeleteDialogComponent;
        let fixture: ComponentFixture<StockTypeDeleteDialogComponent>;
        let service: StockTypeService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [FoodsourceTestModule],
                declarations: [StockTypeDeleteDialogComponent]
            })
                .overrideTemplate(StockTypeDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(StockTypeDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(StockTypeService);
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
