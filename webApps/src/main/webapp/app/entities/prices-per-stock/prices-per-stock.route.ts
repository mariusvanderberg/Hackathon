import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { PricesPerStock } from 'app/shared/model/prices-per-stock.model';
import { PricesPerStockService } from './prices-per-stock.service';
import { PricesPerStockComponent } from './prices-per-stock.component';
import { PricesPerStockDetailComponent } from './prices-per-stock-detail.component';
import { PricesPerStockUpdateComponent } from './prices-per-stock-update.component';
import { PricesPerStockDeletePopupComponent } from './prices-per-stock-delete-dialog.component';
import { IPricesPerStock } from 'app/shared/model/prices-per-stock.model';

@Injectable({ providedIn: 'root' })
export class PricesPerStockResolve implements Resolve<IPricesPerStock> {
    constructor(private service: PricesPerStockService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((pricesPerStock: HttpResponse<PricesPerStock>) => pricesPerStock.body));
        }
        return of(new PricesPerStock());
    }
}

export const pricesPerStockRoute: Routes = [
    {
        path: 'prices-per-stock',
        component: PricesPerStockComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'PricesPerStocks'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'prices-per-stock/:id/view',
        component: PricesPerStockDetailComponent,
        resolve: {
            pricesPerStock: PricesPerStockResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'PricesPerStocks'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'prices-per-stock/new',
        component: PricesPerStockUpdateComponent,
        resolve: {
            pricesPerStock: PricesPerStockResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'PricesPerStocks'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'prices-per-stock/:id/edit',
        component: PricesPerStockUpdateComponent,
        resolve: {
            pricesPerStock: PricesPerStockResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'PricesPerStocks'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const pricesPerStockPopupRoute: Routes = [
    {
        path: 'prices-per-stock/:id/delete',
        component: PricesPerStockDeletePopupComponent,
        resolve: {
            pricesPerStock: PricesPerStockResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'PricesPerStocks'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
