table 60003 "SSD Pallet Type"
{
    Caption = 'Pallet Type';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Description)
        {
            Clustered = true;
        }
    }
}
