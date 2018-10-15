import { IStock } from 'app/shared/model//stock.model';

export interface IPricesPerStock {
    id?: number;
    price?: number;
    unit?: string;
    stock?: IStock;
}

export class PricesPerStock implements IPricesPerStock {
    constructor(public id?: number, public price?: number, public unit?: string, public stock?: IStock) {}
}
