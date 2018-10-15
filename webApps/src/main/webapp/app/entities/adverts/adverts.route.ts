import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { Adverts } from 'app/shared/model/adverts.model';
import { AdvertsService } from './adverts.service';
import { AdvertsComponent } from './adverts.component';
import { AdvertsDetailComponent } from './adverts-detail.component';
import { AdvertsUpdateComponent } from './adverts-update.component';
import { AdvertsDeletePopupComponent } from './adverts-delete-dialog.component';
import { IAdverts } from 'app/shared/model/adverts.model';

@Injectable({ providedIn: 'root' })
export class AdvertsResolve implements Resolve<IAdverts> {
    constructor(private service: AdvertsService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((adverts: HttpResponse<Adverts>) => adverts.body));
        }
        return of(new Adverts());
    }
}

export const advertsRoute: Routes = [
    {
        path: 'adverts',
        component: AdvertsComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'Adverts'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'adverts/:id/view',
        component: AdvertsDetailComponent,
        resolve: {
            adverts: AdvertsResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'Adverts'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'adverts/new',
        component: AdvertsUpdateComponent,
        resolve: {
            adverts: AdvertsResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'Adverts'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'adverts/:id/edit',
        component: AdvertsUpdateComponent,
        resolve: {
            adverts: AdvertsResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'Adverts'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const advertsPopupRoute: Routes = [
    {
        path: 'adverts/:id/delete',
        component: AdvertsDeletePopupComponent,
        resolve: {
            adverts: AdvertsResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'Adverts'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
