tableextension 60014 "SSD Warehouse Request" extends "Warehouse Request"
{
    fields
    {
        field(60000; "SSD Destination Name"; Text[100])
        {
            Caption = 'SSD Destination Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
