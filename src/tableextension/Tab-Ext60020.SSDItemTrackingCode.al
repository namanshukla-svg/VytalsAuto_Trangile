tableextension 60020 "SSD Item Tracking Code" extends "Item Tracking Code"
{
    fields
    {
        field(60000; "SSD Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }
}
