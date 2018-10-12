import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IAdverts } from 'app/shared/model/adverts.model';

@Component({
    selector: 'jhi-adverts-detail',
    templateUrl: './adverts-detail.component.html'
})
export class AdvertsDetailComponent implements OnInit {
    adverts: IAdverts;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ adverts }) => {
            this.adverts = adverts;
        });
    }

    previousState() {
        window.history.back();
    }
}
