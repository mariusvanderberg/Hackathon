import { Moment } from 'moment';
import { ISupplierType } from 'app/shared/model//supplier-type.model';

export interface ISupplier {
    id?: number;
    name?: string;
    dateCreated?: Moment;
    active?: boolean;
    regNumber?: string;
    supplierType?: ISupplierType;
}

export class Supplier implements ISupplier {
    constructor(
        public id?: number,
        public name?: string,
        public dateCreated?: Moment,
        public active?: boolean,
        public regNumber?: string,
        public supplierType?: ISupplierType
    ) {
        this.active = false;
    }
}
