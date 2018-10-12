import { Moment } from 'moment';
import { ISupplier } from 'app/shared/model//supplier.model';
import { IStock } from 'app/shared/model//stock.model';

export interface IAdverts {
    id?: number;
    text?: string;
    pricesPerStock?: number;
    units?: number;
    startdate?: Moment;
    endDate?: Moment;
    suppliers?: ISupplier[];
    stocks?: IStock[];
}

export class Adverts implements IAdverts {
    constructor(
        public id?: number,
        public text?: string,
        public pricesPerStock?: number,
        public units?: number,
        public startdate?: Moment,
        public endDate?: Moment,
        public suppliers?: ISupplier[],
        public stocks?: IStock[]
    ) {}
}
