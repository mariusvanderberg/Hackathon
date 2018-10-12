import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { NgbActiveModal, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { JhiEventManager } from 'ng-jhipster';

import { IContactInfo } from 'app/shared/model/contact-info.model';
import { ContactInfoService } from './contact-info.service';

@Component({
    selector: 'jhi-contact-info-delete-dialog',
    templateUrl: './contact-info-delete-dialog.component.html'
})
export class ContactInfoDeleteDialogComponent {
    contactInfo: IContactInfo;

    constructor(
        private contactInfoService: ContactInfoService,
        public activeModal: NgbActiveModal,
        private eventManager: JhiEventManager
    ) {}

    clear() {
        this.activeModal.dismiss('cancel');
    }

    confirmDelete(id: number) {
        this.contactInfoService.delete(id).subscribe(response => {
            this.eventManager.broadcast({
                name: 'contactInfoListModification',
                content: 'Deleted an contactInfo'
            });
            this.activeModal.dismiss(true);
        });
    }
}

@Component({
    selector: 'jhi-contact-info-delete-popup',
    template: ''
})
export class ContactInfoDeletePopupComponent implements OnInit, OnDestroy {
    private ngbModalRef: NgbModalRef;

    constructor(private activatedRoute: ActivatedRoute, private router: Router, private modalService: NgbModal) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ contactInfo }) => {
            setTimeout(() => {
                this.ngbModalRef = this.modalService.open(ContactInfoDeleteDialogComponent as Component, {
                    size: 'lg',
                    backdrop: 'static'
                });
                this.ngbModalRef.componentInstance.contactInfo = contactInfo;
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
