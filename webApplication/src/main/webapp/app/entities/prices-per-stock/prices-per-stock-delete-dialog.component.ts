import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { NgbActiveModal, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { JhiEventManager } from 'ng-jhipster';

import { IPricesPerStock } from 'app/shared/model/prices-per-stock.model';
import { PricesPerStockService } from './prices-per-stock.service';

@Component({
    selector: 'jhi-prices-per-stock-delete-dialog',
    templateUrl: './prices-per-stock-delete-dialog.component.html'
})
export class PricesPerStockDeleteDialogComponent {
    pricesPerStock: IPricesPerStock;

    constructor(
        private pricesPerStockService: PricesPerStockService,
        public activeModal: NgbActiveModal,
        private eventManager: JhiEventManager
    ) {}

    clear() {
        this.activeModal.dismiss('cancel');
    }

    confirmDelete(id: number) {
        this.pricesPerStockService.delete(id).subscribe(response => {
            this.eventManager.broadcast({
                name: 'pricesPerStockListModification',
                content: 'Deleted an pricesPerStock'
            });
            this.activeModal.dismiss(true);
        });
    }
}

@Component({
    selector: 'jhi-prices-per-stock-delete-popup',
    template: ''
})
export class PricesPerStockDeletePopupComponent implements OnInit, OnDestroy {
    private ngbModalRef: NgbModalRef;

    constructor(private activatedRoute: ActivatedRoute, private router: Router, private modalService: NgbModal) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ pricesPerStock }) => {
            setTimeout(() => {
                this.ngbModalRef = this.modalService.open(PricesPerStockDeleteDialogComponent as Component, {
                    size: 'lg',
                    backdrop: 'static'
                });
                this.ngbModalRef.componentInstance.pricesPerStock = pricesPerStock;
                this.ngbModalRef.result.then(
                    result => {
                        this.router.navigate([{ outlets: { popup: null } }], { replaceUrl: true, queryParamsHandling: 'merge' });
                        this.ngbModalRef = null;
                    },
                    reason => {
                        this.router.navigate([{ outlets: { popup: null } }], { replaceUrl: true, queryParamsHandling: 'merge' });
                        this.ngbModalRef = null;
                    }
                );
            }, 0);
        });
    }

    ngOnDestroy() {
        this.ngbModalRef = null;
    }
}
