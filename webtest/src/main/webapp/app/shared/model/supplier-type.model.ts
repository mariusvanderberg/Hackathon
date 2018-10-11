export interface ISupplierType {
    id?: number;
    name?: number;
    redistributor?: boolean;
}

export class SupplierType implements ISupplierType {
    constructor(public id?: number, public name?: number, public redistributor?: boolean) {
        this.redistributor = false;
    }
}
