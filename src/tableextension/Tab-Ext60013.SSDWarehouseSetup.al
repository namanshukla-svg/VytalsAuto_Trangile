tableextension 60013 "SSD Warehouse Setup" extends "Warehouse Setup"
{
    fields
    {
        field(60000; "SSD Pallet Planning Days"; DateFormula)
        {
            Caption = 'Pallet Planning Days';
            DataClassification = CustomerContent;
        }
        field(60001; "SSD Internal Instance"; Boolean)
        {
            Caption = 'Internal Instance';
            DataClassification = CustomerContent;
        }
    }
}
