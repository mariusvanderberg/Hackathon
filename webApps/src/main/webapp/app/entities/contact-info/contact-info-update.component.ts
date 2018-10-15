import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { IContactInfo } from 'app/shared/model/contact-info.model';
import { ContactInfoService } from './contact-info.service';

@Component({
    selector: 'jhi-contact-info-update',
    templateUrl: './contact-info-update.component.html'
})
export class ContactInfoUpdateComponent implements OnInit {
    private _contactInfo: IContactInfo;
    isSaving: boolean;

    constructor(private contactInfoService: ContactInfoService, private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ contactInfo }) => {
            this.contactInfo = contactInfo;
        });
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.contactInfo.id !== undefined) {
            this.subscribeToSaveResponse(this.contactInfoService.update(this.contactInfo));
        } else {
            this.subscribeToSaveResponse(this.contactInfoService.create(this.contactInfo));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IContactInfo>>) {
        result.subscribe((res: HttpResponse<IContactInfo>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }
    get contactInfo() {
        return this._contactInfo;
    }

    set contactInfo(contactInfo: IContactInfo) {
        this._contactInfo = contactInfo;
    }
}
