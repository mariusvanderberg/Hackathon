import { IStockType } from 'app/shared/model//stock-type.model';
import { IPricesPerStock } from 'app/shared/model//prices-per-stock.model';
import { IAdverts } from 'app/shared/model//adverts.model';
import { ISupplier } from 'app/shared/model//supplier.model';

export const enum StockMeasurement {
    KG = 'KG',
    G = 'G'
}

export const enum StockStatus {
    ColdStorage = 'ColdStorage',
    RoomTemp = 'RoomTemp'
}

export interface IStock {
    id?: number;
    name?: string;
    description?: string;
    amount?: number;
    measure?: StockMeasurement;
    status?: StockStatus;
    stocktype?: IStockType;
    pricesperstocks?: IPricesPerStock[];
    adverts?: IAdverts[];
    suppliers?: ISupplier[];
}

export class Stock implements IStock {
    constructor(
        public id?: number,
        public name?: string,
        public description?: string,
        public amount?: number,
        public measure?: StockMeasurement,
        public status?: StockStatus,
        public stocktype?: IStockType,
        public pricesperstocks?: IPricesPerStock[],
        public adverts?: IAdverts[],
        public suppliers?: ISupplier[]
    ) {}
}
