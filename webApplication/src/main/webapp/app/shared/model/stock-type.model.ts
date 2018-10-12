export interface IStockType {
    id?: number;
    variation?: string;
    description?: string;
    fruit?: boolean;
    vegtable?: boolean;
}

export class StockType implements IStockType {
    constructor(
        public id?: number,
        public variation?: string,
        public description?: string,
        public fruit?: boolean,
        public vegtable?: boolean
    ) {
        this.fruit = false;
        this.vegtable = false;
    }
}
