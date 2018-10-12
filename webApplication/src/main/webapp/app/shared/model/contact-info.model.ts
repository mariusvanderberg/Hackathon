export interface IContactInfo {
    id?: number;
    name?: string;
    street1?: string;
    street2?: string;
    suburb?: string;
    city?: string;
    postalCode?: string;
    country?: string;
    emailaddress?: string;
    cellno?: number;
}

export class ContactInfo implements IContactInfo {
    constructor(
        public id?: number,
        public name?: string,
        public street1?: string,
        public street2?: string,
        public suburb?: string,
        public city?: string,
        public postalCode?: string,
        public country?: string,
        public emailaddress?: string,
        public cellno?: number
    ) {}
}
