tableextension 60016 "SSD ProdOrder Component" extends "Prod. Order Component"
{
    fields
    {
        field(60004; "SSD Consumption Station";Enum "SSD Production Station")
        {
            Caption = 'Consumption Station';
            DataClassification = CustomerContent;
        }
        field(60005; "SSD WMS Request Sent"; Boolean)
        {
            Caption = 'WMS Request Sent';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}