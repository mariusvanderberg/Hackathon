import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IContactInfo } from 'app/shared/model/contact-info.model';

@Component({
    selector: 'jhi-contact-info-detail',
    templateUrl: './contact-info-detail.component.html'
})
export class ContactInfoDetailComponent implements OnInit {
    contactInfo: IContactInfo;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ contactInfo }) => {
            this.contactInfo = contactInfo;
        });
    }

    previousState() {
        window.history.back();
    }
}
