import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { StockType } from 'app/shared/model/stock-type.model';
import { StockTypeService } from './stock-type.service';
import { StockTypeComponent } from './stock-type.component';
import { StockTypeDetailComponent } from './stock-type-detail.component';
import { StockTypeUpdateComponent } from './stock-type-update.component';
import { StockTypeDeletePopupComponent } from './stock-type-delete-dialog.component';
import { IStockType } from 'app/shared/model/stock-type.model';

@Injectable({ providedIn: 'root' })
export class StockTypeResolve implements Resolve<IStockType> {
    constructor(private service: StockTypeService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((stockType: HttpResponse<StockType>) => stockType.body));
        }
        return of(new StockType());
    }
}

export const stockTypeRoute: Routes = [
    {
        path: 'stock-type',
        component: StockTypeComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'StockTypes'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'stock-type/:id/view',
        component: StockTypeDetailComponent,
        resolve: {
            stockType: StockTypeResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'StockTypes'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'stock-type/new',
        component: StockTypeUpdateComponent,
        resolve: {
            stockType: StockTypeResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'StockTypes'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'stock-type/:id/edit',
        component: StockTypeUpdateComponent,
        resolve: {
            stockType: StockTypeResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'StockTypes'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const stockTypePopupRoute: Routes = [
    {
        path: 'stock-type/:id/delete',
        component: StockTypeDeletePopupComponent,
        resolve: {
            stockType: StockTypeResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'StockTypes'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
