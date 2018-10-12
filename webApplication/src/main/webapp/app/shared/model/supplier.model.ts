import { IContactInfo } from 'app/shared/model//contact-info.model';
import { IAdverts } from 'app/shared/model//adverts.model';
import { IStock } from 'app/shared/model//stock.model';

export interface ISupplier {
    id?: number;
    name?: string;
    surname?: string;
    regNumber?: string;
    active?: boolean;
    contactInfo?: IContactInfo;
    adverts?: IAdverts[];
    stocks?: IStock[];
}

export class Supplier implements ISupplier {
    constructor(
        public id?: number,
        public name?: string,
        public surname?: string,
        public regNumber?: string,
        public active?: boolean,
        public contactInfo?: IContactInfo,
        public adverts?: IAdverts[],
        public stocks?: IStock[]
    ) {
        this.active = false;
    }
}
